import 'package:flutter/material.dart';

class HomeView extends StatelessWidget{

  late BuildContext _context;

  @override
  Widget build(BuildContext context) {
    _context = context;

  void volverApp(){
    Navigator.of(_context).popAndPushNamed("/loginview");
  }

  Column columna = Column(children: [
    Padding(padding: EdgeInsets.symmetric(vertical: 10)),
    Text("Bienvenido a Kyty", style: TextStyle(fontSize: 25)),

    Padding(padding: EdgeInsets.symmetric(vertical: 7)),
    Row(mainAxisAlignment: MainAxisAlignment.center,
    children: [
    TextButton(onPressed: volverApp, child: Text("Volver"),
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