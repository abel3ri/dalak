import 'package:flutter/material.dart';

class SignupFormProvider extends ChangeNotifier {
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  GlobalKey<FormState> get formKey => _formKey;
  bool get showPassword => _showPassword;
}
