import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../FirestoreObjects/FbUsuario.dart';

class LoginView extends StatelessWidget{

  late BuildContext _context;
  FirebaseFirestore db = FirebaseFirestore.instance;

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

      String uidUser = FirebaseAuth.instance.currentUser!.uid;

      DocumentReference<FbUsuario> reference = db.collection('Users')
          .doc(uidUser)
          .withConverter(fromFirestore: FbUsuario.fromFirestore,
          toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

      DocumentSnapshot<FbUsuario> docSnap = await reference.get();
      FbUsuario usuario = docSnap.data()!;

      if(usuario != null) {
        print("nombre login user: " + usuario.nombre);
        print("edad login user: " + usuario.edad.toString());
        print("altura login user: " + usuario.altura.toString());
        print("color pelo login user: " + usuario.colorPelo);
        Navigator.of(_context).popAndPushNamed("/homeview");
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
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty Login", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
        child: Flexible(child: SizedBox(width: 500, child: TextField(
          controller: tecUsername,
          decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: 'Escribe tu usuario',
              fillColor: Colors.white,
              filled: true
          ),
        ),
        ),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: Checkbox.width, vertical: 14),
        child: Flexible(child: SizedBox(width: 500, child: TextField(
          controller: tecPassword,
          obscureText: true,
          decoration: InputDecoration(
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
          TextButton(onPressed: onClickAceptarLogin, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text("Aceptar"),),
          TextButton(onPressed: onClickRegistrar, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text("Registrar"),)
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