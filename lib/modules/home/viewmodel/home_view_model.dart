import 'package:flutter/widgets.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeInteractor interactor;

  late List<RestaurantList> _resultList;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  List<RestaurantList> get result => _resultList;
  ResultState get state => _state;

  HomeViewModel({
    required this.interactor
  }) {
    _fetchRestaurantList();
  }

  Future<dynamic> _fetchRestaurantList() async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await interactor.getRestaurantList();
      if (list.isEmpty) {
        _state = ResultState.noData;
        notifyListeners();
        return _message = "Data is empty.";
      } else {
        _state = ResultState.hasData;
        notifyListeners();
        return _resultList = list;
      }
    } catch(e) {
      _state = ResultState.error;
      notifyListeners();
      return _message = 'Error: $e';
    }
  }
}