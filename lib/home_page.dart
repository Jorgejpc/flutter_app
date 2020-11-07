import 'package:flutter_app/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/jorge/AndroidStudioProjects/flutter_app/lib/navbar/navbar_home.dart';
import 'package:flutter_app/navbar/navbar_car.dart';
import 'package:flutter_app/screens/register/register_screen.dart';


class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;
  final tabs = [
    Center(child: NavbarHome()),
    Center(child: NavbarCar()),
    Center(child: Text('Perfil')),
    Center(child: Text('NOTIFICATION')),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(

      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        iconSize: 25,
        selectedFontSize: 13,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text('HOME'),
            backgroundColor: Colors.blueAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.directions_car_rounded),
            title: Text('CARS'),
            backgroundColor: Colors.redAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            title: Text('PROFILE'),
            backgroundColor: Colors.deepPurpleAccent,
          ),

          BottomNavigationBarItem(
            icon: Icon(Icons.alarm),
            title: Text('NOTIFICATION'),
            backgroundColor: Colors.deepOrangeAccent,
          ),
        ],
        onTap: (index) {
          setState((){
            _currentIndex = index;
          });
        },
      ),
    );
  }
}