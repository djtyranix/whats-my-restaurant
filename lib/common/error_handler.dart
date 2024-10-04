import 'package:flutter/material.dart';

class ErrorHandler {
  static void handleError({required BuildContext context, required String error, bool autoDismiss = true, String? actionLabel, Function? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Error: $error'),
        backgroundColor: Colors.red,
        duration: autoDismiss ? Duration(seconds: 4) : Duration(days: 365),
        action: action == null || actionLabel == null
        ? null
        : SnackBarAction(
          label: actionLabel,
          onPressed: () {
            action();
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          }
        ),
      ),
    );
  }
}