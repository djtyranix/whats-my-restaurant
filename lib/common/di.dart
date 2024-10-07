import 'package:get_it/get_it.dart';
import 'package:whats_on_restaurant/common/helper/background_service.dart';
import 'package:whats_on_restaurant/common/helper/notification_helper.dart';
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
  static GetIt _getIt = GetIt.instance;

  static T getInstance<T extends Object>() {
    return _getIt.get();
  }

  static void configure() {
    _registerHelpers();
    _registerDataSource();
    _registerRepository();
    _registerInteractor();
  }

  static void _registerHelpers() {
    _getIt.registerSingleton(NotificationHelper());
    _getIt.registerSingleton(BackgroundService());
  }

  static void _registerDataSource() {
    _getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());
  }

  static void _registerRepository() {
    _getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(
        remote: _getIt.get<RemoteDataSource>()
      )
    );

    _getIt.registerSingleton<RestaurantRepository>(
      RestaurantRepositoryImpl(
        remote: _getIt.get<RemoteDataSource>()
      )
    );

    _getIt.registerSingleton<ReviewRepository>(
      ReviewRepositoryImpl(
        remote: _getIt.get<RemoteDataSource>()
      )
    );

    _getIt.registerSingleton<SearchRepository>(
      SearchRepositoryImpl(
        remote: _getIt.get<RemoteDataSource>()
      )
    );
  }

  static void _registerInteractor() {
    _getIt.registerSingleton<HomeInteractor>(
      HomeInteractorImpl(
        repository: _getIt.get<HomeRepository>()
      )
    );

    _getIt.registerSingleton<RestaurantDetailInteractor>(
      RestaurantDetailInteractorImpl(
        repository: _getIt.get<RestaurantRepository>()
      )
    );

    _getIt.registerSingleton<ReviewInteractor>(
      ReviewInteractorImpl(
        repository: _getIt.get<ReviewRepository>()
      )
    );

    _getIt.registerSingleton<SearchInteractor>(
      SearchInteractorImpl(
        repository: _getIt.get<SearchRepository>()
      )
    );
  }
}