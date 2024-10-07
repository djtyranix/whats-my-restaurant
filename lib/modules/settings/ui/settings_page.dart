import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/modules/settings/settings_list.dart';
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
    List<SettingsType> list = defaultTargetPlatform == TargetPlatform.iOS
              ? SettingsList.iosList
              : SettingsList.androidList;

    return ChangeNotifierProvider(
      create: (context) => SettingsViewModel(),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Settings'
          ),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Material(
              child: Padding(
                padding: const EdgeInsets.only(left: 4),
                child: ListTile(
                  title: Text(
                    list[index].title(),
                  ),
                  subtitle: Text(
                    list[index].subtitle()
                  ),
                  trailing: switch (list[index].actionType()) {
                    SettingsAction.info => Padding(
                      padding: const EdgeInsets.only(right: 4),
                      child: Text(
                        list[index].action(context),
                        style: TextStyle(
                          fontSize: 16
                        ),
                      ),
                    ),
                    SettingsAction.toggle => Consumer<SettingsViewModel>(
                      builder: (context, viewModel, _) {
                        return list[index].action(
                          context,
                          viewModel: viewModel
                        );
                      },
                    ),
                  },
                ),
              ),
            );
          }
        ),
      ),
    );
  }
}