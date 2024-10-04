import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';

class SearchViewModel extends ViewModel {
  final SearchInteractor interactor;
  
  SearchViewModel({
    required this.interactor
  });

  late List<RestaurantList> _resultList;
  late ResultState _state = ResultState.noData;
  String _message = 'Data is Empty.';

  String get message => _message;
  List<RestaurantList> get result => _resultList;
  ResultState get state => _state;

  Future<dynamic> search(String query) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final list = await interactor.searchRestaurant(query);
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