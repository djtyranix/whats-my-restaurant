import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/modules/settings/viewmodel/settings_view_model.dart';

class SettingsPage extends StatefulWidget {
  static const routeName = '/settings_page';
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings'
          ),
        ),
      ),
    );
  }
}