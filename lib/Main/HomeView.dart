import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatelessWidget{

  late BuildContext _context;

  void onClickVolver() {
    FirebaseAuth.instance.signOut();
    Navigator.of(_context).popAndPushNamed('/loginview');
}

  @override
  Widget build(BuildContext context) {
    _context = context;

  Column columna = Column(children: [
    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
    Text("Bienvenido a Kyty", style: TextStyle(fontSize: 25)),

    Padding(padding: EdgeInsets.symmetric(vertical: 7)),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextButton(onPressed: onClickVolver, child: Text("Volver"),
    ),
    ],)
  ]);

  AppBar appBar = AppBar(
    title: const Text('Home'),
    centerTitle: true,
    backgroundColor: Colors.black,
    foregroundColor: Colors.cyan,
  );

  Scaffold scaf = Scaffold(body: columna,
    backgroundColor: Colors.cyan,
    appBar: appBar,);

  return scaf;
  }
}