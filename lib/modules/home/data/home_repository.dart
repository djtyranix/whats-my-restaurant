import 'dart:developer';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

abstract class HomeRepository {
  Future<List<RestaurantListResponse>> getRestaurants();
}

class HomeRepositoryImpl implements HomeRepository {

  final RemoteDataSource remote;

  HomeRepositoryImpl({
    required this.remote
  });

  @override
  Future<List<RestaurantListResponse>> getRestaurants() async {
    try {
      final json = await remote.request(ApiRequest.restaurantList, null, null, null);
      final List data = json['restaurants'];
      return data.map((object) => RestaurantListResponse.fromJson(object)).toList();
    } catch(e) {
      log(e.toString());
      throw Exception;
    }
  }
}