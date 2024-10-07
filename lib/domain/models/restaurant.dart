import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';
import 'package:whats_on_restaurant/domain/objects/restaurant_list_object.dart';

class Menu {
  final String name;

  Menu({
    required this.name
  });

  factory Menu.fromResponse(MenuResponse response) => Menu(name: response.name);
}

class RestaurantList {
  final String id;
  final String name;
  final String city;
  final num rating;
  final String pictureId;

  RestaurantList({
    required this.id,
    required this.name,
    required this.city,
    required this.rating,
    required this.pictureId
  });

  factory RestaurantList.fromResponse(RestaurantListResponse response) => RestaurantList(
    id: response.id, 
    name: response.name, 
    city: response.city, 
    rating: response.rating,
    pictureId: 'https://restaurant-api.dicoding.dev/images/small/${response.pictureId}'
  );
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final RestaurantMenu menus;
  final num rating;
  final List<Menu> categories;
  final List<RestaurantReview> customerReviews;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.menus,
    required this.categories,
    required this.customerReviews
  });

  factory RestaurantDetail.fromResponse(RestaurantDetailResponse response) => RestaurantDetail(
    id: response.id, 
    name: response.name, 
    description: response.description, 
    pictureId: 'https://restaurant-api.dicoding.dev/images/large/${response.pictureId}', 
    city: response.city,
    address: response.address,
    rating: response.rating, 
    menus: RestaurantMenu.fromResponse(response.menus),
    categories: response.categories.map((category) => Menu.fromResponse(category)).toList(),
    customerReviews: response.customerReviews.map((review) => RestaurantReview.fromResponse(review)).toList()
  );

  RestaurantListObject toObject() {
    return RestaurantListObject(id, name, city, rating, pictureId);
  }
}

class RestaurantMenu{
  final List<Menu> foods;
  final List<Menu> drinks;

  RestaurantMenu({
    required this.foods,
    required this.drinks
  });

  factory RestaurantMenu.fromResponse(RestaurantMenuResponse response) => RestaurantMenu(
    foods: response.foods.map(((model) => Menu.fromResponse(model))).toList(),
    drinks: response.drinks.map(((model) => Menu.fromResponse(model))).toList()
  );
}

class RestaurantReview {
  final String name;
  final String review;
  final String date;

  RestaurantReview({
    required this.name,
    required this.review,
    required this.date
  });

  factory RestaurantReview.fromResponse(RestaurantReviewResponse data) => RestaurantReview(
    name: data.name, 
    review: data.review, 
    date: data.date
  );
}