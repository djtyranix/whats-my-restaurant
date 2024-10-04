import 'package:get_it/get_it.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/restaurant/data/restaurant_repository.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';
import 'package:whats_on_restaurant/modules/review/interactor/review_interactor.dart';
import 'package:whats_on_restaurant/modules/review/repository/review_repository.dart';
import 'package:whats_on_restaurant/modules/search/data/search_repository.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    _registerDataSource();
    _registerRepository();
    _registerInteractor();
  }

  static void _registerDataSource() {
    getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());
  }

  static void _registerRepository() {
    getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(
        remote: getIt.get<RemoteDataSource>()
      )
    );

    getIt.registerSingleton<RestaurantRepository>(
      RestaurantRepositoryImpl(
        remote: getIt.get<RemoteDataSource>()
      )
    );

    getIt.registerSingleton<ReviewRepository>(
      ReviewRepositoryImpl(
        remote: getIt.get<RemoteDataSource>()
      )
    );

    getIt.registerSingleton<SearchRepository>(
      SearchRepositoryImpl(
        remote: getIt.get<RemoteDataSource>()
      )
    );
  }

  static void _registerInteractor() {
    getIt.registerSingleton<HomeInteractor>(
      HomeInteractorImpl(
        repository: getIt.get<HomeRepository>()
      )
    );

    getIt.registerSingleton<RestaurantDetailInteractor>(
      RestaurantDetailInteractorImpl(
        repository: getIt.get<RestaurantRepository>()
      )
    );

    getIt.registerSingleton<ReviewInteractor>(
      ReviewInteractorImpl(
        repository: getIt.get<ReviewRepository>()
      )
    );

    getIt.registerSingleton<SearchInteractor>(
      SearchInteractorImpl(
        repository: getIt.get<SearchRepository>()
      )
    );
  }
}