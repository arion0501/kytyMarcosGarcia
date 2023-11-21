import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

class PerfilView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController tecNombre = TextEditingController();
  TextEditingController tecEdad = TextEditingController();

  FirebaseFirestore db = FirebaseFirestore.instance;

  void onClickAceptar() async {

    FbUsuario usuario = new FbUsuario(nombre: tecNombre.text,
        edad: int.parse(tecEdad.text), altura: 0, colorPelo: '',
        geoloc: GeoPoint(0, 0));

    // UID del usuario que está logeado
    String uidUser = FirebaseAuth.instance.currentUser!.uid;

    // Crear documento con un ID nuestro
    await db.collection("Users").doc(uidUser).set(usuario.toFirestore());

    Navigator.of(_context).popAndPushNamed('/homeview');
  }

  void onClickCancelar()  {

  }

  @override
  Widget build(BuildContext context) {

    _context = context;

    return Scaffold(
      backgroundColor: Colors.indigoAccent,

      appBar: AppBar(
        title: const Text('Perfil'),
        backgroundColor: Colors.pinkAccent,
        centerTitle: true,
        shadowColor: Colors.yellow,
      ),

      // drawer: Image.asset('resources/logo_kyty.png'),

      body: Column(

        // mainAxisAlignment: MainAxisAlignment.center,

        children: [
          Padding(padding: EdgeInsets.symmetric(vertical: 10)),
          Text("Bienvenido a tu perfil", style: TextStyle(fontSize: 25)),

          Padding(
            padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              // textAlign: TextAlign.center,
              controller: tecNombre,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu nombre',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
            child: Flexible(child: SizedBox(width: 400, child: TextField(
              controller: tecEdad,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Escribe tu edad',
                  fillColor: Colors.white,
                  filled: true
              ),
            ),
            ),
            ),
          ),

          Row(mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
              TextButton(onPressed: onClickCancelar, child: Text("Cancelar"),)
            ],)
        ], // children
      ),
    );
  }
}