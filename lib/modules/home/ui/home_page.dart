import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/home/viewmodel/home_view_model.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => HomeViewModel(interactor: DependencyInjection.getIt.get<HomeInteractor>()),
      child: Scaffold(
        appBar: AppBar(
          centerTitle: false,
          forceMaterialTransparency: true,
          title: Text(
            'What\'s on Restaurant?',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 24
            ),
          )
        ),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(bottom: 8),
                child: Text(
                  'Some local goodness.',
                  style: TextStyle(
                    fontSize: 20
                  ),
                  textAlign: TextAlign.start,
                ),
              ),
              Expanded(
                child: Consumer<HomeViewModel>(
                  builder: (context, viewModel, _) {
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
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Error: ${viewModel.message}'),
                            backgroundColor: Colors.red,
                          ),
                        );
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