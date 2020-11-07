import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login/login_screen.dart';

class NavbarHome extends StatefulWidget {

  const NavbarHome({Key key}) : super(key: key);
  @override
  _NavbarHomeState createState() => _NavbarHomeState();
}

class _NavbarHomeState extends State<NavbarHome> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  FirebaseAuth _auth = FirebaseAuth.instance;
  final User user = FirebaseAuth.instance.currentUser;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              child: Text(user.email.toString(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
              ),
            ),
            Container(
              child: OutlineButton(
                child: Text("LogOut"),
                onPressed: () {
                  _signOut().whenComplete(() {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginScreen()));
                  });
                },
              ),
            ),
          ],
        ),
      ),
    );

  }

  Future _signOut() async {
    await _auth.signOut();
  }

}


