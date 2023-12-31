import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';
import '../SingleTone/DataHolder.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    checkSesion();
  }

  void checkSesion() async {
    await Future.delayed(const Duration(seconds: 3));

    if(FirebaseAuth.instance.currentUser != null) {

      FbUsuario? usuario = await DataHolder().loadFbUsuario();

      if(usuario != null) {
        print("nombre login user: ${usuario.nombre}");
        print("edad login user: ${usuario.edad}");
        Navigator.of(context).popAndPushNamed("/homeview");
      }
      else{
        Navigator.of(context).popAndPushNamed('/perfilview');
      }
    }
    else {
      Navigator.of(context).popAndPushNamed("/loginview");
    }
  }

  @override
  Widget build(BuildContext context) {

    Column column = Column(
      children: [Image.asset('resources/logo_kyty.png',
          width: DataHolder().platformAdmin.getScreenWidth() * 0.65,
          height: DataHolder().platformAdmin.getScreenHeight() * 0.65),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        const CircularProgressIndicator(),
      ],
    );
    return column;
  }
}