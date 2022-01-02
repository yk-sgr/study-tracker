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
        t.login_page.anonymous_button,
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
                  t.login_page.google_button,
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
