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
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/screens/add_task_page.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:study_tracker/widgets/goal_view/task_list.dart';
import 'package:vrouter/vrouter.dart';

class GoalViewPage extends ConsumerStatefulWidget {
  static String path = '/goals/details/:goalId';
  static String pathNoParameters = '/goals/details/';

  @override
  _GoalViewPageState createState() => _GoalViewPageState();
}

class _GoalViewPageState extends ConsumerState<GoalViewPage> {
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
          goal?.name ?? Translations.of(context).goal_view_page.loading,
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
              _taskList(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _taskList() {
    if (goal != null) {
      return TaskList(goal: goal!);
    }
    return CircularProgressIndicator(
      color: AppTheme.secondaryColor,
    );
  }

  Widget _fab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.vRouter.to('${AddTaskPage.pathNoParameters}${goal!.id}');
      },
      label: Text(
        Translations.of(context).goal_view_page.add_task,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
