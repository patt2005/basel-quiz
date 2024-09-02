import 'package:flutter/material.dart';

late Size screenSize;

const Color firstGoldColor = Color(0xFFF2D69A);
const Color secondGoldColor = Color(0xFFB8812A);

double musicVolume = 0.5;

final List<String> categoryIds = [
  "cathedrals",
  "bridges",
  "buildings",
  "museums",
  "squares",
  "monuments",
];

final List<String> dailyQuestionsIds = [
  "town",
  "architecture",
  "museums",
  "squares",
  "buildings",
  "markets",
  "bridges",
  "structures",
  "events",
  "facts",
];

String formatTime(int seconds) {
  final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
  final remainingSeconds = (seconds % 60).toString().padLeft(2, '0');
  return '$minutes:$remainingSeconds';
}
