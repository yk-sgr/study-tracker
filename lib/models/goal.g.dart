// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'goal.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Goal _$GoalFromJson(Map json) => Goal(
      json['name'] as String,
      json['due'] as String,
      json['description'] as String,
      json['user_id'] as String,
      (json['tasks'] as List<dynamic>)
          .map((e) => Task.fromJson(Map<String, dynamic>.from(e as Map)))
          .toList(),
    );

Map<String, dynamic> _$GoalToJson(Goal instance) => <String, dynamic>{
      'name': instance.name,
      'due': instance.due,
      'description': instance.description,
      'user_id': instance.userId,
      'tasks': instance.tasks.map((e) => e.toJson()).toList(),
    };
