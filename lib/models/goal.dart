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

import 'package:json_annotation/json_annotation.dart';
import 'package:study_tracker/models/task.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal {
  final String name;
  final String due;
  final String description;
  @JsonKey(name: 'user_id')
  final String userId;
  List<Task> tasks;
  @JsonKey(ignore: true)
  String? id;

  Goal(this.name, this.due, this.description, this.userId, this.tasks,
      {this.id});

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);

  List<Task> sortedTasks() {
    tasks.sort((a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()));
    return tasks;
  }
}
