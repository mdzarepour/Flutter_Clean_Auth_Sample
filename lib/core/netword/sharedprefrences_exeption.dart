import 'package:logger/logger.dart';

class SharedprefrencesExeption implements Exception {
  final String message;
  final String functionName;

  SharedprefrencesExeption({
    required this.functionName,
    required this.message,
  }) {
    Logger logger = Logger(
      printer: PrettyPrinter(methodCount: 0, colors: true, printEmojis: true),
    );
    logger.e(functionName);
    logger.d('Error message: $message');
  }
}
