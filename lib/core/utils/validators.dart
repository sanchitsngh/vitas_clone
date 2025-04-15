class Validators {
  static bool isValidEmail(String email) {
    final emailRegex = RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$");
    return emailRegex.hasMatch(email);
  }

  static bool hasNumber(String input) {
    return input.contains(RegExp(r'[0-9]'));
  }

  static bool isValidName(String name) {
    final nameRegex = RegExp(r'^[a-zA-Z0-9$@_]+$');
    return nameRegex.hasMatch(name);
  }

  static bool hasUpperCase(String input) {
    return input.contains(RegExp(r'[A-Z]'));
  }

  static bool isValidPassword(String password) {
    return password.length >= 8 && hasNumber(password) && hasUpperCase(password);
  }

   static String? validateEmail(String? value, bool isRequired) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field is required"; // Validation for empty input
    }

    if (value != null && !isValidEmail(value)) {
      return "Enter a valid Email";
    }

    return null;
  }

  static String? validatePhoneNumber(String? value, bool isRequired) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field is required";
    }

    if (value != null && !RegExp(r'^\d{10}$').hasMatch(value)) {
      return "Enter a valid phone number";
    }

    return null;
  }

  static String? validateRequiredField(String? value, bool isRequired) {
    if (isRequired && (value == null || value.isEmpty)) {
      return "This field is required";
    }

    return null;
  }
}
