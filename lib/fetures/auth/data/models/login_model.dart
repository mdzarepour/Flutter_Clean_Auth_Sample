class LoginParams {
  final String identity;
  final String password;

  LoginParams({required this.identity, required this.password});

  Map toMap() {
    return {'identity': identity, 'password': password};
  }
}
