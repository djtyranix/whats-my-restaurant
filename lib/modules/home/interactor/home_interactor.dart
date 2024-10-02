import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';

abstract class HomeInteractor {
  Future<List<RestaurantList>> getRestaurantList();
}

class HomeInteractorImpl implements HomeInteractor {
  final HomeRepository repository;

  HomeInteractorImpl({
    required this.repository
  });

  @override
  Future<List<RestaurantList>> getRestaurantList() async {
    try {
      final list = await repository.getRestaurants();
      return list.map((response) => RestaurantList.fromResponse(response)).toList();
    } catch(e) {
      throw Exception;
    }
  }
}