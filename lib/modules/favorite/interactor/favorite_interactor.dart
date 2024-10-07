import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/favorite/data/favorite_repository.dart';

abstract class FavoriteInteractor {
  Future<List<RestaurantList>> getRestaurantList();
}

class FavoriteInteractorImpl implements FavoriteInteractor {
  final FavoriteRepository repository;

  FavoriteInteractorImpl({
    required this.repository
  });

  @override
  Future<List<RestaurantList>> getRestaurantList() async {
    var result = await repository.getLocalRestaurantList();
    return result.map((object) {
      return RestaurantList.fromObject(object);
    }).toList();
  }
}