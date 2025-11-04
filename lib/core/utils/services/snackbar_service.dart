import 'package:flutter/material.dart';

class SnackbarService {
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  void showSnackbar({required final String message}) {
    ScaffoldMessenger.of(
      navigatorKey.currentContext!,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
