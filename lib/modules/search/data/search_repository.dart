import 'dart:developer';

import 'package:whats_on_restaurant/data/api/api_request.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

abstract class SearchRepository {
  Future<List<RestaurantListResponse>> searchRestaurant(String query);
}

class SearchRepositoryImpl implements SearchRepository {
  final RemoteDataSource remote;

  SearchRepositoryImpl({
    required this.remote
  });

  @override
  Future<List<RestaurantListResponse>> searchRestaurant(String query) async {
    try {
      var queryData = {
        'q': query
      };
      final json = await remote.request(ApiRequest.searchRestaurant, null, null, queryData);
      final List data = json['restaurants'];
      return data.map((object) => RestaurantListResponse.fromJson(object)).toList();
    } catch(e) {
      log(e.toString());
      throw Exception('Error retrieving result from search query: $query');
    }
  }
}