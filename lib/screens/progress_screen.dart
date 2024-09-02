import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<GameProvider>(context, listen: false);

    return Scaffold(
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
                SizedBox(height: screenSize.height * 0.1),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: Colors.white, blurRadius: 6),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/images/ui/intro_image.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Easy",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(13),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(color: Colors.white, blurRadius: 6),
                          ],
                          borderRadius: BorderRadius.circular(30),
                          image: const DecorationImage(
                            image:
                                AssetImage("assets/images/ui/intro_image.png"),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "Hard",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: screenSize.height * 0.02),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 6,
                            )
                          ],
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.yellow,
                              Colors.orange,
                              Colors.yellow
                            ],
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              provider.easyModeTotalCoins.toString(),
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 25,
                              ),
                            ),
                            Image.asset(
                              "assets/images/ui/gold.png",
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 40),
                        decoration: BoxDecoration(
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.white,
                              blurRadius: 6,
                            )
                          ],
                          borderRadius: BorderRadius.circular(35),
                          gradient: const LinearGradient(
                            colors: [
                              Colors.yellow,
                              Colors.orange,
                              Colors.yellow
                            ],
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
                              width: 50,
                              height: 50,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        const WidgetStatePropertyAll(Colors.transparent),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    await Share.share(
                        "Easy mode coins: ${provider.easyModeTotalCoins}, Hard mode coins: ${provider.hardModeTotalCoins}");
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 10),
                    decoration: BoxDecoration(
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.white,
                          blurRadius: 6,
                        )
                      ],
                      borderRadius: BorderRadius.circular(35),
                      gradient: const LinearGradient(
                        colors: [
                          secondGoldColor,
                          firstGoldColor,
                          secondGoldColor
                        ],
                      ),
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Share",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 23,
                          ),
                        ),
                        SizedBox(width: 7),
                        Icon(
                          CupertinoIcons.share,
                          color: Colors.black,
                          size: 33,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20),
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
