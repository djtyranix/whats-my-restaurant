import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/error_handler.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/common/ui/restaurant_list_view.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/home/viewmodel/home_view_model.dart';
import 'package:whats_on_restaurant/modules/search/ui/search_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final _focusNode = FocusNode();

  @override
  void didPopNext() {
    _focusNode.unfocus();
    var viewModel = Provider.of<HomeViewModel>(context);
    viewModel.getConnection();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    _focusNode.unfocus();
    super.didPopNext();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(interactor: DependencyInjection.getIt.get<HomeInteractor>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          forceMaterialTransparency: true,
          title: Padding(
            padding: EdgeInsets.only(left: 4),
            child: Text(
              'What\'s on Restaurant?',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 24
              ),
            ),
          )
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Some local goodness.',
                  style: TextStyle(
                    fontSize: 20
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: SearchBar(
                  focusNode: _focusNode,
                  hintText: 'Craving anything?',
                  leading: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Icon(
                      Icons.search
                    ),
                  ),
                  elevation: WidgetStatePropertyAll(0),
                  onTap: () {
                    _focusNode.unfocus();
                    Navigator.pushNamed(context, SearchPage.routeName);
                  },
                ),
              ),
              Expanded(
                child: Consumer<HomeViewModel>(
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
                      case ResultState.error:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ErrorHandler.handleError(context: context, error: viewModel.message);
                        });
                        return Container();
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