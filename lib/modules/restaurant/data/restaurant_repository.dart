import 'dart:developer';
import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:whats_on_restaurant/data/source/local_data_source.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';
import 'package:whats_on_restaurant/domain/objects/restaurant_list_object.dart';

abstract class RestaurantRepository {
  Future<RestaurantDetailResponse> getRestaurantDetail(String id);
  Future<bool> isFavorited(String id);
  Future<bool> addFavorite(RestaurantListObject object);
  Future<bool> deleteFavorite(String id);
}

class RestaurantRepositoryImpl implements RestaurantRepository {
  final RemoteDataSource remote;
  final LocalDataSource local;

  RestaurantRepositoryImpl({
    required this.remote,
    required this.local
  });

  @override
  Future<RestaurantDetailResponse> getRestaurantDetail(String id) async {
    try {
      final json = await remote.request(ApiRequest.restaurantDetail, id, null, null);
      final data = json['restaurant'];
      return RestaurantDetailResponse.fromJson(data);
    } catch(e) {
      log(e.toString());
      throw Exception(e);
    }
  }
  
  @override
  Future<bool> addFavorite(RestaurantListObject object) async {
    try {
      await local.addData<RestaurantListObject>(object);
      return true;
    } catch(e) {
      throw Exception(e);
    }
  }
  
  @override
  Future<bool> isFavorited(String id) async {
    try {
      return await local.isExist<RestaurantListObject>(id);
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<bool> deleteFavorite(String id) async {
    try {
      await local.deleteData<RestaurantListObject>(id);
      return true;
    } catch(e) {
      throw Exception(e);
    }
  }
}