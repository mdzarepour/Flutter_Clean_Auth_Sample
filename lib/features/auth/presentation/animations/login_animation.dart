import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:rive/rive.dart';

class LoginAnimation {
  Artboard? artboard;
  SMITrigger? loginFail;
  SMITrigger? loginSuccess;
  SMIBool? isPassword;
  SMIBool? isFocus;
  SMINumber? eyeTrack;

  Future<void> initAnimation() async {
    final data = await rootBundle.load('assets/rabbit.riv');
    final file = RiveFile.import(data);
    var mainArtboard = file.mainArtboard;

    final controller = StateMachineController.fromArtboard(
      mainArtboard,
      'State Machine 1',
    );

    if (controller != null) {
      mainArtboard.addController(controller);

      for (final input in controller.inputs) {
        switch (input.name) {
          case 'isFocus':
            isFocus = input as SMIBool;
            break;
          case 'IsPassword':
            isPassword = input as SMIBool;
            break;
          case 'login_fail':
            loginFail = input as SMITrigger;
            break;
          case 'login_success':
            loginSuccess = input as SMITrigger;
            break;
          case 'eye_track':
            eyeTrack = input as SMINumber;
            break;
        }
      }
    }

    artboard = mainArtboard;
  }

  void resetRabbitState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      isFocus?.change(false);
      isPassword?.change(false);
      eyeTrack?.change(0.0);
    });
  }

  void updateRabbitEye({required bool open, int length = 0}) {
    if (open) {
      isFocus?.change(true);
      isPassword?.change(false);
      eyeTrack?.change(length.toDouble());
    } else {
      isFocus?.change(false);
      isPassword?.change(true);
      eyeTrack?.change(0.0);
    }
  }

  void fireSuccess() {
    loginSuccess!.fire();
  }

  void fireFail() {
    loginFail!.fire();
  }
}
