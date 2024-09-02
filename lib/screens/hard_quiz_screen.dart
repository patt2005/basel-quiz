import 'dart:async';
import 'dart:convert';
import 'package:basel_quiz_app/models/question.dart';
import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/screens/lose_screen.dart';
import 'package:basel_quiz_app/screens/results_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class HardQuizScreen extends StatefulWidget {
  final String categoryId;

  const HardQuizScreen({
    super.key,
    required this.categoryId,
  });

  @override
  State<HardQuizScreen> createState() => _HardQuizScreenState();
}

class _HardQuizScreenState extends State<HardQuizScreen> {
  final List<Question> _questions = [];

  late Timer _timer;
  int _remainingSeconds = 180;

  int _currentQuestionIndex = 1;
  int? _selectedOptionIndex;
  bool _isAnswerCorrect = false;

  int _answeredQuestions = 0;

  int _totalCoins = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _init();
      },
    );
  }

  Widget _buildCoinsCard(int amount) {
    return Row(
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
                colors: [Colors.yellow, Colors.orange, Colors.yellow],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  formatTime(_remainingSeconds),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                const SizedBox(height: 45),
              ],
            ),
          ),
        ),
        const SizedBox(width: 13),
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
                colors: [Colors.yellow, Colors.orange, Colors.yellow],
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  amount.toString(),
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Image.asset(
                  "assets/images/ui/gold.png",
                  width: 45,
                  height: 45,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildOptionsCard() {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
      width: screenSize.width,
      decoration: BoxDecoration(
        boxShadow: const [
          BoxShadow(
            color: Colors.white,
            blurRadius: 6,
          )
        ],
        borderRadius: BorderRadius.circular(30),
        image: const DecorationImage(
          image: AssetImage("assets/images/ui/intro_image.png"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          for (var i = 0;
              i < _questions[_currentQuestionIndex - 1].options.length;
              i++)
            Container(
              margin: const EdgeInsets.only(bottom: 20),
              padding: EdgeInsets.zero,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [secondGoldColor, firstGoldColor, secondGoldColor],
                ),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Consumer<GameProvider>(
                builder: (context, value, child) => ElevatedButton(
                  style: ButtonStyle(
                    padding: const WidgetStatePropertyAll(
                      EdgeInsetsDirectional.symmetric(vertical: 17.5),
                    ),
                    elevation: const WidgetStatePropertyAll(0),
                    shape: WidgetStatePropertyAll(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadiusDirectional.circular(25),
                      ),
                    ),
                    backgroundColor: WidgetStatePropertyAll(
                      _selectedOptionIndex == i
                          ? _isAnswerCorrect
                              ? Colors.green.withOpacity(0.5)
                              : Colors.red.withOpacity(0.5)
                          : Colors.transparent,
                    ),
                  ),
                  onPressed: () async {
                    if (_selectedOptionIndex == null) {
                      setState(() {
                        _selectedOptionIndex = i;
                        _isAnswerCorrect = i ==
                            _questions[_currentQuestionIndex - 1].answerIndex;
                        if (_isAnswerCorrect) {
                          _totalCoins += 100;
                          _answeredQuestions++;
                        }
                      });

                      await Future.delayed(
                        const Duration(seconds: 2),
                        () async {
                          _currentQuestionIndex++;
                          if (_currentQuestionIndex >= _questions.length) {
                            await value.saveProgress(widget.categoryId, "hard",
                                _answeredQuestions, _totalCoins);
                            await Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => ResultsScreen(
                                  categoryId: widget.categoryId,
                                  mode: "hard",
                                ),
                              ),
                            );
                          }
                          _selectedOptionIndex = null;
                          _isAnswerCorrect = false;
                          setState(() {});
                        },
                      );
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        _questions[_currentQuestionIndex - 1].options[i],
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Future<void> _init() async {
    final provider = Provider.of<GameProvider>(context, listen: false);
    _totalCoins = provider.hardModeTotalCoins;
    final String jsonData =
        await rootBundle.loadString("assets/data/data.json");
    final Map<String, dynamic> data = jsonDecode(jsonData);
    final questionDataList = data["categories"][widget.categoryId]["questions"];
    for (var questionData in questionDataList) {
      _questions.add(
        Question(
          imagePath: questionData["imagePath"],
          options: questionData["options"],
          answerIndex: questionData["answerIndex"],
        ),
      );
    }
    _timer = Timer.periodic(
      const Duration(seconds: 1),
      (_) async {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _timer.cancel();
          await provider.saveProgress(
              widget.categoryId, "hard", _answeredQuestions, _totalCoins);
          await Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (context) => const LoseScreen(),
            ),
          );
        }
        setState(() {});
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    _timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          const BackgroundImage(),
          _questions.isEmpty
              ? const Center(
                  child: CupertinoActivityIndicator(
                    color: Colors.white,
                  ),
                )
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      SizedBox(height: screenSize.height * 0.08),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(25),
                        child: Image.asset(
                          "assets/images/categories/${widget.categoryId}/image$_currentQuestionIndex.png",
                          width: screenSize.width,
                          fit: BoxFit.cover,
                          height: screenSize.height * 0.25,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildCoinsCard(_totalCoins),
                      SizedBox(height: screenSize.height * 0.02),
                      _buildOptionsCard(),
                      SizedBox(height: screenSize.height * 0.01),
                      Center(
                        child: ElevatedButton(
                          style: const ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.transparent),
                            elevation: WidgetStatePropertyAll(0),
                          ),
                          onPressed: () {
                            if (_totalCoins >= 200) {
                              List<dynamic> optionsList =
                                  _questions[_currentQuestionIndex - 1].options;
                              int correctIndex =
                                  _questions[_currentQuestionIndex - 1]
                                      .answerIndex;

                              List<dynamic> incorrectOptions =
                                  optionsList.where((option) {
                                return optionsList.indexOf(option) !=
                                    correctIndex;
                              }).toList();

                              if (incorrectOptions.isNotEmpty) {
                                optionsList.remove(incorrectOptions.first);
                                _totalCoins -= 200;
                              }
                              setState(() {});
                            }
                          },
                          child: Image.asset(
                            "assets/images/ui/light_bolt.png",
                            width: 80,
                            height: 80,
                          ),
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.01),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
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
                            const Text(
                              "200",
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 19,
                              ),
                            ),
                            Image.asset(
                              "assets/images/ui/gold.png",
                              width: 33,
                              height: 33,
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      GoldButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        text: "Back",
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
