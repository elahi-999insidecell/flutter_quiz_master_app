// ignore_for_file: non_constant_identifier_names

import 'package:shared_preferences/shared_preferences.dart';

class Sharedpref {
  bool isDark = false;
  static Future<void> saveThema(bool isDark) async {
    final pref = await SharedPreferences.getInstance();
    await pref.setBool("thema", isDark);
  }

  static Future<bool> getThema() async {
    final pref = await SharedPreferences.getInstance();
    return pref.getBool("thema") ?? false;
  }

  //statistics
  static const String totalAttemptsKey = 'totalAttempts';
  static const String highestScoreKey = 'highestScore';
  static const String lastScoreKey = 'lastScore';
  static const String historyKey = 'quizHistory';

  Future<Map<String, int>> LoadStats() async {
    final pref = await SharedPreferences.getInstance();
    return {
      'totalAttempts' : pref.getInt(totalAttemptsKey)??0,
      'highestScore' : pref.getInt(highestScoreKey)??0,
      'lastScore' : pref.getInt(lastScoreKey)??0,
    };
  }

  //saving whatever i am getting in result;
  Future<void> saveStats({
  required int score,
  required int totalQuestions,
  required String categoryName,
}) async {
  final pref = await SharedPreferences.getInstance();

  int attempts =
      pref.getInt(totalAttemptsKey) ?? 0;

  int highest =
      pref.getInt(highestScoreKey) ?? 0;

  attempts++;

  if (score > highest) {
    highest = score;
  }

  await pref.setInt(
    totalAttemptsKey,
    attempts,
  );

  await pref.setInt(
    highestScoreKey,
    highest,
  );

  await pref.setInt(
    lastScoreKey,
    score,
  );

  //history saving
  List<String> history =
    pref.getStringList(historyKey) ?? [];


history.insert(
  0,
  "$categoryName : $score/$totalQuestions",
);
("History Saved = print$history");
if (history.length > 10) {
  history = history.sublist(0, 10);
}

await pref.setStringList(
  historyKey,
  history,
);


}

//load hostory
Future<List<String>> loadHistory() async {
  final pref = await SharedPreferences.getInstance();

  return pref.getStringList(historyKey) ?? [];
}


//save history
}
