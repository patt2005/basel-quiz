import 'package:basel_quiz_app/utils/utils.dart';
import 'package:flutter/material.dart';

class BackgroundImage extends StatelessWidget {
  const BackgroundImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      "assets/images/ui/background_image.png",
      fit: BoxFit.cover,
      width: screenSize.width,
      height: screenSize.height,
    );
  }
}
