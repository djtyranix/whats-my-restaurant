import 'dart:convert';
import 'dart:developer';
import 'package:flutter/services.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';

abstract class RestaurantRepository {
  Future<RestaurantResponseItem> getRestaurantDetail(String id);
}

class RestaurantRepositoryImpl implements RestaurantRepository {
  @override
  Future<RestaurantResponseItem> getRestaurantDetail(String id) async {
    try {
      final json = await rootBundle.loadString('assets/json/local_restaurant.json');
      final List dataList = jsonDecode(json)['restaurants'];
      final list = dataList.map((object) => RestaurantResponseItem.fromJson(object)).toList();
      return list.where((item) => item.id == id).toList().first;
    } catch(e) {
      log(e.toString());
      throw Exception;
    }
  }
}