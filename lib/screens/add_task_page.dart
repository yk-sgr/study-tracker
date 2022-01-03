import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/models/task.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:study_tracker/widgets/loading_button.dart';
import 'package:study_tracker/widgets/text_input.dart';
import 'package:vrouter/vrouter.dart';

import 'goal_view_page.dart';
import 'home_page.dart';

class AddTaskPage extends ConsumerStatefulWidget {
  static String path = '/goals/add-topic/:goalId';
  static String pathNoParameters = '/goals/add-topic/';

  const AddTaskPage({required Key key}) : super(key: key);

  @override
  ConsumerState createState() => _AddTaskPageState();
}

class _AddTaskPageState extends ConsumerState<AddTaskPage> {
  Goal? goal;
  final _nameController = TextEditingController();

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
        title: Text(t.add_goal_page.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: goal == null
              ? CircularProgressIndicator(
                  color: AppTheme.secondaryColor,
                )
              : _form(context),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  Widget _form(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          TextInput(
              controller: _nameController,
              hintText: t.add_goal_page.input_name),
          Padding(
            padding: EdgeInsets.only(top: 40),
            child: LoadingButton(
              onPressed: () async {
                setState(() {
                  goal!.tasks.add(Task(_nameController.text, false));
                });
                await ref.read(goalServiceProvider).updateGoal(goal!);
                context.vRouter.to("${GoalViewPage.pathNoParameters}${goal!.id}");
              },
              width: MediaQuery.of(context).size.width,
              background: AppTheme.darkTextColor,
              height: 50,
              child: Text(t.add_goal_page.button_add_goal),
            ),
          )
        ],
      ),
    );
  }
}
