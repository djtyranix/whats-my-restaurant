import 'dart:async';
import 'dart:io';
import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/helper/background_service.dart';
import 'package:whats_on_restaurant/common/helper/notification_helper.dart';
import 'package:whats_on_restaurant/common/helper/preference_helper.dart';
import 'package:whats_on_restaurant/common/navigation.dart';
import 'package:whats_on_restaurant/common/preference/preference_provider.dart';
import 'package:whats_on_restaurant/common/styles.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/favorite/ui/favorite_page.dart';
import 'package:whats_on_restaurant/modules/home/ui/home_page.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';
import 'package:whats_on_restaurant/modules/review/ui/add_review_page.dart';
import 'package:whats_on_restaurant/modules/review/ui/all_review_page.dart';
import 'package:whats_on_restaurant/modules/search/ui/search_page.dart';
import 'package:whats_on_restaurant/modules/settings/ui/settings_page.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  DependencyInjection.configure();

  PackageInfo info = await PackageInfo.fromPlatform();
  packageInfo = info;
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  
  final BackgroundService service = DependencyInjection.getInstance();
  final NotificationHelper notificationHelper = DependencyInjection.getInstance();

  service.initializeIsolate();

  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }

  await notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}

late PackageInfo packageInfo;
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Splash Screen Delay
    Timer(Duration(seconds: 1), () {
      FlutterNativeSplash.remove();
    });

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => PreferenceProvider(
            helper: PreferenceHelper(
              sharedPreferences: SharedPreferences.getInstance()
            )
          )
        )
      ],
      child: Consumer<PreferenceProvider>(
        builder: (context, preferences, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'What\'s on Restaurant?',
            theme: getThemeData(context, Brightness.light),
            darkTheme: getThemeData(context, Brightness.dark),
            themeMode: preferences.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
            navigatorKey: navigatorKey,
            navigatorObservers: [routeObserver],
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              RestaurantDetailPage.routeName: (context) => RestaurantDetailPage(
                id: ModalRoute.of(context)?.settings.arguments as String,
              ),
              AddReviewPage.routeName: (context) => AddReviewPage(
                data: ModalRoute.of(context)?.settings.arguments as Map<String, String>,
              ),
              AllReviewPage.routeName: (context) => AllReviewPage(
                reviews: ModalRoute.of(context)?.settings.arguments as List<RestaurantReview>
              ),
              SearchPage.routeName: (context) => const SearchPage(),
              SettingsPage.routeName: (context) => const SettingsPage(),
              FavoritePage.routeName: (context) => const FavoritePage()
            },
          );
        }
      ),
    );
  }
}