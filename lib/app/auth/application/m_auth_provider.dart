import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:rd_music_player/utils/Utils.dart';
import 'package:rd_music_player/utils/theme.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../home/presentation/home_page.dart';
import '../models/version_details.dart';

class MAuthProvider extends ChangeNotifier {
  FirebaseFirestore db = FirebaseFirestore.instance;
  VersionDetails? versionDetails;
  String? versionName;
  int versionCode = 0;

  Future<VersionDetails?> getVersionDetails() async {
    final snapshot = await db.collection("tbl_version").get();
    for (var doc in snapshot.docs) {
      versionDetails = VersionDetails.fromJson(doc.data());
      return versionDetails;
    }
    return null;
  }

  Future<void> fetchLocalVersions() async {
    final info = await PackageInfo.fromPlatform();
    versionCode = int.tryParse(info.buildNumber) ?? 1;
    versionName = info.version;
    notifyListeners();
  }

  Future<void> checkVersionAndShowUpdate(BuildContext context) async {
    if (Platform.isAndroid) {
      if ((versionDetails?.androidVersionCode ?? 0) > versionCode) {
        showUpdateBottomSheet(context, versionDetails?.isAndroidForceUpdate);
      } else if (versionDetails?.androidShowPrompt ?? false) {
        showPromptMsgBottomSheet(context, versionDetails?.androidPrompt);
      } else {
        navigateToHome(context);
      }
    } else if (Platform.isIOS) {
      /*if ((versionDetails?.iosVersionCode ?? 0) > versionCode) {
        showUpdateBottomSheet(context, versionDetails?.isIosForceUpdate);
      } else*/
      if (versionDetails?.iosShowPrompt ?? false) {
        showPromptMsgBottomSheet(context, versionDetails?.iosPrompt);
      } else {
        navigateToHome(context);
      }
    }
  }

  void showUpdateBottomSheet(BuildContext parentContext, bool? isForceUpdate) {
    showModalBottomSheet(
      backgroundColor: rBgColor,
      context: parentContext,
      isScrollControlled: true,
      isDismissible: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        final provider = context.watch<MAuthProvider>();

        return Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/app_update.json',
                height: 180,
                repeat: true,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 20),
              Text(
                "Update Available",
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "We've made improvements and added new features to give you a better experience. Please update to the latest version.",
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: () {
                  if (Platform.isAndroid) {
                    openDriveLinkInBrowser(provider.versionDetails?.androidLink ?? "");
                  } else if (Platform.isIOS) {
                    Navigator.of(context).pop();
                    navigateToHome(parentContext);
                  }
                },
                icon: const Icon(Icons.cloud_download_rounded),
                label: const Text("Update Now"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              if (isForceUpdate == false)
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    navigateToHome(parentContext);
                  },
                  child: Text("Maybe Later", style: TextStyle(fontSize: 14, color: Colors.grey[500])),
                ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void showPromptMsgBottomSheet(BuildContext parentContext, String? prompt) {
    showModalBottomSheet(
      backgroundColor: rBgColor,
      context: parentContext,
      isDismissible: false,
      isScrollControlled: false,
      enableDrag: false,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Lottie.asset(
                'assets/lottie/message.json',
                height: 130,
                repeat: true,
                fit: BoxFit.contain,
              ),
              const SizedBox(height: 5),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      textAlign: TextAlign.center,
                      "You have a message from developer!",
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                prompt ?? 'Glad to see you again!',
                textAlign: TextAlign.center,
                style: GoogleFonts.poppins(
                  fontSize: 16,
                  color: Colors.grey[500],
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.of(context).pop();
                  navigateToHome(parentContext);
                },
                icon: const Icon(Icons.info_outline_rounded),
                label: const Text("Got It!"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.black26,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  textStyle: const TextStyle(fontSize: 16),
                ),
              ),
              const SizedBox(height: 10),
            ],
          ),
        );
      },
    );
  }

  void navigateToHome(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      dPrint(' ${context.mounted}');
      if (context.mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    });
  }

  Future<void> openDriveLinkInBrowser(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
      webOnlyWindowName: '_blank',
    )) {
      throw Exception('Could not launch $url');
    }
  }
}
