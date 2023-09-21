import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    //Text texto=Text("Hola Mundo desde Kyty");
    //return texto;

    Future<void> onClickAceptar() async {
      try {
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: "marcosgarciadam@gmai.com",
          password: "holahola2",
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }

    Column columna = Column(children: [
      Text("Bienvenido a Kyty Register", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: TextField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu usuario',
          ),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Escribe tu password',
          ),
          obscureText: true,
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 60, vertical: 16),
        child: TextFormField(
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            hintText: 'Repite tu password',
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAceptar, child: Text("Aceptar"),),
          TextButton(onPressed: () {
            Navigator.of(context).popAndPushNamed('/loginview');
          }, child: Text("Cancelar"),)
        ],)
    ],);

    AppBar appBar = AppBar(
      title: const Text('Register'),
      centerTitle: true,
      shadowColor: Colors.pink,
      backgroundColor: Colors.greenAccent,
    );

    Scaffold scaf = Scaffold(body: columna,
      //backgroundColor: Colors.deepOrange,
      appBar: appBar,);

    return scaf;
  }
}