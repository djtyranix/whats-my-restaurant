import 'package:flutter/material.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static navigate({required String toRoute, Object? arguments}) {
    navigatorKey.currentState?.pushNamed(toRoute, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}