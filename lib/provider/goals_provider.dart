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

  void createGoal(BuildContext context, String name, String description,
      DateTime? due) async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: t.add_goal_page.error_name_empty);
      return null;
    }
    if (description.isEmpty) {
      Fluttertoast.showToast(msg: t.add_goal_page.error_description_empty);
      return null;
    }
    if (due == null) {
      Fluttertoast.showToast(msg: t.add_goal_page.error_date_empty);
      return null;
    }

    final user = _read(userProvider).value;
    if (user == null) {
      Fluttertoast.showToast(msg: t.add_goal_page.error_not_logged_in);
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
      Fluttertoast.showToast(msg: t.add_goal_page.error_general);
    }
  }

  Future updateGoal(Goal goal) async {
    final user = _read(userProvider).value;
    if (user == null) {
      Fluttertoast.showToast(msg: t.add_goal_page.error_not_logged_in);
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
      Fluttertoast.showToast(msg: t.add_goal_page.error_general);
    }
  }

  void deleteGoal(BuildContext context, String goalId) async {
    try {
      await FirebaseFirestore.instance.collection('goals').doc(goalId).delete();
      context.vRouter.to(HomePage.path);
    } catch (error, stacktrace) {
      debugPrint(error.toString());
      debugPrintStack(stackTrace: stacktrace);
      Fluttertoast.showToast(msg: t.goal_view_page.failed_deleting);
    }
  }
}
