import 'package:flutter/material.dart';
import 'package:whats_on_restaurant/common/navigation.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/restaurant/ui/restaurant_detail_page.dart';

class RestaurantListView extends StatelessWidget {
  final RestaurantList entry;

  const RestaurantListView({super.key, 
    required this.entry
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Navigation.navigate(toRoute: RestaurantDetailPage.routeName, arguments: entry.id);
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