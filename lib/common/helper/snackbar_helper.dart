import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/styles.dart';

class SnackbarHelper {
  static void handleError({required BuildContext context, required String error, bool autoDismiss = true, String? actionLabel, Function? action}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          'Error: $error',
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? onErrorContainerDark : onErrorContainer,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? errorContainerDark : errorContainer,
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
        content: Text(
          message,
          style: TextStyle(
            color: Theme.of(context).brightness == Brightness.dark ? onSuccessContainerDark : onSuccessContainer,
          ),
        ),
        backgroundColor: Theme.of(context).brightness == Brightness.dark ? successContainerDark : successContainer,
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