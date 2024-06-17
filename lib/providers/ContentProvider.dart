import 'package:dalak_blog_app/models/Error.dart';
import 'package:dalak_blog_app/models/Success.dart';
import 'package:dalak_blog_app/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fpdart/fpdart.dart';

class ContentProvider with ChangeNotifier {
  List<Map<String, dynamic>> _posts = [];
  List<Map<String, dynamic>> _categories = [];
  bool _isLoading = false;
  late Map<String, dynamic> _post;
  late String _categoryName;

  void populatePosts(List<Map<String, dynamic>> posts) {
    _posts = posts;
    notifyListeners();
  }

  void populateCategories(List<Map<String, dynamic>> categories) {
    _categories = categories;
    notifyListeners();
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  void setPost(Map<String, dynamic> post) {
    _post = post;
    notifyListeners();
  }

  void setCategoryName(String categoryName) {
    _categoryName = categoryName;
  }

  Future<Either<ErrorMessage, SuccessMessage>> fetchPosts({
    required String endpoint,
  }) async {
    try {
      final res = await dio.get("${BASE_URL}/${endpoint}");
      _posts = List<Map<String, dynamic>>.from(res.data);
      notifyListeners();
      return right(SuccessMessage(body: "Successfully loaded content"));
    } on DioException catch (_) {
      return left(ErrorMessage(body: "Error fetching content."));
    } catch (e) {
      return left(ErrorMessage(body: "An error has occured."));
    }
  }

  List<Map<String, dynamic>> get posts => _posts;
  List<Map<String, dynamic>> get categories => _categories;
  bool get isLoading => _isLoading;
  Map<String, dynamic> get post => _post;
  String get categoryName => _categoryName;
}
