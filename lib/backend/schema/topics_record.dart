import 'dart:async';

import 'index.dart';
import 'serializers.dart';
import 'package:built_value/built_value.dart';

part 'topics_record.g.dart';

abstract class TopicsRecord
    implements Built<TopicsRecord, TopicsRecordBuilder> {
  static Serializer<TopicsRecord> get serializer => _$topicsRecordSerializer;

  @nullable
  @BuiltValueField(wireName: 'user_id')
  String get userId;

  @nullable
  String get name;

  @nullable
  bool get done;

  @nullable
  @BuiltValueField(wireName: 'goal_id')
  String get goalId;

  @nullable
  @BuiltValueField(wireName: kDocumentReferenceField)
  DocumentReference get reference;

  static void _initializeBuilder(TopicsRecordBuilder builder) => builder
    ..userId = ''
    ..name = ''
    ..done = false
    ..goalId = '';

  static CollectionReference get collection =>
      FirebaseFirestore.instance.collection('topics');

  static Stream<TopicsRecord> getDocument(DocumentReference ref) => ref
      .snapshots()
      .map((s) => serializers.deserializeWith(serializer, serializedData(s)));

  TopicsRecord._();
  factory TopicsRecord([void Function(TopicsRecordBuilder) updates]) =
      _$TopicsRecord;

  static TopicsRecord getDocumentFromData(
          Map<String, dynamic> data, DocumentReference reference) =>
      serializers.deserializeWith(serializer,
          {...mapFromFirestore(data), kDocumentReferenceField: reference});
}

Map<String, dynamic> createTopicsRecordData({
  String userId,
  String name,
  bool done,
  String goalId,
}) =>
    serializers.toFirestore(
        TopicsRecord.serializer,
        TopicsRecord((t) => t
          ..userId = userId
          ..name = name
          ..done = done
          ..goalId = goalId));
