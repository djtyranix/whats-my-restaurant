import 'dart:developer';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

abstract class RestaurantRepository {
  Future<RestaurantDetailResponse> getRestaurantDetail(String id);
}

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RemoteDataSource remote;

  RestaurantRepositoryImpl({
    required this.remote
  });

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final json = await remote.request(ApiRequest.restaurantDetail, id, null, null);
      final data = json['restaurant'];
      return RestaurantDetailResponse.fromJson(data);
    } catch(e) {
      log(e.toString());
      throw Exception;
    }
  }
}