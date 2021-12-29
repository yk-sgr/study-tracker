import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:study_tracker/screens/login_page.dart';
import 'package:vrouter/vrouter.dart';

class HomePage extends StatelessWidget {
  static String path = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ElevatedButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            context.vRouter.to(LoginPage.path);
          },
          child: Text('Sign Out'),
        ),
      ),
    );
  }
}
