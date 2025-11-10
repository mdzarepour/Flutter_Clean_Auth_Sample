class LoginParams {
  final String identity;
  final String password;

  LoginParams({required this.password, required this.identity});

  Map toMap() {
    return {'identity': identity, 'password': password};
  }
}
