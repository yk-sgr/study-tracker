import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:study_tracker/i18n/strings.g.dart';
import 'package:study_tracker/screens/home_page.dart';
import 'package:study_tracker/widgets/loading_button.dart';
import 'package:vrouter/vrouter.dart';

class LoginPage extends StatelessWidget {
  static String path = '/auth/login';

  @override
  Widget build(BuildContext context) {
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
              _googleSignInButton(context),
              _anonymousSignInButton(context),
              Spacer(
                flex: 2,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _anonymousSignInButton(BuildContext context) {
    return TextButton(
      onPressed: () async {
        //TODO: Extract to provider
        await FirebaseAuth.instance.signInAnonymously();
        context.vRouter.to(HomePage.path);
      },
      child: Text(
        'Continue without account',
        style: Theme.of(context).textTheme.subtitle2,
      ),
    );
  }

  Widget _googleSignInButton(BuildContext context) {
    return LoadingButton(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 50,
      background: Colors.white,
      onPressed: () async {
        //TODO: Extract to provider
        final googleUser = await GoogleSignIn().signIn();
        final googleAuth = await googleUser?.authentication;

        final credential = GoogleAuthProvider.credential(
            accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

        await FirebaseAuth.instance.signInWithCredential(credential);
        context.vRouter.to(HomePage.path);
      },
      child: Padding(
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Stack(
          children: [
            Positioned.fill(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Image.network(
                  'https://i0.wp.com/nanophorm.com/wp-content/uploads/2018/04/google-logo-icon-PNG-Transparent-Background.png?w=1000&ssl=1',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Sign in with Google',
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
