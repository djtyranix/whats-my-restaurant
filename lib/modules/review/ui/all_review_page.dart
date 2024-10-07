import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';

class AllReviewPage extends StatelessWidget {
  static const routeName = '/all_reviews';
  final List<RestaurantReview> reviews;

  const AllReviewPage({super.key, 
    required this.reviews
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('All Reviews'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: ListView.builder(
                itemCount: reviews.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      width: double.infinity,
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
                                  reviews[index].name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  reviews[index].date,
                                  style: TextStyle(
                                    fontSize: 12
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(top: 8),
                                  child: ReadMoreText(
                                    reviews[index].review,
                                    textAlign: TextAlign.left,
                                    trimMode: TrimMode.Line,
                                    trimLines: 2,
                                    colorClickableText: Colors.blue,
                                    trimCollapsedText: 'Show more',
                                    trimExpandedText: 'Show less',
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      )
    );
  }
}