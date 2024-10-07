import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/helper/notification_helper.dart';
import 'package:whats_on_restaurant/common/helper/snackbar_helper.dart';
import 'package:whats_on_restaurant/common/navigation.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/common/ui/restaurant_list_view.dart';
import 'package:whats_on_restaurant/main.dart';
import 'package:whats_on_restaurant/modules/favorite/ui/favorite_page.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/home/viewmodel/home_view_model.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';
import 'package:whats_on_restaurant/modules/search/ui/search_page.dart';
import 'package:whats_on_restaurant/modules/settings/ui/settings_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with RouteAware {
  final NotificationHelper _notificationHelper = DependencyInjection.getInstance();
  final _focusNode = FocusNode();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context) as PageRoute);
  }

  @override
  void didPopNext() {
    _focusNode.unfocus();
    super.didPopNext();
  }

  @override
  void didPushNext() {
    _focusNode.unfocus();
    super.didPopNext();
  }

  @override
  void initState() {
    super.initState();
    _notificationHelper.configureSelectNotificationSubject(
      RestaurantDetailPage.routeName
    );
  }

  @override
  void dispose() {
    selectNotificationSubject.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(interactor: DependencyInjection.getInstance<HomeInteractor>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          forceMaterialTransparency: true,
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  _goToFavoritePage(withContext: context);
                },
                child: Icon(
                  Icons.favorite_outline_outlined,
                  weight: 100,
                  size: 28,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: GestureDetector(
                onTap: () {
                  _goToSettingsPage(withContext: context);
                },
                child: Icon(
                  Icons.settings_outlined,
                  weight: 100,
                  size: 28,
                ),
              ),
            )
          ],
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'What\'s on Restaurant?',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 32
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Text(
                  'Some local goodness.',
                  style: TextStyle(
                    fontSize: 18
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
                    Navigation.navigate(toRoute: SearchPage.routeName);
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
                          SnackbarHelper.handleError(context: context, error: viewModel.message);
                        });
                        return Container();
                      case ResultState.noConnection:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          SnackbarHelper.handleError(
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

  void _goToSettingsPage({required BuildContext withContext}) {
    Navigation.navigate(toRoute: SettingsPage.routeName);
  }

  void _goToFavoritePage({required BuildContext withContext}) {
    Navigation.navigate(toRoute: FavoritePage.routeName);
  }
}