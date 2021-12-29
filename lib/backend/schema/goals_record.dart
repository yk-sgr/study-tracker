import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'goals_record.g.dart';

abstract class GoalsRecord implements Built<GoalsRecord, GoalsRecordBuilder> {
  static Serializer<GoalsRecord> get serializer => _$goalsRecordSerializer;

  @nullable
  String get name;

  @nullable
  DateTime get due;

  @nullable
  String get description;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  String get userId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(GoalsRecordBuilder builder) => builder
    ..name = ''
    ..description = ''
    ..userId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('goals');

  static Stream<GoalsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  static Future<GoalsRecord> getDocumentOnce(DocumentReference ref) => ref
      .get()
      .then((s) => serializers.deserializeWith(serializer, serializedData(s)));

  GoalsRecord._();
  factory GoalsRecord([void Function(GoalsRecordBuilder) updates]) =
      _$GoalsRecord;

  static GoalsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createGoalsRecordData({
  String name,
  DateTime due,
  String description,
  String userId,
}) =>
    serializers.toFirestore(
        GoalsRecord.serializer,
        GoalsRecord((g) => g
          ..name = name
          ..due = due
          ..description = description
          ..userId = userId));
