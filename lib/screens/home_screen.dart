import 'package:basel_quiz_app/screens/difficulty_screen.dart';
import 'package:basel_quiz_app/screens/progress_screen.dart';
import 'package:basel_quiz_app/screens/settings_screen.dart';
import 'package:basel_quiz_app/screens/true_false_quiz_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          Column(
            children: [
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  ),
                  image: DecorationImage(
                    image: AssetImage("assets/images/ui/home_image.png"),
                    fit: BoxFit.cover,
                  ),
                ),
                width: screenSize.width,
                height: screenSize.height * 0.33,
              ),
              SizedBox(height: screenSize.height * 0.04),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    const Text(
                      "Basel Landmarks\nQuiz",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 35,
                      ),
                    ),
                    SizedBox(height: screenSize.height * 0.05),
                    GoldButton(
                      text: "New Game",
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const DifficultyScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    GoldButton(
                      text: "Results",
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProgressScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    GoldButton(
                      text: "Settings",
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const SettingsScreen(),
                          ),
                        );
                      },
                    ),
                    SizedBox(height: screenSize.height * 0.025),
                    GoldButton(
                      text: "Daily Quests",
                      onPressed: () async {
                        await Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const TrueFalseQuizScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
