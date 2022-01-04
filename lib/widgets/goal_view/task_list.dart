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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/models/task.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/widgets/goal_view/task_list_item.dart';

class TaskList extends ConsumerStatefulWidget {
  final Goal goal;

  TaskList({required this.goal});

  @override
  ConsumerState createState() => _TaskListState();
}

class _TaskListState extends ConsumerState<TaskList> {
  late Goal goal;

  @override
  void initState() {
    goal = widget.goal;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final tasks = goal.sortedTasks();
    if (tasks.isEmpty) {
      return Text(Translations.of(context).goal_view_page.no_tasks_found,
          style: Theme.of(context).textTheme.bodyText1);
    }
    return Expanded(
      child: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          final task = tasks[index];
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: TaskListItem(
                task: task,
                onTaskUpdate: _onTaskUpdate,
                onTaskDelete: _onTaskDelete,
              ),
            ),
          );
        },
      ),
    );
  }

  void _onTaskUpdate(Task task) async {
    setState(() {
      goal.tasks.removeWhere((element) => element.name == task.name);
      goal.tasks.add(task);
    });
    await ref.read(goalServiceProvider).updateGoal(context, goal);
  }

  void _onTaskDelete(Task task) async {
    setState(() {
      goal.tasks.removeWhere((element) => element.name == task.name);
    });
    await ref.read(goalServiceProvider).updateGoal(context, goal);
  }
}
