import 'package:basel_quiz_app/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class GameProvider extends ChangeNotifier {
  int _easyModeTotalCoins = 0;
  int _hardModeTotalCoins = 0;

  int _easyModeAnsweredQuestions = 0;
  int _hardModeAnsweredQuestions = 0;

  String _nickName = "";

  String _profileImagePath = "";

  int get easyModeTotalCoins => _easyModeTotalCoins;
  int get hardModeTotalCoins => _hardModeTotalCoins;

  int get easyModeAnsweredQuestions => _easyModeAnsweredQuestions;
  int get hardModeAnsweredQuestions => _hardModeAnsweredQuestions;

  String get nickName => _nickName;

  String get profileImagePath => _profileImagePath;

  Future<void> saveProgress(
      String categoryId, String mode, int answers, int coins) async {
    final prefs = await SharedPreferences.getInstance();
    final int answeredQuestions = prefs.getInt("$mode-$categoryId") ?? 0;
    await prefs.setInt("$mode-coins", coins);
    if (mode == "easy") {
      _easyModeTotalCoins = coins;
      if (answers > answeredQuestions) {
        _easyModeAnsweredQuestions -= answeredQuestions;
        _easyModeAnsweredQuestions += answers;
        await prefs.setInt("$mode-$categoryId", answers);
      }
    } else {
      _hardModeTotalCoins = coins;
      if (answers > answeredQuestions) {
        _hardModeAnsweredQuestions -= answeredQuestions;
        _hardModeAnsweredQuestions += answers;
        await prefs.setInt("$mode-$categoryId", answers);
      }
    }
    notifyListeners();
  }

  Future<void> loadProgess() async {
    final prefs = await SharedPreferences.getInstance();
    for (var categoryId in categoryIds) {
      _easyModeAnsweredQuestions += prefs.getInt("easy-$categoryId") ?? 0;
      _hardModeAnsweredQuestions += prefs.getInt("hard-$categoryId") ?? 0;
    }
    _easyModeTotalCoins = prefs.getInt("easy-coins") ?? 0;
    _hardModeTotalCoins = prefs.getInt("hard-coins") ?? 0;
    notifyListeners();
  }

  Future<void> loadImagePath() async {
    final prefs = await SharedPreferences.getInstance();
    _profileImagePath = prefs.getString("profileImagePath") ?? "";
    notifyListeners();
  }

  Future<void> setNickname(String nickname) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("nickname", nickname);
    _nickName = nickname;
    notifyListeners();
  }

  Future<void> getNickname() async {
    final prefs = await SharedPreferences.getInstance();
    _nickName = prefs.getString("nickname") ?? "";
    notifyListeners();
  }

  Future<void> setProfileImagePath(String path) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("profileImagePath", path);
    _profileImagePath = path;
    notifyListeners();
  }

  Future<void> resetProgress() async {
    final prefs = await SharedPreferences.getInstance();
    _easyModeAnsweredQuestions = 0;
    _hardModeAnsweredQuestions = 0;
    _easyModeTotalCoins = 0;
    _hardModeTotalCoins = 0;
    await prefs.setInt("easy-coins", 0);
    await prefs.setInt("hard-coins", 0);
    for (var category in categoryIds) {
      await prefs.setInt("easy-$category", 0);
      await prefs.setInt("hard-$category", 0);
    }
    notifyListeners();
  }
}
