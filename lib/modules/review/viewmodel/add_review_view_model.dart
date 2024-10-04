import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/modules/review/interactor/review_interactor.dart';

class AddReviewViewModel extends ViewModel {
  final ReviewInteractor interactor;
  final String id;

  late bool _result;
  late ResultState _state;
  String _message = '';
  List<ConnectivityResult> _connectivityResult = [];

  String get message => _message;
  bool get result => _result;
  ResultState get state => _state;

  AddReviewViewModel({
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

  Future<dynamic> addReview(String name, String review) async {
    try {
      _state = ResultState.loading;
      notifyListeners();
      final data = await interactor.addReview(id, name, review);
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
    }
  }
}