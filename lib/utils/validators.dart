class FormValidator {
  String? validateFullName(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your full name';
    }
    return null;
  }

  String? validateEmail(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? validateMobileNumber(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your mobile number';
    } else if (!RegExp(r'^9\d{9}$').hasMatch(value)) {
      return 'Please enter a valid mobile number';
    }
    return null;
  }

  String? validateAddress(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your address';
    }
    return null;
  }

  String? validateUsername(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your username';
    }
    return null;
  }

  String? validatePassword(dynamic? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    } else if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{8,}$')
        .hasMatch(value)) {
      return 'Password must contain at least one uppercase letter, one lowercase letter, and one number';
    }
    return null;
  }
}
