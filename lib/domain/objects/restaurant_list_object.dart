import 'package:realm/realm.dart';
part 'restaurant_list_object.realm.dart';

@RealmModel()
class _RestaurantListObject {
  @PrimaryKey()
  late String id;
  
  late String name;
  late String city;
  late num rating;
  late String pictureId;
}