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

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:firebase_performance/firebase_performance.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/screens/add_goal_page.dart';
import 'package:study_tracker/screens/add_task_page.dart';
import 'package:study_tracker/screens/goal_view_page.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:study_tracker/screens/login_page.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:vrouter/vrouter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  await Firebase.initializeApp();
  await FirebaseAppCheck.instance.activate();
  FirebaseAppCheck.instance.setTokenAutoRefreshEnabled(true);
  FirebaseAnalytics.instance.logAppOpen();

  if (kDebugMode) {
    await FirebaseAnalytics.instance.setAnalyticsCollectionEnabled(false);
    await FirebaseCrashlytics.instance.setCrashlyticsCollectionEnabled(false);
    await FirebasePerformance.instance.setPerformanceCollectionEnabled(false);
  }

  runApp(
    TranslationProvider(child: ProviderScope(child: App())),
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return VRouter(
      logs: [],
      locale: TranslationProvider.of(context).flutterLocale,
      supportedLocales: LocaleSettings.supportedLocales,
      localizationsDelegates: GlobalMaterialLocalizations.delegates,
      theme: AppTheme.lightTheme,
      beforeEnter: (vRedirector) async {
        // Check Auth
        if (vRedirector.toUrl == LoginPage.path) return;
        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          vRedirector.to(LoginPage.path);
        }

        FirebaseAnalytics.instance
            .setCurrentScreen(screenName: vRedirector.toUrl);
      },
      routes: [
        VWidget(path: LoginPage.path, widget: LoginPage()),
        VWidget(path: HomePage.path, widget: HomePage(), stackedRoutes: [
          VWidget(path: GoalViewPage.path, widget: GoalViewPage()),
          VWidget(
              path: AddGoalPage.path,
              widget: AddGoalPage(
                key: Key('add_goal_page'),
              ),
              stackedRoutes: [
                VWidget(
                  path: AddTaskPage.path,
                  widget: AddTaskPage(
                    key: Key('add_task_page'),
                  ),
                ),
              ]),
        ]),
      ],
    );
  }
}
