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
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:vrouter/vrouter.dart';

final userProvider =
    StreamProvider<User?>((_) => FirebaseAuth.instance.authStateChanges());

final userServiceProvider = Provider((ref) => UserService(ref.read));

class UserService {
  final Reader _read;

  UserService(this._read);

  void signInWithGoogle(BuildContext context) async {
    try {
      final googleUser = await GoogleSignIn().signIn();
      final googleAuth = await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      await FirebaseAuth.instance.signInWithCredential(credential);
      FirebaseAnalytics.instance.logLogin(loginMethod: 'google');
      _userAnalytics();
      context.vRouter.to(HomePage.path);
    } catch (error) {
      Fluttertoast.showToast(msg: t.login_page.error);
    }
  }

  void signInAnonymous(BuildContext context) async {
    await FirebaseAuth.instance.signInAnonymously();
    FirebaseAnalytics.instance.logLogin(loginMethod: 'anonymous');
    _userAnalytics();
    context.vRouter.to(HomePage.path);
  }

  void _userAnalytics() {
    FirebaseAnalytics.instance
        .setUserId(id: FirebaseAuth.instance.currentUser?.uid);
  }
}
