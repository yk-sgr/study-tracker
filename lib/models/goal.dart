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
