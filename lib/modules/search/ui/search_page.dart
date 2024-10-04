import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';
import 'package:whats_on_restaurant/modules/search/viewmodel/search_view_model.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  static const routeName = '/search_page';

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SearchViewModel(interactor: DependencyInjection.getIt.get<SearchInteractor>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Search'
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SearchBar(
                  autoFocus: true,
                  hintText: 'Craving anything?',
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search
                    ),
                  ),
                  elevation: WidgetStatePropertyAll(0),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}