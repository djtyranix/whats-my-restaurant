import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

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

  factory RestaurantList.fromResponse(RestaurantResponseItem response) => RestaurantList(
    id: response.id, 
    name: response.name, 
    city: response.city, 
    rating: response.rating,
    pictureId: response.pictureId
  );
}

class RestaurantDetail {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final RestaurantMenu menus;

  RestaurantDetail({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus,
  });

  factory RestaurantDetail.fromResponse(RestaurantResponseItem response) => RestaurantDetail(
    id: response.id, 
    name: response.name, 
    description: response.description, 
    pictureId: response.pictureId, 
    city: response.city, 
    rating: response.rating, 
    menus: RestaurantMenu.fromResponse(response.menus)
  );
}

class RestaurantMenu{
  final List<Menu> foods;
  final List<Menu> drinks;

  RestaurantMenu({
    required this.foods,
    required this.drinks
  });

  factory RestaurantMenu.fromResponse(RestaurantMenuResponseItem response) => RestaurantMenu(
    foods: response.foods.map(((model) => Menu.fromResponse(model))).toList(),
    drinks: response.drinks.map(((model) => Menu.fromResponse(model))).toList()
  );
}