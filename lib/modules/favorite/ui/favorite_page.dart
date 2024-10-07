import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/helper/snackbar_helper.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/common/ui/restaurant_list_view.dart';
import 'package:whats_on_restaurant/modules/favorite/interactor/favorite_interactor.dart';
import 'package:whats_on_restaurant/modules/favorite/viewmodel/favorite_view_model.dart';

class FavoritePage extends StatefulWidget {
  static const routeName = '/favorite_page';

  const FavoritePage({super.key});
  
  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FavoriteViewModel(interactor: DependencyInjection.getInstance<FavoriteInteractor>()),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Your Favorites'
          ),
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Consumer<FavoriteViewModel>(
                  builder: (context, viewModel, _) {
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
                      case ResultState.noConnection:
                      case ResultState.noData:
                      case ResultState.error:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          SnackbarHelper.handleError(context: context, error: viewModel.message);
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