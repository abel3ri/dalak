import 'package:flutter/material.dart';

class BottomNavBarProvider with ChangeNotifier {
  int _selectedIndex = 0;

  void updateSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  int get selectedIndex => _selectedIndex;
}
