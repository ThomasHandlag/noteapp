/// {@template user}
/// User model
///
/// [User.empty] represents an unauthenticated user.
/// {@endtemplate}
class User {
  /// {@macro user}
  const User({
    required this.id,
    this.email,
    this.name,
    this.photo,
    this.password,
  });

  final String? email;

  final String id;

  final String? name;

  final String? photo;

  final String? password;
  
  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  set email(String? email) => email ??= '';
  set name(String? name) => name ??= '';
  set photo(String? photo) => photo ??= '';
  set password(String? password) => password ??= '';
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
