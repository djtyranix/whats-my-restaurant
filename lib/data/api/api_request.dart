enum ApiRequestType {
  get,
  post
}

enum ApiRequest {
  restaurantList,
  restaurantDetail,
  searchRestaurant,
  addReview;

  final String baseUrl = 'restaurant-api.dicoding.dev';

  String authority() {
    return baseUrl;
  }

  String requestUrl() {
    switch (this) {
      case ApiRequest.restaurantList:
        return '/list';
      case ApiRequest.restaurantDetail:
        return '/detail';
      case ApiRequest.searchRestaurant:
        return '/search';
      case ApiRequest.addReview:
        return '/review';
      default:
        return '';
    }
  }

  bool isNeedId() {
    switch (this) {
      case ApiRequest.restaurantDetail:
        return true;
      default:
        return false;
    }
  }

  ApiRequestType requestType() {
    switch (this) {
      case ApiRequest.addReview:
        return ApiRequestType.post;
      default:
        return ApiRequestType.get;
    }
  }
}