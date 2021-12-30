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
  return FirebaseFirestore.instance
      .collection('goals')
      .where('user_id', isEqualTo: user.uid)
      .orderBy('due')
      .snapshots()
      .map((data) => data.docs.map((doc) => Goal.fromJson(doc.data())))
      .map((list) => list.toList());
});

final goalsServiceProvider = Provider((ref) => GoalService(ref.read));

class GoalService {
  final Reader _read;

  GoalService(this._read);

  void createGoal(BuildContext context, String name, String description,
      DateTime? due) async {
    if (name.isEmpty) {
      Fluttertoast.showToast(msg: t.add_goal_page.name_empty);
      return null;
    }
    if (description.isEmpty) {
      Fluttertoast.showToast(msg: t.add_goal_page.description_empty);
      return null;
    }
    if (due == null) {
      Fluttertoast.showToast(msg: t.add_goal_page.date_empty);
      return null;
    }

    final user = _read(userProvider).value;
    if (user == null) {
      Fluttertoast.showToast(msg: t.add_goal_page.not_logged_in);
      return null;
    }

    try {
      await FirebaseFirestore.instance.collection('goals').add(
          Goal(name, due.toIso8601String(), description, user.uid).toJson());
      context.vRouter.to(HomePage.path);
    } catch (error) {
      Fluttertoast.showToast(msg: t.add_goal_page.error);
    }
  }
}
