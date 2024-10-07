import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:whats_on_restaurant/data/source/remote_data_source.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:whats_on_restaurant/domain/models/response/restaurant_response.dart';
import 'package:whats_on_restaurant/modules/home/data/home_repository.dart';
import 'home_repository_test.mocks.dart';

@GenerateMocks([http.Client]) 
void main() {
  group('fetchRestaurantList', () {
    final remote = RemoteDataSourceImpl();
    final repository = HomeRepositoryImpl(remote: remote);

    test('return a List<RestaurantListResponse> when http call completed', () async {
      final client = MockClient();

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => http.Response('{"error":false,"message":"success","count":20,"restaurants":[{"id":"rqdv5juczeskfw1e867","name":"Melting Pot","description":"Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...","pictureId":"14","city":"Medan","rating":4.2},{"id":"s1knt6za9kkfw1e867","name":"Kafe Kita","description":"Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...","pictureId":"25","city":"Gorontalo","rating":4}]}', 200));

      expect(await repository.getRestaurants(client: client), isA<List<RestaurantListResponse>>());
    });

    test('throw exception if the http call completes with error', () {
      final client = MockClient();

      when(client.get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => http.Response('Not Found', 404));

      expect(repository.getRestaurants(client: client), throwsA(isA<Exception>()));
    });
  });
}