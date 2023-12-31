import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/SingleTone/DataHolder.dart';
import '../FirestoreObjects/FbUsuario.dart';

class LoginView extends StatelessWidget {

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  LoginView({super.key});

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed("/registerview");
  }

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );

      FbUsuario? usuario = await DataHolder().loadFbUsuario();

      if (usuario != null) {
        print("nombre login user: ${usuario.nombre}");
        print("edad login user: ${usuario.edad}");
        Navigator.of(_context).popAndPushNamed("/homeview");
      }
      else {
        Navigator.of(_context).popAndPushNamed("/perfilview");
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      const Text("Bienvenido a Kyty Login", style: TextStyle(fontSize: 25)),

      Padding(padding: const EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
        child: Flexible(child: SizedBox(width: 500, child: TextField(
          controller: tecUsername,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe tu usuario',
              fillColor: Colors.white,
              filled: true
          ),
        ),
        ),
        ),
      ),

      Padding(padding: const EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
        child: Flexible(child: SizedBox(width: 500, child: TextField(
          controller: tecPassword,
          obscureText: true,
          decoration: const InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe tu contraseña',
              fillColor: Colors.white,
              filled: true
          ),
        ),
        ),
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAceptarLogin, style: TextButton.styleFrom(foregroundColor: Colors.black), child: const Text("Aceptar"),),
          TextButton(onPressed: onClickRegistrar, style: TextButton.styleFrom(foregroundColor: Colors.black), child: const Text("Registrar"),)
        ],)
    ],);

    AppBar appBar = AppBar(
      title: const Text('Login'),
      centerTitle: true,
      backgroundColor: Colors.black,
      foregroundColor: Colors.cyan,
    );

    Scaffold scaf = Scaffold(body: columna,
        backgroundColor: Colors.cyan,
        appBar: appBar);

    return scaf;
  }
}