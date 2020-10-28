import 'package:flutter_app/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login/login_form.dart';
import 'package:flutter_app/widgets/gradient_button.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../firebase_storage_user.dart';
import '../../home_page.dart';

class RegisterForm  extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<RegisterForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _displaynameController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _isSuccess;

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return Padding(
      key: _formKey,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[

            TextFormField(
              controller:_displaynameController,
              decoration: InputDecoration(
                  icon: Icon(Icons.person_add_alt_1),
                  labelText: "Name"
              ),
              keyboardType: TextInputType.name,
              autovalidateMode: AutovalidateMode.always,
            ),

            TextFormField(
              controller:_emailController,
              decoration: InputDecoration(
                  icon: Icon(Icons.email),
                  labelText: "Email"
              ),
              keyboardType: TextInputType.emailAddress,
              autovalidateMode: AutovalidateMode.always,
            ),

            TextFormField(
              controller:_passwordController,
              decoration: InputDecoration(
                icon: Icon(Icons.lock),
                labelText: "Password",
              ),
              obscureText: true,
              autovalidateMode: AutovalidateMode.always,
            ),

            SizedBox(height: 10,
            ),
            GradientButton(
              width: 140,
              height: 45,
              onPressed: () async {
                _registerAccount();
              },
              text: Text('Register', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.check,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),
          ],
        ),
      ),
    );
  }

  void _registerAccount() async {
    final User user = (await _auth.createUserWithEmailAndPassword(
      email: _emailController.text,
      password: _passwordController.text,
    )).user;

    if (user != null) {
      if (!user.emailVerified) {
        await user.sendEmailVerification();
      }
      await user.updateProfile(displayName: _displaynameController.text);
      userSetup();
      final user1 = _auth.currentUser;
      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => HomePage(
          )));
    } else {
      _isSuccess = false;
    }
  }
}
