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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/models/goal.dart';
import 'package:study_tracker/provider/user_provider.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:vrouter/vrouter.dart';

final goalsProvider = StreamProvider.autoDispose<List<Goal>>((ref) {
  final user = ref.watch(userProvider).value;
  if (user == null) return Stream.empty();

  try {
    return FirebaseFirestore.instance
        .collection('goals')
        .where('user_id', isEqualTo: user.uid)
        .orderBy('due')
        .snapshots()
        .map((data) => data.docs.map((doc) {
              final g = Goal.fromJson(doc.data());
              g.id = doc.id;
              return g;
            }))
        .map((list) => list.toList());
  } catch (error, stacktrace) {
    debugPrint(error.toString());
    debugPrintStack(stackTrace: stacktrace);
    Fluttertoast.showToast(msg: t.home_page.error_loading_goals);
    return Stream.empty();
  }
});

final goalProvider = FutureProvider.family<Goal?, String>((ref, id) async {
  final user = ref.watch(userProvider).value;
  if (user == null) return null;
  final doc =
      await FirebaseFirestore.instance.collection('goals').doc(id).get();
  final data = doc.data();
  if (data == null) return null;
  Goal goal = Goal.fromJson(data);
  goal.id = doc.id;
  return goal;
});

final goalServiceProvider = Provider((ref) => GoalService(ref.read));

class GoalService {
  final Reader _read;

  GoalService(this._read);

  Future createGoal(BuildContext context, String name, String description,
      DateTime? due) async {
    if (name.isEmpty) {
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_name_empty);
      return null;
    }
    if (name.length > 64) {
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_name_too_long);
      return null;
    }
    if (description.length > 256) {
      Fluttertoast.showToast(
          msg: Translations.of(context)
              .add_goal_page
              .error_description_too_long);
      return null;
    }
    if (due == null) {
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_date_empty);
      return null;
    }

    final user = _read(userProvider).value;
    if (user == null) {
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_not_logged_in);
      return null;
    }

    try {
      await FirebaseFirestore.instance.collection('goals').add(
          Goal(name, due.toIso8601String(), description, user.uid, [])
              .toJson());
      context.vRouter.to(HomePage.path);
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_general);
    }
  }

  Future updateGoal(BuildContext context, Goal goal) async {
    final user = _read(userProvider).value;
    if (user == null) {
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_not_logged_in);
      return null;
    }
    try {
      await FirebaseFirestore.instance
          .collection('goals')
          .doc(goal.id)
          .update(goal.toJson());
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
      Fluttertoast.showToast(
          msg: Translations.of(context).add_goal_page.error_general);
    }
  }

  void deleteGoal(BuildContext context, String goalId) async {
    try {
      await FirebaseFirestore.instance.collection('goals').doc(goalId).delete();
      context.vRouter.to(HomePage.path);
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
      Fluttertoast.showToast(
          msg: Translations.of(context).goal_view_page.failed_deleting);
    }
  }
}
