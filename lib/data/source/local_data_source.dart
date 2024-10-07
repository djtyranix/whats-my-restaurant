import 'package:realm/realm.dart';

abstract class LocalDataSource {
  Future<RealmResults<T>> getAllData<T extends RealmObject>();
  Future<void> addData<T extends RealmObject>(T object);
  Future<void> deleteData<T extends RealmObject>(String id);
  Future<bool> isExist<T extends RealmObject>(String id);
}

class LocalDataSourceImpl implements LocalDataSource {
  final Realm realm;

  LocalDataSourceImpl({
    required this.realm
  });

  factory LocalDataSourceImpl.withRealm(Realm realm) => LocalDataSourceImpl(realm: realm);

  @override
  Future<RealmResults<T>> getAllData<T extends RealmObject>() async {
    try {
      return realm.all<T>();
    } catch(e) {
      throw Exception(e);
    }
  }

  @override
  Future<void> addData<T extends RealmObject>(T object) async {
    await realm.writeAsync(() {
      realm.add(object);
    });
  }

  @override
  Future<void> deleteData<T extends RealmObject>(String id) async {
    await realm.writeAsync(() {
      var data = realm.find<T>(id);
      
      if (data != null) {
        realm.delete(data);
      }
    });
  }

  @override
  Future<bool> isExist<T extends RealmObject>(String id) async {
    try {
      var data = realm.find<T>(id);
      return data != null;
    } catch(e) {
      throw Exception(e);
    }
  }
}