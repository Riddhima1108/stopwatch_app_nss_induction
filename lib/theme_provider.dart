import 'package:flutter/material.dart';

class Mytheme extends ChangeNotifier {
  bool _islightTheme = true;

  void Changetheme() {
    _islightTheme = !_islightTheme;
    notifyListeners();
  }

  bool get islightTheme => _islightTheme;
}
