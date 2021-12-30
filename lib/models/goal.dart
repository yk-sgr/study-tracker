import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'goal.g.dart';

@JsonSerializable()
class Goal extends Equatable {
  final String name;
  final String due;
  final String description;
  @JsonKey(name: 'user_id')
  final String userId;

  Goal(this.name, this.due, this.description, this.userId);

  factory Goal.fromJson(Map<String, dynamic> json) => _$GoalFromJson(json);

  Map<String, dynamic> toJson() => _$GoalToJson(this);

  @override
  List<Object> get props => [name, due, description, userId];
}
