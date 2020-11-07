import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class NavbarCar extends StatefulWidget {


  const NavbarCar({Key key}) : super(key: key);
  @override
  _NavbarCarState createState() => _NavbarCarState();
}

class _NavbarCarState extends State<NavbarCar> {
  final User user = FirebaseAuth.instance.currentUser;
  String Marca = '';
  String Modelo = '';
  String Year = '';
  String Color = '';
  String Km = '';
  String Owner = '';

  createTodos(){
    final User user = FirebaseAuth.instance.currentUser;
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    Map<String, String> todos={'Marca': Marca, 'Modelo': Modelo, 'Year': Year, 'Color': Color, 'Km': Km, 'Owner': user.uid};

    documentReference.doc(user.uid).collection('Car').doc().set(todos).whenComplete((){
      print('$Marca, $Modelo created');
    });

  }

  deleteTodos(item){
    CollectionReference documentReference = FirebaseFirestore.instance.collection('Users');

    documentReference.doc(user.uid).collection('Car').doc(item).delete().whenComplete((){
      print('$item deleted');
    });

  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Mis Vehiculos"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: ()  {
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                    shape: RoundedRectangleBorder(borderRadius:
                        BorderRadius.circular(8)),
                    title: Text('new Car'),
                  content: new Column(
                    children: [
                      new Expanded(
                          child: new TextField(
                            decoration: new InputDecoration(
                                labelText: 'Marca', hintText: 'eg. Toyota'),
                            onChanged: (String value) {
                              Marca = value;
                            },
                          )),
                      new Expanded(
                          child: new TextField(
                            decoration: new InputDecoration(
                                labelText: 'Modelo', hintText: 'Corola'),
                            onChanged: (String value) {
                              Modelo = value;
                            },
                          )),
                      new Expanded(
                          child: new TextField(
                            decoration: new InputDecoration(
                                labelText: 'Year', hintText: '2010'),
                            onChanged: (String value) {
                              Year = value;
                            },
                          )),
                      new Expanded(
                          child: new TextField(
                            decoration: new InputDecoration(
                                labelText: 'Color', hintText: 'blue'),
                            onChanged: (String value) {
                              Color = value;
                            },
                          )),
                      new Expanded(
                          child: new TextField(
                            decoration: new InputDecoration(
                                labelText: 'Km', hintText: '4000'),
                            onChanged: (String value) {
                              Km = value;
                            },
                          )),
                    ],

                  ),



                    actions: <Widget>[
                        FlatButton(
                            onPressed:(){
                                createTodos();
                                Navigator.of(context).pop();
                            },
                            child:Text('add'))
                    ],
                );
          });
        },
        child: Icon(
          Icons.add_box,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('Users').doc(user.uid).collection('Car').snapshots(),
          builder: (context, snapshots){
        return ListView.builder(
          shrinkWrap: true,
          itemCount: snapshots.data.docs.length,
          itemBuilder: (context, index){
            DocumentSnapshot documentSnapshot = snapshots.data.docs[index];
            return Dismissible(
              onDismissed: (direction){
                deleteTodos(documentSnapshot.id);
              },
              key: Key(documentSnapshot['Modelo']),
              child: Card(
                elevation: 4,
                margin: EdgeInsets.all(8),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
                child: ListTile(
                   title:Text(documentSnapshot['Color']),
                   subtitle:Text(documentSnapshot['Marca']),
                   trailing: IconButton(
                     icon: Icon(
                       Icons.delete,
                       color: Colors.red,
                     ),
                     onPressed: (){
                       deleteTodos(documentSnapshot.id);
                     }),
              ),
              )
            );
          },
        );
      }),
    );
  }









  Future _addCar() async {
    print("HOLAAAAAAAAAAAAAAAAA");
    final User user = FirebaseAuth.instance.currentUser;
    final CollectionReference _usersRef = FirebaseFirestore.instance.collection('Users').doc(user.uid.toString()).collection('Cars');

    return _usersRef.doc(user.uid).collection('Cars').add({
        'marca': 'marca',
        'modelo': 'modelo',
        'year': 'year',
        'color': 'phoneNumbre',
        'kilometraje': 'photoURL',
        'userOwner': user.uid,


      }).then((value) => print("Car Added"))
          .catchError((error) => print("Failed to add user: $error"));

  }
}


