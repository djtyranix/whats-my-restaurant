import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/favorite/interactor/favorite_interactor.dart';

class FavoriteViewModel extends ViewModel {
  final FavoriteInteractor interactor;

  FavoriteViewModel({
    required this.interactor
  }) {
    _fetchRestaurantList();
  }

  late List<RestaurantList> _resultList;
  late ResultState _state = ResultState.loading;
  String _message = '';

  String get message => _message;
  List<RestaurantList> get result => _resultList;
  ResultState get state => _state;

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