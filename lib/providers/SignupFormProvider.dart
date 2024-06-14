import 'package:flutter/material.dart';

class SignupFormProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;
  bool _isLoading = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  void toggleIsLoading() {
    _isLoading = !_isLoading;
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;
  bool get showPassword => _showPassword;
  bool get isLoading => _isLoading;
}
