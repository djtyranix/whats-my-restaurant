import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/styles.dart';
import 'package:whats_on_restaurant/modules/home/ui/home_page.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';

void main() {
  DependencyInjection.configure();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });

    return MaterialApp(
      title: 'What\'s on Restaurant?',
      theme: getThemeData(context),
      initialRoute: HomePage.routeName,
      routes: {
        HomePage.routeName: (context) => const HomePage(),
        RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
          id: ModalRoute.of(context)?.settings.arguments as String,
        )
      },
    );
  }
}