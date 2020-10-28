import 'package:flutter_app/Vehiculo/model/vehiculo.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class CloudFirestoreAPI {

  final String USERS = "users";
  final String VEHICULOS = "vehiculos";

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  void updateVehiculoData(Vehiculo vehiculo) async {
    DocumentReference ref = _db.collection(VEHICULOS).doc(vehiculo.id);
    return ref.set({
      'id': vehiculo.id,
      'marca': vehiculo.marca,
      'modelo': vehiculo.modelo,
      'year': vehiculo.year,
      'color': vehiculo.color,
      'kilometraje': vehiculo.kilometraje,
      'userOwner': vehiculo.userOwner
    }, SetOptions(merge: true));
  }
}