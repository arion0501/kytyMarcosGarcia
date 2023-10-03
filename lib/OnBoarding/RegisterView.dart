import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class RegisterView extends StatelessWidget {

  late BuildContext _context;

  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController repasswordController = TextEditingController();

  SnackBar snackbar = SnackBar(content: Text("¡Vaya! Las contraseñas no son iguales...")
  );

  void onClickCancelar() {
    Navigator.of(_context).popAndPushNamed("/loginview");
  }

  void onClickAceptar() async {
    // print("username -> " + usernameController.text);

    if (passwordController.text == repasswordController.text)
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );

      Navigator.of(_context).popAndPushNamed('/perfilview');

    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
    else {
    ScaffoldMessenger.of(_context).showSnackBar(snackbar);
    }
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column columna = Column(children: [
      Padding(padding: EdgeInsets.symmetric(vertical: 10)),
      Text("Bienvenido a Kyty Register", style: TextStyle(fontSize: 25)),

      Padding(padding: EdgeInsets.symmetric(horizontal: 500, vertical: 14),
        child: TextField(
          controller: usernameController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Escribe tu usuario',
            fillColor: Colors.white,
            filled: true
          ),
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 500, vertical: 14),
        child: TextFormField(
          controller: passwordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Escribe tu password',
            fillColor: Colors.white,
            filled: true
          ),
          obscureText: true,
        ),
      ),

      Padding(padding: EdgeInsets.symmetric(horizontal: 500, vertical: 14),
        child: TextFormField(
          controller: repasswordController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Repite tu password',
              fillColor: Colors.white,
              filled: true,
          ),
          obscureText: true,
        ),
      ),

      Row(mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(onPressed: onClickAceptar, style: TextButton.styleFrom(foregroundColor: Colors.black) ,child: Text("Aceptar"),),
          TextButton(onPressed: onClickCancelar, style: TextButton.styleFrom(foregroundColor: Colors.black), child: Text("Cancelar"),)
        ],)
    ],);

    AppBar appBar = AppBar(
      title: const Text('Register'),
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