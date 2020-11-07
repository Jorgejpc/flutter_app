import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_app/home_page.dart';

import 'firebase_storage_user.dart';

String name, email, photoUrl;
User usuario;

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;


Future<String> googleSignIn() async {
  final GoogleSignInAccount googleSignInAccount =
  await _googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
  await googleSignInAccount.authentication;
  final AuthCredential authCredential = GoogleAuthProvider.credential(
      accessToken: googleSignInAuthentication.accessToken,
      idToken: googleSignInAuthentication.idToken);

  final UserCredential userCredential =
  await _firebaseAuth.signInWithCredential(authCredential);
  final User user = userCredential.user;
  usuario = user;
  assert(user.displayName != null);
  assert(user.email != null);
  assert(user.photoURL != null);

  final User currentUser = _firebaseAuth.currentUser;
  assert(currentUser.uid == user.uid);


  userSetup();

  return 'Logged In';
}