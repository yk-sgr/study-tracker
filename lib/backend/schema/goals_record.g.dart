// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goals_record.dart';

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<GoalsRecord> _$goalsRecordSerializer = new _$GoalsRecordSerializer();

class _$GoalsRecordSerializer implements StructuredSerializer<GoalsRecord> {
  @override
  final Iterable<Type> types = const [GoalsRecord, _$GoalsRecord];
  @override
  final String wireName = 'GoalsRecord';

  @override
  Iterable<Object> serialize(Serializers serializers, GoalsRecord object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object>[];
    Object value;
    value = object.name;
    if (value != null) {
      result
        ..add('name')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.due;
    if (value != null) {
      result
        ..add('due')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(DateTime)));
    }
    value = object.description;
    if (value != null) {
      result
        ..add('description')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    value = object.userId;
    if (value != null) {
      result
        ..add('user_id')
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
  GoalsRecord deserialize(Serializers serializers, Iterable<Object> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new GoalsRecordBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object value = iterator.current;
      switch (key) {
        case 'name':
          result.name = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'due':
          result.due = serializers.deserialize(value,
              specifiedType: const FullType(DateTime)) as DateTime;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'user_id':
          result.userId = serializers.deserialize(value,
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

class _$GoalsRecord extends GoalsRecord {
  @override
  final String name;
  @override
  final DateTime due;
  @override
  final String description;
  @override
  final String userId;
  @override
  final DocumentReference<Object> reference;

  factory _$GoalsRecord([void Function(GoalsRecordBuilder) updates]) =>
      (new GoalsRecordBuilder()..update(updates)).build();

  _$GoalsRecord._(
      {this.name, this.due, this.description, this.userId, this.reference})
      : super._();

  @override
  GoalsRecord rebuild(void Function(GoalsRecordBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  GoalsRecordBuilder toBuilder() => new GoalsRecordBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is GoalsRecord &&
        name == other.name &&
        due == other.due &&
        description == other.description &&
        userId == other.userId &&
        reference == other.reference;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc($jc($jc($jc(0, name.hashCode), due.hashCode), description.hashCode),
            userId.hashCode),
        reference.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('GoalsRecord')
          ..add('name', name)
          ..add('due', due)
          ..add('description', description)
          ..add('userId', userId)
          ..add('reference', reference))
        .toString();
  }
}

class GoalsRecordBuilder implements Builder<GoalsRecord, GoalsRecordBuilder> {
  _$GoalsRecord _$v;

  String _name;
  String get name => _$this._name;
  set name(String name) => _$this._name = name;

  DateTime _due;
  DateTime get due => _$this._due;
  set due(DateTime due) => _$this._due = due;

  String _description;
  String get description => _$this._description;
  set description(String description) => _$this._description = description;

  String _userId;
  String get userId => _$this._userId;
  set userId(String userId) => _$this._userId = userId;

  DocumentReference<Object> _reference;
  DocumentReference<Object> get reference => _$this._reference;
  set reference(DocumentReference<Object> reference) =>
      _$this._reference = reference;

  GoalsRecordBuilder() {
    GoalsRecord._initializeBuilder(this);
  }

  GoalsRecordBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _name = $v.name;
      _due = $v.due;
      _description = $v.description;
      _userId = $v.userId;
      _reference = $v.reference;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(GoalsRecord other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$GoalsRecord;
  }

  @override
  void update(void Function(GoalsRecordBuilder) updates) {
    if (updates != null) updates(this);
  }

  @override
  _$GoalsRecord build() {
    final _$result = _$v ??
        new _$GoalsRecord._(
            name: name,
            due: due,
            description: description,
            userId: userId,
            reference: reference);
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
