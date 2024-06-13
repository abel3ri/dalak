import 'package:flutter/material.dart';

class LoginFormProvider extends ChangeNotifier {
  final _usernameEmailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool _showPassword = false;

  @override
  void dispose() {
    usernameEmailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void toggleShowPassword() {
    _showPassword = !_showPassword;
    notifyListeners();
  }

  TextEditingController get usernameEmailController => _usernameEmailController;
  TextEditingController get passwordController => _passwordController;
  GlobalKey<FormState> get formKey => _formKey;
  bool get showPassword => _showPassword;
}
