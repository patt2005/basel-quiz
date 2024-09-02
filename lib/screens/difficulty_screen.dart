import 'package:basel_quiz_app/screens/categories_screen.dart';
import 'package:basel_quiz_app/screens/hard_quiz_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';

class DifficultyScreen extends StatelessWidget {
  const DifficultyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Container(),
      ),
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GoldButton(
                        text: "Easy",
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const CategoriesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 15),
                      GoldButton(
                        text: "Hard",
                        onPressed: () async {
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HardQuizScreen(
                                categoryId: "cathedrals",
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
                GoldButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(height: screenSize.height * 0.05),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
