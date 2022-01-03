/*
 * Study Progress Tracker
 * Copyright (C) 2022 Yannick Seeger
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

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
