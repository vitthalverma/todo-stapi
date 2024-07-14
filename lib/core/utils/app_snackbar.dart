import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:frontend/core/constants/app_colors.dart';

enum SnackType { error, success, info }

class AppSnack {
  static void error(
    BuildContext context,
    String message, [
    DesktopSnackBarPosition? position,
  ]) {
    AnimatedSnackBar(
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 60,
        bottomOnAppearance: 60,
      ),
      desktopSnackBarPosition: position ?? DesktopSnackBarPosition.topCenter,
      duration: const Duration(seconds: 2),
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.red.shade700,
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
              minLeadingWidth: 8,
              leading: const Icon(
                Icons.error,
                color: white,
              ),
              title: Text(
                message,
                style: const TextStyle(color: white),
              )),
        );
      },
    ).show(context);
  }

  static void success(
    BuildContext context,
    String message, [
    DesktopSnackBarPosition? position,
  ]) {
    AnimatedSnackBar(
      mobilePositionSettings: const MobilePositionSettings(
        topOnAppearance: 60,
      ),
      desktopSnackBarPosition: position ?? DesktopSnackBarPosition.topCenter,
      duration: const Duration(seconds: 2),
      builder: (context) {
        return DecoratedBox(
          decoration: BoxDecoration(
            color: Colors.green.shade400,
            borderRadius: BorderRadius.circular(8),
          ),
          child: ListTile(
              minLeadingWidth: 10,
              leading: const Icon(
                Icons.done,
                color: white,
              ),
              title: Text(
                message,
                style: const TextStyle(color: white),
              )),
        );
      },
    ).show(context);
  }
}
