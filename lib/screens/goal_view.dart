import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/models/task.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/screens/add_task_page.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:vrouter/vrouter.dart';

class GoalViewPage extends ConsumerStatefulWidget {
  static String path = '/goals/details/:goalId';
  static String pathNoParameters = '/goals/details/';

  @override
  ConsumerState createState() => _GoalViewPageState();
}

class _GoalViewPageState extends ConsumerState {
  Goal? goal;

  @override
  Widget build(BuildContext context) {
    final goalId = context.vRouter.pathParameters['goalId'];
    if (goalId == null || goalId.isEmpty) {
      context.vRouter.to(HomePage.path);
      return Container();
    }
    final goal = ref.watch(goalProvider(goalId)).value;
    if (goal != null) {
      setState(() {
        this.goal = goal;
      });
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          goal?.name ?? t.goal_view_page.loading,
        ),
        actions: [
          IconButton(
            onPressed: () {
              ref.read(goalServiceProvider).deleteGoal(context, goalId);
            },
            icon: FaIcon(
              FontAwesomeIcons.trash,
              color: AppTheme.lightActionColor,
            ),
          )
        ],
      ),
      floatingActionButton: goal != null ? _fab(context) : null,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _topicsList(context, ref, goalId),
            ],
          ),
        ),
      ),
    );
  }

  Widget _fab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.vRouter.to('${AddTaskPage.pathNoParameters}${goal!.id}');
      },
      label: Text(
        t.home_page.fab,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }

  Widget _topicsList(BuildContext context, WidgetRef ref, String goalId) {
    if (goal == null) {
      return SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          color: AppTheme.secondaryColor,
        ),
      );
    }
    final tasks = goal?.sortedTasks() ?? [];
    if (tasks.isEmpty) {
      return Text(t.goal_view_page.no_topics_found,
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
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: AppTheme.primaryColor,
                  splashFactory: InkRipple.splashFactory,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onPressed: () {},
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          _taskDoneButton(task),
                          Text(
                            task.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      IconButton(
                        iconSize: 20,
                        onPressed: () => _deleteTask(task),
                        icon: FaIcon(
                          FontAwesomeIcons.trash,
                          color: AppTheme.lightActionColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _taskDoneButton(Task task) {
    if (task.done) {
      return IconButton(
        onPressed: () => _toggleDone(task),
        icon: Icon(
          Icons.check_box,
          color: AppTheme.darkTextColor,
        ),
      );
    }
    return IconButton(
      onPressed: () => _toggleDone(task),
      icon: Icon(
        Icons.check_box_outline_blank_outlined,
        color: AppTheme.darkTextColor,
      ),
    );
  }

  void _toggleDone(Task task) async {
    task.done = !task.done;
    setState(() {
      goal!.tasks.removeWhere((element) => element.name == task.name);
      goal!.tasks.add(task);
    });
    await ref.read(goalServiceProvider).updateGoal(goal!);
  }

  void _deleteTask(Task task) async {
    setState(() {
      goal!.tasks.removeWhere((element) => element.name == task.name);
    });
    await ref.read(goalServiceProvider).updateGoal(goal!);
  }
}
