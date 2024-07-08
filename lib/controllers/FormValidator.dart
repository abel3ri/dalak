import 'package:dalak_blog_app/utils/constants.dart';

class FormValidator {
  static String? emailValidator(String? value) {
    if (value!.isEmpty) return "Please provide an email address";
    if (!emailRegex.hasMatch(value))
      return "Please enter a valid email address";
    return null;
  }

  static String? passwordValidator(String? value) {
    if (value!.isEmpty) return "Please provide a password";
    if (value.length < 8) return "Password must be at least 8 chars long";
    return null;
  }

  static String? usernameValidator(String? value) {
    if (value!.isEmpty) return "Please provide a username";
    if (value.length < 5) return "Username must be at least 5 chars long";
    return null;
  }
}
