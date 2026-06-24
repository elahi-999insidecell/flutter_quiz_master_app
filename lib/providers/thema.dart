import 'package:flutter/foundation.dart';
import 'package:quiz_master/utils/sharedpref.dart';

class Thema extends ChangeNotifier {
  bool isDark = false;

  Future<void> loadTheme() async {
    isDark = await Sharedpref.getThema();
    notifyListeners();
  }

  Future<void> toggleThema(bool val) async {
    isDark = val;
    await Sharedpref.saveThema(val);
    notifyListeners();
  }
}
