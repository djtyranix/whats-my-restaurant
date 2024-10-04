import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/common/result_state.dart';
import 'package:whats_on_restaurant/modules/review/interactor/review_interactor.dart';

class AddReviewViewModel extends ViewModel {
  final ReviewInteractor interactor;
  final String id;

  late bool _result;
  late ResultState _state;
  String _message = '';

  String get message => _message;
  bool get result => _result;
  ResultState get state => _state;

  AddReviewViewModel({
    required this.interactor,
    required this.id
  });

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
}