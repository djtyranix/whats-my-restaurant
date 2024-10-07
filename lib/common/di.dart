import 'package:get_it/get_it.dart';
import 'package:realm/realm.dart';
import 'package:whats_on_restaurant/common/helper/background_service.dart';
import 'package:whats_on_restaurant/common/helper/notification_helper.dart';
import 'package:whats_on_restaurant/data/source/local_data_source.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:whats_on_restaurant/domain/objects/restaurant_list_object.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/restaurant/data/restaurant_repository.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';
import 'package:whats_on_restaurant/modules/review/interactor/review_interactor.dart';
import 'package:whats_on_restaurant/modules/review/repository/review_repository.dart';
import 'package:whats_on_restaurant/modules/search/data/search_repository.dart';
import 'package:whats_on_restaurant/modules/search/interactor/search_interactor.dart';

class DependencyInjection {
  static final GetIt _getIt = GetIt.instance;

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
    _getIt.registerSingleton<NotificationHelper>(NotificationHelper());
    _getIt.registerSingleton<BackgroundService>(BackgroundService());
  }

  static void _registerDataSource() {
    var config = Configuration.local([
      RestaurantListObject.schema
    ]);

    var realm = Realm(config);
    
    _getIt.registerSingleton<RemoteDataSource>(RemoteDataSourceImpl());
    _getIt.registerSingleton<LocalDataSource>(
      LocalDataSourceImpl.withRealm(realm)
    );
  }

  static void _registerRepository() {
    _getIt.registerSingleton<HomeRepository>(
      HomeRepositoryImpl(
        remote: _getIt.get()
      )
    );

    _getIt.registerSingleton<RestaurantRepository>(
      RestaurantRepositoryImpl(
        remote: _getIt.get(),
        local: _getIt.get()
      )
    );

    _getIt.registerSingleton<ReviewRepository>(
      ReviewRepositoryImpl(
        remote: _getIt.get()
      )
    );

    _getIt.registerSingleton<SearchRepository>(
      SearchRepositoryImpl(
        remote: _getIt.get()
      )
    );
  }

  static void _registerInteractor() {
    _getIt.registerSingleton<HomeInteractor>(
      HomeInteractorImpl(
        repository: _getIt.get()
      )
    );

    _getIt.registerSingleton<RestaurantDetailInteractor>(
      RestaurantDetailInteractorImpl(
        repository: _getIt.get()
      )
    );

    _getIt.registerSingleton<ReviewInteractor>(
      ReviewInteractorImpl(
        repository: _getIt.get()
      )
    );

    _getIt.registerSingleton<SearchInteractor>(
      SearchInteractorImpl(
        repository: _getIt.get()
      )
    );
  }
}