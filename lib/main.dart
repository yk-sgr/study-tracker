import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'auth/firebase_user_provider.dart';

import '../flutter_flow/flutter_flow_theme.dart';
import 'package:study_tracker/login_page/login_page_widget.dart';
import 'package:study_tracker/home_page/home_page_widget.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Stream<StudyTrackerFirebaseUser> userStream;
  StudyTrackerFirebaseUser initialUser;
  bool displaySplashImage = true;

  @override
  void initState() {
    super.initState();
    userStream = studyTrackerFirebaseUserStream()
      ..listen((user) => initialUser ?? setState(() => initialUser = user));
    Future.delayed(
        Duration(seconds: 1), () => setState(() => displaySplashImage = false));
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Study Tracker',
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en', '')],
      theme: ThemeData(primarySwatch: Colors.blue),
      home: initialUser == null || displaySplashImage
          ? Container(
              color: Colors.transparent,
              child: Center(
                child: Builder(
                  builder: (context) => Image.asset(
                    'assets/images/Logo_-_NoBg.svg',
                    width: MediaQuery.of(context).size.width * 0.75,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
            )
          : currentUser.loggedIn
              ? HomePageWidget()
              : LoginPageWidget(),
    );
  }
}
