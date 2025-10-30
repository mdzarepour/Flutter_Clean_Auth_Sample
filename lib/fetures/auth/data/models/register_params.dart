class RegisterParams {
  final String username;
  final String name;
  final String password;
  final String passwordConfirm;

  RegisterParams({
    required this.username,
    required this.name,
    required this.password,
    required this.passwordConfirm,
  });

  Map<String, String> toMap() {
    return {
      'username': username,
      'name': name,
      'password': password,
      'passwordConfirm': passwordConfirm,
    };
  }
}
