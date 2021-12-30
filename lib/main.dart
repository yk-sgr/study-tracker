import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/screens/add_goal_page.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:study_tracker/screens/login_page.dart';
import 'package:study_tracker/theme/app_theme.dart';
import 'package:vrouter/vrouter.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocaleSettings.useDeviceLocale();
  await Firebase.initializeApp();

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
        if (vRedirector.toUrl == LoginPage.path) return;

        final user = FirebaseAuth.instance.currentUser;
        if (user == null) {
          vRedirector.to(LoginPage.path);
        }
      },
      routes: [
        VWidget(path: LoginPage.path, widget: LoginPage()),
        VWidget(path: HomePage.path, widget: HomePage(), stackedRoutes: [
          VWidget(path: AddGoalPage.path, widget: AddGoalPage(key: Key('add_goal_page'),))
        ]),
      ],
    );
  }
}
