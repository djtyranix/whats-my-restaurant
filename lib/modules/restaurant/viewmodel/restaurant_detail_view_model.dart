import 'package:flutter/widgets.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';

class RestaurantDetailViewModel extends ChangeNotifier {
  final RestaurantDetailInteractor interactor;
  final String id;

  late RestaurantDetail _result;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  RestaurantDetail get result => _result;
  ResultState get state => _state;

  RestaurantDetailViewModel({
    required this.interactor,
    required this.id
  }) {
    _fetchRestaurantDetailWithId(id);
  }

  Future<dynamic> _fetchRestaurantDetailWithId(String id) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await interactor.getRestaurantDetail(id);
      _state = ResultState.hasData;
      notifyListeners();
      return _result = data;
    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}