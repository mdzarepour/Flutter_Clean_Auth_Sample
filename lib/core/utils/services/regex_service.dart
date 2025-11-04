import 'package:auth_sample/core/utils/constants/const_strings.dart';

enum RegexType { username, password }

class RegexService {
  static final RegExp usernamePattern = RegExp(r'^[a-zA-Z0-9_]{4,}$');

  static final RegExp passwordPattern = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d@$!%*?&]{8,}$',
  );
  String? getMessage({
    final String? value,
    required final RegexType regexType,
  }) {
    if (regexType == RegexType.password) {
      if (!passwordPattern.hasMatch(value!)) {
        return ConstStrings.passwordMatchMsg;
      }
      if (value.isEmpty) {
        return ConstStrings.passwordEmptyMsg;
      }
    }
    if (regexType == RegexType.username) {
      if (!usernamePattern.hasMatch(value!)) {
        return ConstStrings.usernameMatchMsg;
      }
      if (value.isEmpty) {
        return ConstStrings.usernameEmptyMsg;
      }
    }
    return null;
  }
}
