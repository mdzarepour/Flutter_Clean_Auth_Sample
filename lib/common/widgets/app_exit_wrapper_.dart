import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppExitWrapper extends StatefulWidget {
  final Widget child;

  const AppExitWrapper({super.key, required this.child});

  @override
  State<AppExitWrapper> createState() => _AppExitWrapperState();
}

class _AppExitWrapperState extends State<AppExitWrapper> {
  final String message = 'Press back again to exit app';
  final Duration interval = const Duration(seconds: 2);
  DateTime? _lastBackPressed;

  Future<bool> _onWillPop() async {
    final canPop = GoRouter.of(context).canPop();

    if (canPop) {
      return true;
    }

    final now = DateTime.now();
    if (_lastBackPressed == null ||
        now.difference(_lastBackPressed!) > interval) {
      _lastBackPressed = now;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message), duration: interval));

      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(onWillPop: _onWillPop, child: widget.child);
  }
}
