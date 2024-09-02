import 'dart:convert';
import 'dart:math';
import 'package:basel_quiz_app/models/true_false_question.dart';
import 'package:basel_quiz_app/providers/game_provider.dart';
import 'package:basel_quiz_app/screens/finish_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

class TrueFalseQuizScreen extends StatefulWidget {
  const TrueFalseQuizScreen({super.key});

  @override
  State<TrueFalseQuizScreen> createState() => _TrueFalseQuizScreenState();
}

class _TrueFalseQuizScreenState extends State<TrueFalseQuizScreen> {
  final List<TrueFalseQuestion> _questions = [];

  late String categoryId;

  int _currentQuestionIndex = 1;
  int? _selectedOptionIndex;
  bool? _isAnswerCorrect;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await _init();
      },
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
          Text(
            _questions[_currentQuestionIndex - 1].questionText,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 19,
            ),
          ),
          const SizedBox(height: 20),
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
                    _isAnswerCorrect != null && _selectedOptionIndex == 0
                        ? _isAnswerCorrect!
                            ? Colors.green.withOpacity(0.5)
                            : Colors.red.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    if (_questions[_currentQuestionIndex - 1].answer == true) {
                      _isAnswerCorrect = true;
                    } else {
                      _isAnswerCorrect = false;
                    }
                    _selectedOptionIndex = 0;
                  });
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () {
                      setState(() {
                        _currentQuestionIndex++;
                        _selectedOptionIndex = null;
                        _isAnswerCorrect = null;
                      });
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "True",
                      style: TextStyle(
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
                    _isAnswerCorrect != null && _selectedOptionIndex == 1
                        ? _isAnswerCorrect!
                            ? Colors.green.withOpacity(0.5)
                            : Colors.red.withOpacity(0.5)
                        : Colors.transparent,
                  ),
                ),
                onPressed: () async {
                  setState(() {
                    if (_questions[_currentQuestionIndex - 1].answer == false) {
                      _isAnswerCorrect = true;
                    } else {
                      _isAnswerCorrect = false;
                    }
                    _selectedOptionIndex = 1;
                  });
                  await Future.delayed(
                    const Duration(seconds: 2),
                    () async {
                      if (_currentQuestionIndex >= _questions.length) {
                        await Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                            builder: (context) => const FinishScreen(),
                          ),
                        );
                      }
                      setState(() {
                        _currentQuestionIndex++;
                        _selectedOptionIndex = null;
                        _isAnswerCorrect = null;
                      });
                    },
                  );
                },
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "False",
                      style: TextStyle(
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
    categoryId = dailyQuestionsIds[Random().nextInt(dailyQuestionsIds.length)];
    final String jsonData =
        await rootBundle.loadString("assets/data/daily_questions.json");
    final Map<String, dynamic> data = jsonDecode(jsonData);
    final List<dynamic> questionDataList = data["questions"][categoryId];
    for (var questionData in questionDataList) {
      _questions.add(
        TrueFalseQuestion(
          questionText: questionData["question"],
          answer: questionData["answer"],
        ),
      );
    }
    setState(() {});
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
                          "assets/images/daily/image$_currentQuestionIndex.png",
                          width: screenSize.width,
                          fit: BoxFit.cover,
                          height: screenSize.height * 0.25,
                        ),
                      ),
                      SizedBox(height: screenSize.height * 0.05),
                      _buildOptionsCard(),
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
