import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:study_tracker/widgets/loading_button.dart';
import 'package:study_tracker/widgets/text_input.dart';

class AddGoalPage extends ConsumerStatefulWidget {
  static String path = '/goals/add';

  const AddGoalPage({required Key key}) : super(key: key);

  @override
  ConsumerState createState() => _AddGoalPageState();
}

class _AddGoalPageState extends ConsumerState<AddGoalPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime? _due;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.add_goal_page.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextInput(
                  controller: _nameController, hintText: t.add_goal_page.name),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextInput(
                    controller: _descriptionController,
                    hintText: t.add_goal_page.description),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    TextButton(
                      onPressed: () {
                        DatePicker.showDatePicker(
                          context,
                          showTitleActions: true,
                          onConfirm: (date) {
                            setState(() {
                              _due = date;
                            });
                          },
                        );
                      },
                      child: Text(
                        t.add_goal_page.select_date,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Text(
                      _due == null
                          ? t.add_goal_page.no_date
                          : Jiffy(_due).format(t.dateformat),
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: LoadingButton(
                  onPressed: () {
                    ref.read(goalsServiceProvider).createGoal(
                        context,
                        _nameController.text,
                        _descriptionController.text,
                        _due);
                  },
                  width: MediaQuery.of(context).size.width,
                  background: AppTheme.darkTextColor,
                  height: 50,
                  child: Text(t.add_goal_page.add_goal),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }
}
