import 'package:whats_on_restaurant/modules/search/data/search_repository.dart';

abstract class SearchInteractor {

}

class SearchInteractorImpl implements SearchInteractor {
  final SearchRepository repository;

  SearchInteractorImpl({
    required this.repository
  });
}