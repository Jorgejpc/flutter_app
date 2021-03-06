import 'package:flutter_app/Vehiculo/model/vehiculo.dart';
import 'package:flutter_app/Vehiculo/repository/cloud_firestore_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreRepository {
  final _cloudFirestoreAPI = CloudFirestoreAPI();

  void updateVehiculoData(Vehiculo vehiculo) => _cloudFirestoreAPI.updateVehiculoData(vehiculo);
  
}