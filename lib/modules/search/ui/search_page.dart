import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/error_handler.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/common/ui/restaurant_list_view.dart';
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
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, _) {
                    return SearchBar(
                      autoFocus: true,
                      hintText: 'A fancy restaurant name...',
                      leading: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Icon(
                          Icons.search
                        ),
                      ),
                      elevation: WidgetStatePropertyAll(0),
                      onSubmitted: (query) {
                        if (query.isNotEmpty) {
                          viewModel.search(query);
                        }
                      }
                    );
                  },
                ),
              ),
              Expanded(
                child: Consumer<SearchViewModel>(
                  builder: (context, viewModel, child) {
                    switch (viewModel.state) {
                      case ResultState.loading:
                        return const Center(child: CircularProgressIndicator());
                      case ResultState.hasData:
                        return ListView.builder(
                          itemCount: viewModel.result.length,
                          itemBuilder: (context, index) {
                            return RestaurantListView(entry: viewModel.result[index]);
                          }
                        );
                      case ResultState.noData:
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search,
                              size: 80,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                viewModel.message
                              ),
                            )
                          ],
                        );
                      case ResultState.noConnection:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ErrorHandler.handleError(
                            context: context, 
                            error: viewModel.message,
                            autoDismiss: false,
                            actionLabel: 'Retry', 
                            action: () {
                            viewModel.getConnection();
                          });
                        });
                        return Container();
                      case ResultState.error:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ErrorHandler.handleError(context: context, error: viewModel.message);
                        });
                        return Container();
                    }
                  }
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}