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
        title: Text(Translations.of(context).add_goal_page.title),
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 40, left: 20, right: 20),
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            children: [
              TextInput(
                  controller: _nameController,
                  hintText: Translations.of(context).add_goal_page.input_name),
              Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextInput(
                    controller: _descriptionController,
                    hintText: Translations.of(context).add_goal_page.input_description),
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
                        Translations.of(context).add_goal_page.input_select_date,
                        style: Theme.of(context).textTheme.bodyText1?.copyWith(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
                    Text(
                      _due == null
                          ? Translations.of(context).add_goal_page.select_date_no_date_selected
                          : Jiffy(_due).format(Translations.of(context).dateformat),
                      style: Theme.of(context).textTheme.bodyText1,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
                child: LoadingButton(
                  onPressed: () async {
                    await ref.read(goalServiceProvider).createGoal(
                        context,
                        _nameController.text,
                        _descriptionController.text,
                        _due);
                  },
                  width: MediaQuery.of(context).size.width,
                  background: AppTheme.darkTextColor,
                  height: 50,
                  child: Text(Translations.of(context).add_goal_page.button_add_goal),
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
