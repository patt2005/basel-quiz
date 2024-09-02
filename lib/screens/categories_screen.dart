import 'dart:convert';
import 'package:basel_quiz_app/models/landmark_category.dart';
import 'package:basel_quiz_app/screens/easy_quiz_screen.dart';
import 'package:basel_quiz_app/utils/utils.dart';
import 'package:basel_quiz_app/widgets/background_image.dart';
import 'package:basel_quiz_app/widgets/gold_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({super.key});

  @override
  State<CategoriesScreen> createState() => _CategoriesScreenState();
}

class _CategoriesScreenState extends State<CategoriesScreen> {
  final List<LandMarkCategory> _categories = [];

  void _init() async {
    final jsonData = await rootBundle.loadString("assets/data/data.json");
    final Map<String, dynamic> data = jsonDecode(jsonData);
    for (var id in categoryIds) {
      var category = LandMarkCategory(
        id: id,
        title: data["categories"][id]["title"],
        imagePath: data["categories"][id]["imagePath"],
      );
      _categories.add(category);
    }
    setState(() {});
  }

  Widget _buildCategoryCard(LandMarkCategory category) {
    return GestureDetector(
      onTap: () async {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => EasyQuizScreen(categoryId: category.id),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(13),
        decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(color: Colors.white, blurRadius: 6),
          ],
          borderRadius: BorderRadius.circular(25),
          image: DecorationImage(
            image: AssetImage(category.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _init();
  }

  @override
  Widget build(BuildContext context) {
    int categoryIndex = 0;

    return Scaffold(
      body: Stack(
        children: [
          const BackgroundImage(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              children: [
                SizedBox(height: screenSize.height * 0.1),
                for (int i = 0; i < _categories.length / 2; i++)
                  SizedBox(
                    height: screenSize.height * 0.21,
                    child: Row(
                      children: [
                        Expanded(
                          child:
                              _buildCategoryCard(_categories[categoryIndex++]),
                        ),
                        Expanded(
                          child:
                              _buildCategoryCard(_categories[categoryIndex++]),
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
