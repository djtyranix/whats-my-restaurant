import 'package:get_it/get_it.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';
import 'package:whats_on_restaurant/modules/home/interactor/home_interactor.dart';
import 'package:whats_on_restaurant/modules/restaurant/data/restaurant_repository.dart';
import 'package:whats_on_restaurant/modules/restaurant/interactor/restaurant_detail_interactor.dart';

class DependencyInjection {
  static GetIt getIt = GetIt.instance;

  static void configure() {
    _registerRepository();
    _registerInteractor();
  }

  static void _registerRepository() {
    getIt.registerSingleton<HomeRepository>(HomeRepositoryImpl());
    getIt.registerSingleton<RestaurantRepository>(RestaurantRepositoryImpl());
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
  }
}