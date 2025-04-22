import 'dart:convert';

import 'package:audio_service/audio_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:provider/provider.dart';
import 'package:rd_music_player/app/auth/application/m_auth_provider.dart';
import 'package:rd_music_player/app/auth/presentation/splash_screen.dart';
import 'package:rd_music_player/utils/Utils.dart';

import 'app/home/application/music_provider.dart';
import 'firebase_options.dart';

late AudioHandler _audioHandler; // singleton.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.rd.music.player.audio',
    androidNotificationChannelName: 'RD_Playback',
    androidNotificationOngoing: true,
  );

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    await FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException catch (e) {
    dPrint('Fail to Authenticate : ${e.message}');
  }
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => MusicProvider()),
        ChangeNotifierProvider(create: (_) => MAuthProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'RD PLayer',
      theme: ThemeData.dark(),
      home: const SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
