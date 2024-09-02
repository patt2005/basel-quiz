import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LoseScreen extends StatefulWidget {
  const LoseScreen({super.key});

  @override
  State<LoseScreen> createState() => _LoseScreenState();
}

class _LoseScreenState extends State<LoseScreen> {
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
            provider.hardModeTotalCoins.toString(),
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
                Container(
                  padding: const EdgeInsets.all(35),
                  width: screenSize.width,
                  decoration: BoxDecoration(
                    boxShadow: const [
                      BoxShadow(color: Colors.white, blurRadius: 6),
                    ],
                    image: const DecorationImage(
                      image: AssetImage("assets/images/ui/intro_image.png"),
                      fit: BoxFit.cover,
                    ),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Center(
                    child: Text(
                      "Time has already\nrun out!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 33,
                      ),
                    ),
                  ),
                ),
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
