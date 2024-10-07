import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/restaurant/data/restaurant_repository.dart';

abstract class RestaurantDetailInteractor {
  Future<RestaurantDetail> getRestaurantDetail(String id);
  Future<bool> isFavorited(String id);
  Future<bool> addFavorite(RestaurantDetail restaurant);
  Future<bool> deleteFavorite(String id);
}

class RestaurantDetailInteractorImpl implements RestaurantDetailInteractor {
  final RestaurantRepository repository;

  RestaurantDetailInteractorImpl({
    required this.repository
  });

  @override
  Future<RestaurantDetail> getRestaurantDetail(String id) async {
    try {
      final data = await repository.getRestaurantDetail(id);
      return RestaurantDetail.fromResponse(data);
    } catch(e) {
      throw Exception;
    }
  }
  
  @override
  Future<bool> addFavorite(RestaurantDetail restaurant) async {
    try {
      return await repository.addFavorite(restaurant.toObject());
    } catch(e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<bool> deleteFavorite(String id) async {
    try {
      return await repository.deleteFavorite(id);
    } catch (e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<bool> isFavorited(String id) async {
    try {
      return await repository.isFavorited(id);
    } catch (e) {
      throw Exception(e);
    }
  }
}