import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/domain/models/restaurant.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';

class RestaurantDetailViewModel extends ViewModel {
  final RestaurantDetailInteractor interactor;
  final String id;

  late RestaurantDetail _result;
  late ResultState _state = ResultState.loading;
  String _message = '';
  List<ConnectivityResult> _connectivityResult = [];

  String get message => _message;
  RestaurantDetail get result => _result;
  ResultState get state => _state;

  RestaurantDetailViewModel({
    required this.interactor,
    required this.id
  }) {
    Connectivity().onConnectivityChanged.listen((result) {
      _connectivityResult = result;
      _checkConnectivity();
    });

    getConnection();
  }

  void getConnection() async {
    _connectivityResult = await Connectivity().checkConnectivity();
    _checkConnectivity();
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

  Future<dynamic> _checkConnectivity() async {
    if (_connectivityResult.contains(ConnectivityResult.none)) {
      // No internet connection
      _state = ResultState.noConnection;
      notifyListeners();
      return _message = 'Error: No internet connection.';
    } else {
      return _fetchRestaurantDetailWithId(id);
    }
  }
}