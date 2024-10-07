import 'package:flutter/material.dart';

class SnackbarHelper {
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

  static void handleSuccess({required BuildContext context, required String message, bool autoDismiss = true, String? actionLabel, Function? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
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