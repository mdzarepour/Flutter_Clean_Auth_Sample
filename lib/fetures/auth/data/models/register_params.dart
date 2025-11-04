class RegisterParams {
  final String username;
  final String name;
  final String password;
  final String passwordConfirm;

  RegisterParams({
    required this.name,
    required this.password,
    required this.passwordConfirm,
    required this.username,
  });

  Map toMap() {
    return {
      'username': username,
      'password': password,
      'passwordConfirm': passwordConfirm,
      'name': name,
    };
  }
}
