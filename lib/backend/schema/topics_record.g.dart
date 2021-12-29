// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topics_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<TopicsRecord> _$topicsRecordSerializer =
    new _$TopicsRecordSerializer();

class _$TopicsRecordSerializer implements StructuredSerializer<TopicsRecord> {
  @override
  final Iterable<Type> types = const [TopicsRecord, _$TopicsRecord];
  @override
  final String wireName = 'TopicsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, TopicsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.done;
    if (value != null) {
      result
        ..add('done')
        ..add(
            serializers.serialize(value, specifiedType: const FullType(bool)));
    }
    value = object.goalId;
    if (value != null) {
      result
        ..add('goal_id')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.reference;
    if (value != null) {
      result
        ..add('Document__Reference__Field')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(
                DocumentReference, const [const FullType(Object)])));
    }
    return result;
  }

  @override
  TopicsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new TopicsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'user_id':
          result.userId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'done':
          result.done = serializers.deserialize(value,
              specifiedType: const FullType(bool)) as bool;
          break;
        case 'goal_id':
          result.goalId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'Document__Reference__Field':
          result.reference = serializers.deserialize(value,
                  specifiedType: const FullType(
                      DocumentReference, const [const FullType(Object)]))
              as DocumentReference<Object>;
          break;
      }
    }

    return result.build();
  }
}

class _$TopicsRecord extends TopicsRecord {
  @override
  final String userId;
  @override
  final String name;
  @override
  final bool done;
  @override
  final String goalId;
  @override
  final DocumentReference<Object> reference;

  factory _$TopicsRecord([void Function(TopicsRecordBuilder) updates]) =>
      (new TopicsRecordBuilder()..update(updates)).build();

  _$TopicsRecord._(
      {this.userId, this.name, this.done, this.goalId, this.reference})
      : super._();

  @override
  TopicsRecord rebuild(void Function(TopicsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  TopicsRecordBuilder toBuilder() => new TopicsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is TopicsRecord &&
        userId == other.userId &&
        name == other.name &&
        done == other.done &&
        goalId == other.goalId &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, userId.hashCode), name.hashCode), done.hashCode),
            goalId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('TopicsRecord')
          ..add('userId', userId)
          ..add('name', name)
          ..add('done', done)
          ..add('goalId', goalId)
          ..add('reference', reference))
        .toString();
  }
}

class TopicsRecordBuilder
    implements Builder<TopicsRecord, TopicsRecordBuilder> {
  _$TopicsRecord _$v;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  bool _done;
  bool get done => _$this._done;
  set done(bool done) => _$this._done = done;

  String _goalId;
  String get goalId => _$this._goalId;
  set goalId(String goalId) => _$this._goalId = goalId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  TopicsRecordBuilder() {
    TopicsRecord._initializeBuilder(this);
  }

  TopicsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _userId = $v.userId;
      _name = $v.name;
      _done = $v.done;
      _goalId = $v.goalId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(TopicsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$TopicsRecord;
  }

  @override
  void update(void Function(TopicsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$TopicsRecord build() {
    final _$result = _$v ??
        new _$TopicsRecord._(
            userId: userId,
            name: name,
            done: done,
            goalId: goalId,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
