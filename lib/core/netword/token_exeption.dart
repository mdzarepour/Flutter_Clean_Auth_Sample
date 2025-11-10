import 'package:logger/logger.dart';

class TokenExeption implements Exception {
  final String message;
  final String functionName;

  TokenExeption({required this.functionName, required this.message}) {
    Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
    );
    logger.e(functionName);
    logger.d('Error message: $message');
  }
}
