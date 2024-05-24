class Validation {
  Validation._();

  static bool isValidEmail(String email) {
    return RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+",
    ).hasMatch(email);
  }

  static bool isValidPassword(String password) {
    return RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$',
    ).hasMatch(password);
  }

  static bool isValidName(String name) {
    return RegExp('[a-zA-Z]').hasMatch(name);
  }

  static bool isEqualPassword(String val1, String val2) {
    return val1 == val2;
  }

  static bool isValidNumber(String number) {
    return RegExp(r'^[0-9]+$').hasMatch(number);
  }

  static bool isValidDescription(String description) {
    return description.trim().isNotEmpty;
  }

  static bool isValidResponsibilities(String responsibilities) {
    return responsibilities.trim().isNotEmpty;
  }

  static bool isValidBenefits(String benefits) {
    return benefits.trim().isNotEmpty;
  }

  static bool isValidPosition(String position) {
    return position.trim().isNotEmpty;
  }

  static bool isValidLocation(String location) {
    return Uri.tryParse(location)?.isAbsolute ?? false;
  }

  static bool isValidSalary(String salary) {
    return RegExp(r'^[0-9]+$').hasMatch(salary);
  }
}

enum InputType {
  email,
  password,
  confirmPassword,
  name,
  number,
  description,
  responsibilities,
  benefits,
  position,
  location,
  salary
}
