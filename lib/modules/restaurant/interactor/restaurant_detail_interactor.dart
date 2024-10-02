import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/restaurant/data/restaurant_repository.dart';

abstract class RestaurantDetailInteractor {
  Future<RestaurantDetail> getRestaurantDetail(String id);
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
}