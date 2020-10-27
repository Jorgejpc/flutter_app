import 'package:flutter/material.dart';
import 'package:flutter_app/Usuario/model/user.dart';

class Vehiculo {
  String id;
  String marca;
  String modelo;
  int year;
  String color;
  int kilometraje;
  User userOwner;

  
  Vehiculo({
    Key key,
    @required this.id,
    @required this.marca,
    @required this.modelo,
    @required this.year,
    @required this.color,
    @required this.kilometraje,
    @required this.userOwner
  });
  
}