class MenuResponse {
  final String name;

  MenuResponse({
    required this.name
  });

  factory MenuResponse.fromJson(Map<String, dynamic> name) => MenuResponse(name: name['name']);
}

class RestaurantListResponse {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final num rating;

  RestaurantListResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.rating,
  });

  factory RestaurantListResponse.fromJson(Map<String, dynamic> restaurant) => RestaurantListResponse(
    id: restaurant['id'], 
    name: restaurant['name'], 
    description: restaurant['description'], 
    pictureId: restaurant['pictureId'], 
    city: restaurant['city'],
    rating: restaurant['rating']
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'description': description,
    'pictureId': pictureId,
    'city': city,
    'rating': rating
  };
}

class RestaurantDetailResponse {
  final String id;
  final String name;
  final String description;
  final String pictureId;
  final String city;
  final String address;
  final num rating;
  final List<MenuResponse> categories;
  final RestaurantMenuResponse menus;
  final List<RestaurantReviewResponse> customerReviews;

  RestaurantDetailResponse({
    required this.id,
    required this.name,
    required this.description,
    required this.pictureId,
    required this.city,
    required this.address,
    required this.rating,
    required this.categories,
    required this.menus,
    required this.customerReviews
  });

  factory RestaurantDetailResponse.fromJson(Map<String, dynamic> restaurant) => RestaurantDetailResponse(
    id: restaurant['id'], 
    name: restaurant['name'], 
    description: restaurant['description'], 
    pictureId: restaurant['pictureId'], 
    city: restaurant['city'],
    address: restaurant['address'],
    rating: restaurant['rating'], 
    categories: restaurant['categories'].map<MenuResponse>((category) => MenuResponse.fromJson(category)).toList(),
    menus: RestaurantMenuResponse.fromJson(restaurant['menus']),
    customerReviews: restaurant['customerReviews'].map<RestaurantReviewResponse>((review) => RestaurantReviewResponse.fromJson(review)).toList()
  );
}

class RestaurantMenuResponse {
  final List<MenuResponse> foods;
  final List<MenuResponse> drinks;

  RestaurantMenuResponse({
    required this.foods,
    required this.drinks
  });

  factory RestaurantMenuResponse.fromJson(Map<String, dynamic> menu) => RestaurantMenuResponse(
    foods: menu['foods'].map<MenuResponse>((object) => MenuResponse.fromJson(object)).toList(), 
    drinks: menu['drinks'].map<MenuResponse>((object) => MenuResponse.fromJson(object)).toList()
  );
}

class RestaurantReviewResponse {
  final String name;
  final String review;
  final String date;

  RestaurantReviewResponse({
    required this.name,
    required this.review,
    required this.date
  });

  factory RestaurantReviewResponse.fromJson(Map<String, dynamic> data) => RestaurantReviewResponse(
    name: data['name'], 
    review: data['review'], 
    date: data['date']
  );
}