import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
final CollectionReference users = FirebaseFirestore.instance.collection('Users');
Future<void> userSetup() async {
  FirebaseAuth auth = FirebaseAuth.instance;
  String uid = auth.currentUser.uid.toString();
  String name = auth.currentUser.displayName.toString();
  String mail = auth.currentUser.email.toString();
  String phoneNumber = auth.currentUser.phoneNumber.toString();
  String photoURL = auth.currentUser.photoURL.toString();

  return users.add({
    'uid': uid,
    'name':name,
    'mail': mail,
    'phoneNumber': phoneNumber,
    'photoURL': photoURL,

  }).then((value) => print("User Added"))
      .catchError((error) => print("Failed to add user: $error"));
}