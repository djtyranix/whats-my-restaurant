import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';

class RestaurantDetailPage extends StatefulWidget {
  static const routeName = '/restaurant_detail';

  final String id;

  const RestaurantDetailPage({super.key, required this.id});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  var top = 0.0;

  @override
  Widget build(BuildContext context) {
    final RestaurantDetailInteractor interactor = DependencyInjection.getIt.get<RestaurantDetailInteractor>();

    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: interactor.getRestaurantDetail(widget.id),
        builder: (context, snapshot) {
          final data = snapshot.data;

          if (data != null) {
            return NestedScrollView(
              headerSliverBuilder: (context, isScrolled) {
                return [
                  SliverAppBar(
                    leading: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          }, 
                          icon: Icon(
                            Icons.chevron_left
                          )
                        ),
                      ),
                    ),
                    pinned: true,
                    expandedHeight: 200,
                    flexibleSpace: LayoutBuilder(
                      builder: (context, constraints) {
                        top = constraints.biggest.height;
                        var toolbarHeight = MediaQuery.of(context).padding.top + kToolbarHeight;
                        return FlexibleSpaceBar(
                          background: Image.network(
                            data.pictureId,
                            fit: BoxFit.fitWidth,
                          ),
                          title: AnimatedOpacity(
                            duration: Duration(milliseconds: 300), 
                            opacity: 1.0,
                            child: Text(
                              top == toolbarHeight
                              ? data.name
                              : ""
                            ),
                          ),
                        );
                      },
                    ),
                  )
                ];
              },
              body: SingleChildScrollView(
                padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      data.name,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: Row(
                        children: [
                          Icon(
                            Icons.place,
                            size: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(data.city),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 16),
                            child: Icon(
                              Icons.star,
                              color: Color(0xFFFFD700),
                              size: 20,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 4),
                            child: Text(data.rating.toString()),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'About Us',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    ReadMoreText(
                      data.description,
                      textAlign: TextAlign.justify,
                      trimMode: TrimMode.Line,
                      trimLines: 6,
                      colorClickableText: Colors.blue,
                      trimCollapsedText: 'Show more',
                      trimExpandedText: 'Show less',
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Our Menu',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: Text(
                        'Foods',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.menus.foods.length,
                          itemBuilder: (context, index) {
                            return _buildMenuItem(context, data.menus.foods[index].name);
                          }
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 16),
                      child: Text(
                        'Drinks',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8),
                      child: SizedBox(
                        height: 120,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: data.menus.drinks.length,
                          itemBuilder: (context, index) {
                            return _buildMenuItem(context, data.menus.drinks[index].name, isFood: false);
                          }
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return Container();
          }
        }
      ),
    );
  }

  Widget _buildMenuItem(BuildContext context, String title, {bool isFood = true, bool isLast = false}) {
    return Padding(
      padding: EdgeInsets.only(right: isLast ? 0 : 10),
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: SizedBox(
          width: 180,
          child: Column(
            children: [
              SizedBox(
                height: 80,
                width: 180,
                child: Image.network(
                  isFood
                  ? 'https://media.cnn.com/api/v1/images/stellar/prod/gettyimages-1273516682.jpg?c=16x9&q=h_833,w_1480,c_fill'
                  : 'https://www.spoton.com/blog/content/images/size/w1200/2023/08/Mocktail--zero-proof-cocktails--and-different-non-alcoholic-drinks-1.jpeg',
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8),
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 12,
                    height: 1
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}