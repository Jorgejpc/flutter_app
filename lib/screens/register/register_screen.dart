import 'package:flutter_app/screens/register/register_form.dart';
import 'package:flutter_app/widgets/curved_widget.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: IconThemeData(color: Color(0xff6a515e),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [Color(0xfff2cbd0), Color(0xfff4ced9)],
            )),
        child: SingleChildScrollView(
          child: Stack(
            children: <Widget>[
              CurvedWidget(
                child: Container(
                  padding: const EdgeInsets.only(top: 100, left: 50),
                  width: double.infinity,
                  height: 300,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.white, Colors.white.withOpacity(0.4)], //opacidad del rojo
                    ),
                  ),
                  child: Text('Register', style: TextStyle(
                    fontSize: 40,
                    color: Color(0xff6a515e),
                  ),),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 230), //margen top de text email
                child: RegisterForm(),
              )
            ],
          ),
        ),
      ),
    );
  }



}