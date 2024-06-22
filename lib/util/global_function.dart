import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ApGlobalFunctions {
  ApGlobalFunctions._();

  static void changeStatusBarColor({
    required Color color,
    Brightness? iconBrightness,
    Brightness? brightness,
  }) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: color, //or set color with: Color(0xFF0000FF)
        statusBarIconBrightness:
            iconBrightness ?? Brightness.dark, // For Android (dark icons)
        statusBarBrightness: brightness ?? Brightness.light,
      ),
    );
  }

  static showSnacbarMethod({
    required BuildContext context,
    required String message,
    required bool isSuccess,
  }) {
    return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: isSuccess ? Colors.green : Colors.red,
        content: Text(message),
      ),
    );
  }

  static GlobalKey<ScaffoldMessengerState> getSnackbarKey() {
    final snackbarKey = GlobalKey<ScaffoldMessengerState>();
    return snackbarKey;
  }

  static GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
}
