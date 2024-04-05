class User {
  String? name;
  String email;
  String password;
  String? token;
  User(
      {required this.name,
      required this.email,
      required this.password,
      required this.token});

  User.logInUser({
    required this.email,
    required this.password,
  });

  User.registerUser({
    required this.email,
    required this.password,
    required this.name,
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'token': token,
      };

  static int checkPassword(String password) {
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

  static bool isValidEmail(String email) {
    return RegExp(
            r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
        .hasMatch(email);
  }
}
