import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';

class SearchViewModel extends ViewModel {
  final SearchInteractor interactor;
  
  SearchViewModel({
    required this.interactor
  }) {
    Connectivity().onConnectivityChanged.listen((result) {
      _connectivityResult = result;
      _checkConnectivity();
    });

    getConnection();
  }

  late List<RestaurantList> _resultList;
  late ResultState _state = ResultState.noData;
  String _message = 'Data is Empty.';
  List<ConnectivityResult> _connectivityResult = [];

  String get message => _message;
  List<RestaurantList> get result => _resultList;
  ResultState get state => _state;

  void getConnection() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    _checkConnectivity();
  }

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

  Future<dynamic> _checkConnectivity() async {
    if (_connectivityResult.contains(ConnectivityResult.none)) {
      // No internet connection
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'Error: No internet connection.';
    }
  }
}