import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_app/screens/register/register_screen.dart';
import 'package:flutter_app/widgets/gradient_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/login/login_form.dart';
import 'package:flutter_app/widgets/gradient_button.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../GoogleAuth.dart';
import '../../home_page.dart';

int user = 1;

class LoginForm  extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();

  }

  @override
  Widget build(BuildContext context){
    return Padding(
      key: _scaffoldKey,
      padding: const EdgeInsets.all(20.0),
      child: Form(
        child: Column(
          children: <Widget>[
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
            SizedBox(height: 20,
            ),
            GradientButton(
              width: 140,
              height: 45,
              onPressed: () async {
                _signInWithEmailAndPassword();
              },
              text: Text('Login', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.check,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),




            GradientButton(
              width: 140,
              height: 45,
              onPressed: () => googleSignIn().whenComplete(() {
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => HomePage()));
              }),
              text: Text('Google', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.alternate_email,
                  color: Colors.white
              ),
            ),
            SizedBox(
                height: 10
            ),



            GradientButton(
              width: 140,
              height: 45,
              onPressed: () {
                Navigator.push(context , MaterialPageRoute(builder: (_) {
                  return RegisterScreen();
                }
                ));
              },
              text: Text('Register', style: TextStyle(color: Colors.white),
              ),
              icon: Icon(
                  Icons.arrow_forward_ios,
                  color: Colors.white
              ),
            ),//Boton register
          ],
        ),
      ),
    );
  }


  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _signInWithEmailAndPassword() async {
    try {
      final User usuario = (await _auth.signInWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (!usuario.emailVerified) {
        await usuario.sendEmailVerification();
      }
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) {
        return HomePage();
      }));
    } on FirebaseAuthException catch (e) {
      Scaffold.of(context).showSnackBar(SnackBar(
        content: Text("Failed to sign in with Email & Password"),

      ));
    }
  }

  void _signOut() async {
    await _auth.signOut();
  }

  void _pushPage(BuildContext context, Widget page) {
    Navigator.of(context).push(
      MaterialPageRoute<void>(builder: (_) => page),
    );
  }




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

    setState(() {
      name = user.displayName;
      email = user.email;
      photoUrl = user.photoURL;
    });

    final User currentUser = _firebaseAuth.currentUser;
    assert(currentUser.uid == user.uid);

    return 'Logged In';
  }

}




