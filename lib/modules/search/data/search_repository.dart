import 'package:whats_on_restaurant/data/source/remote_data_source.dart';

abstract class SearchRepository {

}

class SearchRepositoryImpl implements SearchRepository {
  final RemoteDataSource remote;

  SearchRepositoryImpl({
    required this.remote
  });
}