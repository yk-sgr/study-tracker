import 'package:flutter/material.dart';
import 'package:study_tracker/i18n/strings.g.dart';

class AddGoalPage extends StatefulWidget {
  static String path = '/goals/add';

  @override
  State createState() => _AddGoalPageState();
}

class _AddGoalPageState extends State<AddGoalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(t.add_goal_page.title),
      ),
    );
  }
}
