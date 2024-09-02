import 'package:basel_quiz_app/models/story.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';

class StoryScreen extends StatelessWidget {
  final Story story;

  const StoryScreen({
    super.key,
    required this.story,
  });

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
                SizedBox(height: screenSize.height * 0.2),
                Container(
                  padding: const EdgeInsets.all(20),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(25),
                    image: const DecorationImage(
                      image: AssetImage("assets/images/ui/intro_image.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: Column(
                    children: [
                      Text(
                        story.title,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        story.text,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 18,
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
