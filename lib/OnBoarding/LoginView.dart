import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;

  TextEditingController tecUsername = TextEditingController();
  TextEditingController tecPassword = TextEditingController();

  void onClickRegistrar() {
    Navigator.of(_context).popAndPushNamed("/registerview");
  }

  void onClickAceptarLogin() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: tecUsername.text,
        password: tecPassword.text,
      );

      Navigator.of(_context).popAndPushNamed("/homeview");
      print("Ya estás manin");

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
    _context=context;

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty Login", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 500, vertical: 14),
        child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu usuario',
          ),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 500, vertical: 14),
        child: TextFormField(
          controller: tecPassword,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu password',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
        TextButton(onPressed: onClickAceptarLogin, child: Text("Aceptar"),),
        TextButton(onPressed: onClickRegistrar, child: Text("Registrar"),)
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
      appBar: appBar,);

    return scaf;
  }
}