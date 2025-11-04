import 'package:auth_sample/core/netword/sharedprefrences_exeption.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDatasource {
  bool isUserLoggedIn();
  Future<void> removeToken();
  Future<void> saveToken({required String token});
}

class AuthLocalDatasourceImp implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;

  AuthLocalDatasourceImp({required this.sharedPreferences});

  @override
  Future<void> saveToken({required String token}) async {
    try {
      await sharedPreferences.setString('token', token);
    } catch (e) {
      throw TokenExeption(functionName: 'saveToken', message: e.toString());
    }
  }

  @override
  Future<void> removeToken() async {
    try {
      await sharedPreferences.remove('token');
    } catch (e) {
      throw TokenExeption(functionName: 'removeToken', message: e.toString());
    }
  }

  @override
  bool isUserLoggedIn() {
    try {
      String? userId = sharedPreferences.getString('token');
      if (userId == null || userId.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw TokenExeption(
        functionName: 'isUserLoggedIn',
        message: e.toString(),
      );
    }
  }
}
