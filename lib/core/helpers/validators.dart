class Validators {
  static final emailRegex = RegExp(
    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
  );

  static String? passwordValidation(String? password) {
    if (password == null || password.trim().isEmpty) {
      return 'Password should not be empty';
    }

    if (password.length < 3 || password.length > 15) {
      return 'Password must be between 3 and 15 characters';
    }

    return null;
  }

  static String? emailValidation(String? email) {
    if (email == null || email.trim().isEmpty) {
      return 'Email should not be empty';
    }

    if (!emailRegex.hasMatch(email.trim())) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? nameValidation(String? name) {
    if (name == null || name.trim().isEmpty) {
      return 'Name should not be empty';
    }

    if (name.trim().length < 3 || name.trim().length > 30) {
      return 'Name must be between 3 and 30 characters';
    }

    return null;
  }

  static String? abouteValidation(String? about) {
    if (about == null || about.trim().isEmpty) {
      return 'About should not be empty';
    }

    if (about.trim().length < 1 || about.trim().length > 100) {
      return 'About must be between 1 and 100 characters';
    }

    return null;
  }

  static String? ageValidation(DateTime? birthdate) {
    if (birthdate == null) {
      return 'Birthdate should not be empty';
    }

    final today = DateTime.now();

    int age = today.year - birthdate.year;

    if (today.month < birthdate.month ||
        (today.month == birthdate.month &&
            today.day < birthdate.day)) {
      age--;
    }

    if (age <= 15) {
      return 'You must be older than 15 years';
    }

    return null;
  }
}