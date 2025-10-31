import 'package:auth_sample/core/netword/sharedprefrences_exeption.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AuthLocalDatasource {
  bool isUserLoggedIn();
  Future<void> removeUserId();
  Future<void> saveUserId({required String userId});
}

class AuthLocalDatasourceImp implements AuthLocalDatasource {
  final SharedPreferences sharedPreferences;
  AuthLocalDatasourceImp({required this.sharedPreferences});

  @override
  Future<void> saveUserId({required String userId}) async {
    try {
      await sharedPreferences.setString('USER_ID', userId);
    } catch (e) {
      throw SharedprefrencesExeption(
        functionName: 'saveUserId',
        message: e.toString(),
      );
    }
  }

  @override
  Future<void> removeUserId() async {
    try {
      await sharedPreferences.remove('USER_ID');
    } catch (e) {
      throw SharedprefrencesExeption(
        functionName: 'removeUserId',
        message: e.toString(),
      );
    }
  }

  @override
  bool isUserLoggedIn() {
    try {
      String? userId = sharedPreferences.getString('USER_ID');
      if (userId == null || userId.isEmpty) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      throw SharedprefrencesExeption(
        functionName: 'isUserLoggedIn',
        message: e.toString(),
      );
    }
  }
}
