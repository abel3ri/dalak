import 'package:flutter/material.dart';

class ContentProvider with ChangeNotifier {
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _categories = [];

  void populatePosts(List<Map<String, dynamic>> posts) {
    _posts = posts;
    notifyListeners();
  }

  void populateCategories(List<Map<String, dynamic>> categories) {
    _categories = categories;
    notifyListeners();
  }

  List<Map<String, dynamic>> get posts => _posts;
  List<Map<String, dynamic>> get categories => _categories;
}
