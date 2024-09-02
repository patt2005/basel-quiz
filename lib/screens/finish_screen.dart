import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';

class FinishScreen extends StatelessWidget {
  const FinishScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.3),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 30,
                    horizontal: 80,
                  ),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 6),
                    ],
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/ui/intro_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: const Column(
                    children: [
                      Text(
                        "That's all the questions for today. See you tomorrow, lucky one!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 28,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
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
