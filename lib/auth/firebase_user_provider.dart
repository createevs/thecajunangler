import 'package:firebase_auth/firebase_auth.dart';
import 'package:rxdart/rxdart.dart';

class TheCajunAnglerFirebaseUser {
  TheCajunAnglerFirebaseUser(this.user);
  User user;
  bool get loggedIn => user != null;
}

TheCajunAnglerFirebaseUser currentUser;
bool get loggedIn => currentUser?.loggedIn ?? false;
Stream<TheCajunAnglerFirebaseUser> theCajunAnglerFirebaseUserStream() =>
    FirebaseAuth.instance
        .authStateChanges()
        .debounce((user) => user == null && !loggedIn
            ? TimerStream(true, const Duration(seconds: 1))
            : Stream.value(user))
        .map<TheCajunAnglerFirebaseUser>(
            (user) => currentUser = TheCajunAnglerFirebaseUser(user));
