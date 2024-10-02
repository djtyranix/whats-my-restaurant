class MenuResponse {
  final String name;

  MenuResponse({
    required this.name
  });

  factory MenuResponse.fromJson(Map<String, dynamic> name) => MenuResponse(name: name['name']);
}

class RestaurantResponse {
  final List<RestaurantResponseItem> restaurants;

  RestaurantResponse({
    required this.restaurants
  });

  factory RestaurantResponse.fromJson(Map<String, dynamic> json) => RestaurantResponse(
    restaurants: json['restaurants'].map((object) => RestaurantResponseItem.fromJson(object))
  );
}

class RestaurantResponseItem {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;
  final RestaurantMenuResponseItem menus;

  RestaurantResponseItem({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
    required this.menus
  });

  factory RestaurantResponseItem.fromJson(Map<String, dynamic> restaurant) => RestaurantResponseItem(
    id: restaurant['id'], 
    name: restaurant['name'], 
    description: restaurant['description'], 
    pictureId: restaurant['pictureId'], 
    city: restaurant['city'], 
    rating: restaurant['rating'], 
    menus: RestaurantMenuResponseItem.fromJson(restaurant['menus']),
  );
}

class RestaurantMenuResponseItem {
  final List<MenuResponse> foods;
  final List<MenuResponse> drinks;

  RestaurantMenuResponseItem({
    required this.foods,
    required this.drinks
  });

  factory RestaurantMenuResponseItem.fromJson(Map<String, dynamic> menu) => RestaurantMenuResponseItem(
    foods: menu['foods'].map<MenuResponse>((object) => MenuResponse.fromJson(object)).toList(), 
    drinks: menu['drinks'].map<MenuResponse>((object) => MenuResponse.fromJson(object)).toList()
  );
}