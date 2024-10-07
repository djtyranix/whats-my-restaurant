import 'package:realm/realm.dart';

abstract class LocalDataSource {
  
}

class LocalDataSourceImpl implements LocalDataSource {
  final Realm realm;

  LocalDataSourceImpl({
    required this.realm
  });

  factory LocalDataSourceImpl.withRealm(Realm realm) => LocalDataSourceImpl(realm: realm);
}