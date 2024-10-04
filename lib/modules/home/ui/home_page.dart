import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/error_handler.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/home/viewmodel/home_view_model.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';
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
                            return _buildListItem(context, viewModel.result[index]);
                          }
                        );
                      case ResultState.noData:
                      case ResultState.error:
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          ErrorHandler.handleError(context, viewModel.message);
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

  Widget _buildListItem(BuildContext context, RestaurantList entry) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigator.pushNamed(context, RestaurantDetailPage.routeName, arguments: entry.id);
        },
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                entry.pictureId,
                width: 120,
                height: 80,
                fit: BoxFit.fill,
                errorBuilder: (context, error, _) => const Center(child: Icon(Icons.error)),
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (frame == null) {
                    return SizedBox(
                      width: 120,
                      height: 80,
                      child: Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()
                        )
                      )
                    );
                  }

                  return child;
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) { return child; }
                  return SizedBox(
                    width: 120,
                    height: 80,
                    child: Center(
                      child: SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        )
                      )
                    )
                  );
                },
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      entry.name,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.place,
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(entry.city),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.star,
                          color: Color(0xFFFFD700),
                          size: 16,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 4),
                          child: Text(entry.rating.toString())
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}