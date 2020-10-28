import 'package:flutter_app/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/navbar_home.dart';


class HomePage extends StatefulWidget {

  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();

}

class _HomePageState extends State<HomePage> {


  int _currentIndex = 0;
  final tabs = [
    Center(child: NavbarHome()),
    Center(child: Text('CARRS')),
    Center(child: Text('PROFILE')),
    Center(child: Text('NOTIFICATION')),
  ];
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Botton navigator example'),
      ),
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
            title: Text('CARRS'),
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