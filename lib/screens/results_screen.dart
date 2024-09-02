import 'dart:convert';
import 'package:basel_quiz_app/models/story.dart';
import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/screens/story_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class ResultsScreen extends StatefulWidget {
  final String categoryId;
  final String mode;

  const ResultsScreen({
    super.key,
    required this.categoryId,
    required this.mode,
  });

  @override
  State<ResultsScreen> createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  Story? _story;

  Widget _buildCoinsCard(BuildContext context) {
    final provider = Provider.of<GameProvider>(context, listen: false);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 50),
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6,
          )
        ],
        borderRadius: BorderRadius.circular(35),
        gradient: const LinearGradient(
          colors: [Colors.yellow, Colors.orange, Colors.yellow],
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            widget.mode == "easy"
                ? provider.easyModeTotalCoins.toString()
                : provider.hardModeTotalCoins.toString(),
            style: const TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          Image.asset(
            "assets/images/ui/gold.png",
            width: 60,
            height: 60,
          ),
        ],
      ),
    );
  }

  Widget _buildStoryCard() {
    return Container(
      width: screenSize.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(color: Colors.white, blurRadius: 6),
        ],
        borderRadius: BorderRadius.circular(25),
        image: const DecorationImage(
          fit: BoxFit.cover,
          image: AssetImage("assets/images/ui/intro_image.png"),
        ),
      ),
      padding: const EdgeInsets.all(25),
      child: Column(
        children: [
          const Text(
            "An interesting story about\nthe city is available to you!",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 21,
            ),
          ),
          const SizedBox(height: 20),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadiusDirectional.circular(25),
              gradient: const LinearGradient(
                colors: [secondGoldColor, firstGoldColor, secondGoldColor],
              ),
            ),
            child: ElevatedButton(
              style: ButtonStyle(
                elevation: const WidgetStatePropertyAll(0),
                backgroundColor: const WidgetStatePropertyAll(
                  Colors.transparent,
                ),
                shape: WidgetStatePropertyAll(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadiusDirectional.circular(25),
                  ),
                ),
              ),
              onPressed: () async {
                await Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => StoryScreen(story: _story!),
                  ),
                );
              },
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Read",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.w600,
                      fontSize: 19,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _init() async {
    final jsonData = await rootBundle.loadString("assets/data/stories.json");
    final Map<String, dynamic> data = jsonDecode(jsonData);
    _story = Story(
      text: data["stories"][widget.categoryId]["text"],
      title: data["stories"][widget.categoryId]["title"],
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.08),
                ClipRRect(
                  borderRadius: BorderRadius.circular(25),
                  child: Image.asset(
                    "assets/images/ui/profile_image.png",
                    width: screenSize.width,
                    fit: BoxFit.cover,
                    height: screenSize.height * 0.25,
                  ),
                ),
                SizedBox(height: screenSize.height * 0.03),
                _buildCoinsCard(context),
                SizedBox(height: screenSize.height * 0.04),
                _buildStoryCard(),
                const Spacer(),
                GoldButton(
                  text: "Try Again",
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                const SizedBox(height: 15),
                GoldButton(
                  text: "Back",
                  onPressed: () {
                    Navigator.of(context).pop();
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
