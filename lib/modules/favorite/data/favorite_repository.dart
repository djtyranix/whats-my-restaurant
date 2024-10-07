import 'package:whats_on_restaurant/data/source/local_data_source.dart';
import 'package:whats_on_restaurant/domain/objects/restaurant_list_object.dart';

abstract class FavoriteRepository {
  Future<List<RestaurantListObject>> getLocalRestaurantList();
}

class FavoriteRepositoryImpl implements FavoriteRepository {
  final LocalDataSource local;

  FavoriteRepositoryImpl({
    required this.local
  });

  @override
  Future<List<RestaurantListObject>> getLocalRestaurantList() async {
    var result = await local.getAllData<RestaurantListObject>();
    return result.map((data) {
      return data;
    }).toList();
  }
}