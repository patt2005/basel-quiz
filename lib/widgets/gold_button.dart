import 'package:basel_quiz_app/utils/utils.dart';
import 'package:flutter/material.dart';

class GoldButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;

  const GoldButton({
    super.key,
    required this.text,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.zero,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [secondGoldColor, firstGoldColor, secondGoldColor],
        ),
      ),
      child: ElevatedButton(
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
          backgroundColor: const WidgetStatePropertyAll(Colors.transparent),
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              text,
              style: const TextStyle(
                color: Colors.black,
                fontSize: 22,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
