import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/screens/home_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarBrightness: Brightness.dark,
    statusBarColor: Colors.transparent,
    systemNavigationBarIconBrightness: Brightness.dark,
  ));
  FlameAudio.bgm.initialize();
  await FlameAudio.bgm.play(
    'music.mp3',
    volume: musicVolume,
  );
  runApp(
    ChangeNotifierProvider(
      child: const MyApp(),
      create: (context) => GameProvider(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    screenSize = MediaQuery.of(context).size;
    Provider.of<GameProvider>(context).loadProgess();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: "Inter"),
      home: const HomeScreen(),
    );
  }
}
