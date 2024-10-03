import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:whats_on_restaurant/common/di.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
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
  final RestaurantDetailInteractor interactor = DependencyInjection.getIt.get<RestaurantDetailInteractor>();
  late Future<RestaurantDetail> _futureRestaurantDetail;

  @override
  void initState() {
    super.initState();
    _futureRestaurantDetail = interactor.getRestaurantDetail(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: FutureBuilder(
        future: _futureRestaurantDetail,
        builder: (context, snapshot) {
          var state = snapshot.connectionState;
          if (state != ConnectionState.done) {
            // Loading
            return Center(child: CircularProgressIndicator());
          } else {
            if (snapshot.hasData) {
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
                                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                                  if (frame == null) {
                                    return Center(
                                      child: CircularProgressIndicator()
                                    );
                                  }

                                  return child;
                                },
                                loadingBuilder: (context, child, loadingProgress) {
                                  if (loadingProgress == null) { return child; }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value: loadingProgress.expectedTotalBytes != null
                                          ? loadingProgress.cumulativeBytesLoaded /
                                              loadingProgress.expectedTotalBytes!
                                          : null,
                                    )
                                  );
                                },
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
                          padding: const EdgeInsets.only(top: 8),
                          child: Wrap(
                            spacing: 8,
                            runSpacing: 4,
                            children: _buildCategoryChips(context, data.categories),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
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
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Our Menu',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4),
                          child: Text(
                            'Foods',
                            style: TextStyle(
                              fontSize: 16,
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
                                return _buildMenuItem(
                                  context, 
                                  data.menus.foods[index].name,
                                  isLast: index == data.menus.foods.length - 1
                                );
                              }
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 16),
                          child: Text(
                            'Drinks',
                            style: TextStyle(
                              fontSize: 16,
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
                                return _buildMenuItem(
                                  context,
                                  data.menus.drinks[index].name,
                                  isFood: false,
                                  isLast: index == data.menus.drinks.length - 1
                                );
                              }
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Reviews',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 8),
                          child: SizedBox(
                            height: 110,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.customerReviews.length > 5
                                      ? data.customerReviews.take(5).length + 1
                                      : data.customerReviews.length,
                              itemBuilder: (context, index) {
                                return _buildReviewItem(
                                  context, data.customerReviews[index], 
                                  isLast: data.customerReviews.length > 5
                                        ? index == 5
                                        : index == data.customerReviews.length - 1,
                                  isViewAll: data.customerReviews.length > 5
                                          ? index == 5
                                          : false
                                );
                              }
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                // TODO: Add error handling
                return Center(child: Text("Data is Empty")); 
              }
            } else if (snapshot.hasError) {
              // TODO: Add error handling
              return Center(child: Text("${snapshot.error}"));
            } else {
              return Container();
            }
          }
        }
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.only(top: 8, left: 20, right: 20, bottom: 32),
        child: Container(
          height: 54,
          child: ElevatedButton(
            onPressed: () {
              // TODO: Add Review Action
            }, 
            style: ElevatedButton.styleFrom(shape: StadiumBorder()),
            child: Text(
              'Add Review'
            )
          ),
        ),
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
                  frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                    if (frame == null) {
                      return Center(
                        child: SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator()
                        )
                      );
                    }

                    return child;
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) { return child; }
                    return Center(
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
                    );
                  },
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

  List<Widget> _buildCategoryChips(BuildContext context, List<Menu> categories) {
    if (categories.isNotEmpty) {
      return categories.map(
        (category) => Chip(
          label: Text(
            category.name,
            style: TextStyle(
              fontSize: 12
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
      ).toList();
    } else {
      return [
        Chip(
          label: Text(
            "Restaurant",
            style: TextStyle(
              fontSize: 12
            ),
          ),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        )
      ];
    }
  }

  Widget _buildReviewItem(BuildContext context, RestaurantReview review, {bool isLast = false, bool isViewAll = false}) {
    if (isViewAll) {
      return GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          // TODO: Add navigation to All Reviews
        },
        child: SizedBox(
          width: 120,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Center(
              child: Text(
                "View All >",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ),
      );
    } else {
      return Padding(
        padding: EdgeInsets.only(right: isLast ? 0 : 10),
        child: Card(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: SizedBox(
            width: 200,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    review.name,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 12
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Text(
                    review.date,
                    style: TextStyle(
                      fontSize: 12
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      review.review,
                      style: TextStyle(
                        letterSpacing: 0
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}