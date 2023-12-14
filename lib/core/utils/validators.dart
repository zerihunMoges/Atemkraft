class Validators {
  static String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter an email';
    } else if (!_isValidEmail(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  static bool _isValidEmail(String value) {
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(value);
  }

   static String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a password';
    } else if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    return null;
  }

  static String? fullNameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    } else {
      // Split the full name by whitespace and check if it has at least two parts
      List<String> parts = value.trim().split(' ');
      if (parts.length < 2) {
        return 'Please enter your first name and last name';
      }
    }
    return null;
  }
}
