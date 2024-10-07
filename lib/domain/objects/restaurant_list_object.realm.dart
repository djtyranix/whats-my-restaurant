// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'restaurant_list_object.dart';

// **************************************************************************
// RealmObjectGenerator
// **************************************************************************

// ignore_for_file: type=lint
class RestaurantListObject extends _RestaurantListObject
    with RealmEntity, RealmObjectBase, RealmObject {
  RestaurantListObject(
    String id,
    String name,
    String city,
    num rating,
    String pictureId,
  ) {
    RealmObjectBase.set(this, 'id', id);
    RealmObjectBase.set(this, 'name', name);
    RealmObjectBase.set(this, 'city', city);
    RealmObjectBase.set(this, 'rating', rating);
    RealmObjectBase.set(this, 'pictureId', pictureId);
  }

  RestaurantListObject._();

  @override
  String get id => RealmObjectBase.get<String>(this, 'id') as String;
  @override
  set id(String value) => RealmObjectBase.set(this, 'id', value);

  @override
  String get name => RealmObjectBase.get<String>(this, 'name') as String;
  @override
  set name(String value) => RealmObjectBase.set(this, 'name', value);

  @override
  String get city => RealmObjectBase.get<String>(this, 'city') as String;
  @override
  set city(String value) => RealmObjectBase.set(this, 'city', value);

  @override
  num get rating => RealmObjectBase.get<num>(this, 'rating') as num;
  @override
  set rating(num value) => RealmObjectBase.set(this, 'rating', value);

  @override
  String get pictureId =>
      RealmObjectBase.get<String>(this, 'pictureId') as String;
  @override
  set pictureId(String value) => RealmObjectBase.set(this, 'pictureId', value);

  @override
  Stream<RealmObjectChanges<RestaurantListObject>> get changes =>
      RealmObjectBase.getChanges<RestaurantListObject>(this);

  @override
  Stream<RealmObjectChanges<RestaurantListObject>> changesFor(
          [List<String>? keyPaths]) =>
      RealmObjectBase.getChangesFor<RestaurantListObject>(this, keyPaths);

  @override
  RestaurantListObject freeze() =>
      RealmObjectBase.freezeObject<RestaurantListObject>(this);

  EJsonValue toEJson() {
    return <String, dynamic>{
      'id': id.toEJson(),
      'name': name.toEJson(),
      'city': city.toEJson(),
      'rating': rating.toEJson(),
      'pictureId': pictureId.toEJson(),
    };
  }

  static EJsonValue _toEJson(RestaurantListObject value) => value.toEJson();
  static RestaurantListObject _fromEJson(EJsonValue ejson) {
    if (ejson is! Map<String, dynamic>) return raiseInvalidEJson(ejson);
    return switch (ejson) {
      {
        'id': EJsonValue id,
        'name': EJsonValue name,
        'city': EJsonValue city,
        'rating': EJsonValue rating,
        'pictureId': EJsonValue pictureId,
      } =>
        RestaurantListObject(
          fromEJson(id),
          fromEJson(name),
          fromEJson(city),
          fromEJson(rating),
          fromEJson(pictureId),
        ),
      _ => raiseInvalidEJson(ejson),
    };
  }

  static final schema = () {
    RealmObjectBase.registerFactory(RestaurantListObject._);
    register(_toEJson, _fromEJson);
    return const SchemaObject(
        ObjectType.realmObject, RestaurantListObject, 'RestaurantListObject', [
      SchemaProperty('id', RealmPropertyType.string, primaryKey: true),
      SchemaProperty('name', RealmPropertyType.string),
      SchemaProperty('city', RealmPropertyType.string),
      SchemaProperty('rating', RealmPropertyType.double),
      SchemaProperty('pictureId', RealmPropertyType.string),
    ]);
  }();

  @override
  SchemaObject get objectSchema => RealmObjectBase.getSchema(this) ?? schema;
}
