import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/search/data/search_repository.dart';

abstract class SearchInteractor {
  Future<List<RestaurantList>> searchRestaurant(String query);
}

class SearchInteractorImpl implements SearchInteractor {
  final SearchRepository repository;

  SearchInteractorImpl({
    required this.repository
  });
  
  @override
  Future<List<RestaurantList>> searchRestaurant(String query) async {
    try {
      final list = await repository.searchRestaurant(query);
      return list.map((response) => RestaurantList.fromResponse(response)).toList();
    } catch(e) {
      throw Exception;
    }
  }
}