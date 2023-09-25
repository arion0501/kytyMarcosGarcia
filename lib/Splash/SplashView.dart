import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SplashView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashViewState();
  }
}

class _SplashViewState extends State<SplashView> {
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
    checkSesion();
  }

  void checkSesion() async {
    await Future.delayed(Duration(seconds: 3));

    if(FirebaseAuth.instance.currentUser != null) {
      Navigator.of(_context).popAndPushNamed("/homeview");
    }
    else
      Navigator.of(_context).popAndPushNamed("/loginview");
  }

  @override
  Widget build(BuildContext context) {
    _context = context;

    Column column = Column(
      children: [Image.asset('resources/logo_kyty.png', width: 300, height: 250),
        Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        CircularProgressIndicator(),
      ],
    );

    return column;
  }
}