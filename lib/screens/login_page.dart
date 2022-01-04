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

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/provider/user_provider.dart';
import 'package:study_tracker/widgets/loading_button.dart';

class LoginPage extends ConsumerWidget {
  static String path = '/auth/login';

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Spacer(),
              SvgPicture.asset(
                'assets/images/login_page_illustration.svg',
                width: MediaQuery.of(context).size.width * 0.8,
                fit: BoxFit.cover,
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
                child: Text(
                  t.appName,
                  style: Theme.of(context).textTheme.headline1,
                ),
              ),
              Spacer(
                flex: 2,
              ),
              _googleSignInButton(context, ref),
              _anonymousSignInButton(context, ref),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _anonymousSignInButton(BuildContext context, WidgetRef ref) {
    return TextButton(
      onPressed: () async {
        ref.read(userServiceProvider).signInAnonymous(context);
      },
      child: Text(
        Translations.of(context).login_page.anonymous_button,
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget _googleSignInButton(BuildContext context, WidgetRef ref) {
    return LoadingButton(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      background: Colors.white,
      onPressed: () async {
        ref.read(userServiceProvider).signInWithGoogle(context);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.asset(
                  'assets/images/google-logo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  Translations.of(context).login_page.google_button,
                  style: Theme.of(context).textTheme.subtitle2,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
