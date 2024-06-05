class UserModel {
  String email;

  String id;

  String name;

  String photo;

  String password;

  UserModel({
    required this.id,
    required this.email,
    required this.name,
    required this.photo,
    required this.password,
  });
}

int checkPassword(String password) {
  RegExp digitRegex = RegExp(r'\d');
  RegExp specialCharRegex = RegExp(r'[!@#$%^&*(),.?":{}|<>]');
  if (password.length < 8) {
    return 1;
  }
  if (!digitRegex.hasMatch(password)) {
    return 2;
  }
  if (!specialCharRegex.hasMatch(password)) {
    return 3;
  }
  return 0;
}

bool isValidEmail(String email) {
  return RegExp(
          r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
      .hasMatch(email);
}
