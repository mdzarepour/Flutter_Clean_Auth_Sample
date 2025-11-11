import 'package:auth_sample/core/utils/services/snackbar_service.dart';
import 'package:auth_sample/locator.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ExitWrapper extends StatefulWidget {
  final Widget child;

  const ExitWrapper({super.key, required this.child});

  @override
  State<ExitWrapper> createState() => _ExitWrapperState();
}

class _ExitWrapperState extends State<ExitWrapper> {
  final SnackbarService snackbarService = locator.get();
  final Duration interval = const Duration(seconds: 2);
  DateTime? lastBackPressed;

  Future<bool> onWillPop() async {
    final canPop = GoRouter.of(context).canPop();
    if (canPop) {
      return true;
    }
    final now = DateTime.now();
    if (lastBackPressed == null ||
        now.difference(lastBackPressed!) >= interval) {
      lastBackPressed = now;
      snackbarService.showSnackbar(message: 'Press back again to exit app');
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: onWillPop, child: widget.child);
  }
}
