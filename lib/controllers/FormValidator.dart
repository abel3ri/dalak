class FormValidator {
  static String? emailValidator(String? value) {
    final regex = RegExp(r"^[A-Za-z0-9.+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");

    if (value!.isEmpty) return "Please provide an email address";
    if (!regex.hasMatch(value)) return "Please enter a valid email address";
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
