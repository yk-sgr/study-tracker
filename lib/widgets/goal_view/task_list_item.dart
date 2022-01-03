import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_tracker/models/task.dart';
import 'package:study_tracker/theme/app_theme.dart';

class TaskListItem extends StatelessWidget {
  final Task task;

  final Function(Task task) onTaskUpdate;
  final Function(Task task) onTaskDelete;

  TaskListItem(
      {required this.task,
      required this.onTaskUpdate,
      required this.onTaskDelete});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        primary: AppTheme.primaryColor,
        splashFactory: InkRipple.splashFactory,
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      ),
      onPressed: () {},
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                task.done ? _taskDoneButton() : _taskNotDoneButton(),
                _taskName(context),
              ],
            ),
            _deleteTaskButton()
          ],
        ),
      ),
    );
  }

  Widget _taskName(BuildContext context) {
    return Text(
      task.name,
      style: Theme.of(context)
          .textTheme
          .bodyText1
          ?.copyWith(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _taskDoneButton() {
    return IconButton(
      onPressed: () {
        task.done = false;
        onTaskUpdate(task);
      },
      icon: Icon(
        Icons.check_box,
        color: AppTheme.darkTextColor,
      ),
    );
  }

  Widget _taskNotDoneButton() {
    return IconButton(
      onPressed: () {
        task.done = true;
        onTaskUpdate(task);
      },
      icon: Icon(
        Icons.check_box_outline_blank_outlined,
        color: AppTheme.darkTextColor,
      ),
    );
  }

  Widget _deleteTaskButton() {
    return IconButton(
      iconSize: 20,
      onPressed: () => onTaskDelete(task),
      icon: FaIcon(
        FontAwesomeIcons.trash,
        color: AppTheme.lightActionColor,
      ),
    );
  }
}
