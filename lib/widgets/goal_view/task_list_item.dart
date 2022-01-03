import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_tracker/models/task.dart';
import 'package:study_tracker/theme/app_theme.dart';

class TaskListItem extends StatefulWidget {
  final Task task;

  final Function(Task task) onTaskUpdate;
  final Function(Task task) onTaskDelete;

  TaskListItem(
      {required this.task,
      required this.onTaskUpdate,
      required this.onTaskDelete});

  @override
  State createState() => _TaskListItemState();
}

class _TaskListItemState extends State<TaskListItem> {
  late Task task;

  @override
  void initState() {
    task = widget.task;

    super.initState();
  }

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
                _taskName(),
              ],
            ),
            _deleteTaskButton()
          ],
        ),
      ),
    );
  }

  Widget _taskName() {
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
        setState(() {
          task.done = false;
        });
        widget.onTaskUpdate(task);
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
        setState(() {
          task.done = true;
        });
        widget.onTaskUpdate(task);
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
      onPressed: () => widget.onTaskDelete(task),
      icon: FaIcon(
        FontAwesomeIcons.trash,
        color: AppTheme.lightActionColor,
      ),
    );
  }
}
