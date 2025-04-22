import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rd_music_player/app/auth/application/m_auth_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final provider = context.read<MAuthProvider>();
      await provider.fetchLocalVersions();
      Future.delayed(const Duration(milliseconds: 2000), () async {
        final versionDetails = await provider.getVersionDetails();
        if (versionDetails != null) {
          provider.checkVersionAndShowUpdate(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<MAuthProvider>();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Center(
            child: Image.asset(
              "assets/images/splash_icon.gif",
              height: 250.0,
              repeat: ImageRepeat.noRepeat,
              width: 250.0,
            ),
          ),
          if (provider.versionName?.isNotEmpty ?? false)
            Positioned(
                left: 0,
                right: 0,
                bottom: 20,
                child: Center(
                    child: Text(
                  'V - ${provider.versionName}',
                  style: const TextStyle(fontSize: 16, color: Colors.white38, fontWeight: FontWeight.w500),
                )))
        ],
      ),
    );
  }
}
