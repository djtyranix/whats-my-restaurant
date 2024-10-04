import 'package:whats_on_restaurant/common/extensions.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';

class SearchViewModel extends ViewModel {
  final SearchInteractor interactor;
  
  SearchViewModel({
    required this.interactor
  });
}