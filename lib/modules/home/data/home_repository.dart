import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

abstract class HomeRepository {
  Future<List<RestaurantResponseItem>> getRestaurants();
}

class HomeRepositoryImpl implements HomeRepository {
  @override
  Future<List<RestaurantResponseItem>> getRestaurants() async {
    try {
      final json = await rootBundle.loadString('assets/json/local_restaurant.json');
      final List data = jsonDecode(json)['restaurants'];
      return data.map((object) => RestaurantResponseItem.fromJson(object)).toList();
    } catch(e) {
      log(e.toString());
      throw Exception;
    }
  }
}