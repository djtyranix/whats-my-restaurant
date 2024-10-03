import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final HomeInteractor interactor = DependencyInjection.getIt.get<HomeInteractor>();
  late Future<List<RestaurantList>> _futureRestaurantList;

  @override
  void initState() {
    super.initState();
    _futureRestaurantList = interactor.getRestaurantList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              child: FutureBuilder(
                future: _futureRestaurantList, 
                builder: (context, snapshot) {
                  var state = snapshot.connectionState;
                  if (state != ConnectionState.done) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    if (snapshot.hasData) {
                      final list = snapshot.data ?? [];
                      return ListView.builder(
                        itemCount: list.length,
                        itemBuilder: (context, index) {
                          return _buildListItem(context, list[index]);
                        }
                      );
                    } else if (snapshot.hasError) {
                      return Center(child: Text("${snapshot.error}"));
                    } else {
                      return Container();
                    }
                  }
                }
              ),
            )
          ],
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