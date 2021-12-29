import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class StudyTrackerFirebaseUser {
  StudyTrackerFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

StudyTrackerFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<StudyTrackerFirebaseUser> studyTrackerFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<StudyTrackerFirebaseUser>(
            (user) => currentUser = StudyTrackerFirebaseUser(user));
