import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/provider/goals_provider.dart';
import 'package:study_tracker/screens/add_goal_page.dart';
import 'package:study_tracker/screens/goal_view.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:vrouter/vrouter.dart';

class HomePage extends ConsumerWidget {
  static String path = '/';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(t.appNameShort),
        ),
        floatingActionButton: _fab(context),
        body: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _goalList(context, ref),
              ],
            ),
          ),
        ));
  }

  Widget _goalList(BuildContext context, WidgetRef ref) {
    final goals = ref.watch(goalsProvider).value;
    if (goals == null) {
      return SizedBox(
        width: 35,
        height: 35,
        child: CircularProgressIndicator(
          color: AppTheme.secondaryColor,
        ),
      );
    }
    if (goals.isEmpty) {
      return Text(t.home_page.no_goals,
          style: Theme.of(context).textTheme.bodyText1);
    }
    return Expanded(
      child: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
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
                onPressed: () {
                  context.vRouter
                      .to("${GoalViewPage.pathNoParameters}${goal.id}");
                },
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            goal.name,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                          ),
                          Text(
                            Jiffy(DateTime.parse(goal.due))
                                .format(t.dateformat),
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1
                                ?.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Text(
                          goal.description,
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      )
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

  Widget _fab(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        context.vRouter.to(AddGoalPage.path);
      },
      label: Text(
        t.home_page.fab,
        style: Theme.of(context).textTheme.bodyText1,
      ),
    );
  }
}
