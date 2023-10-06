import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late BuildContext _context;

  @override
  void initState() {
    super.initState();
  }

  void onClickVolver(){
    FirebaseAuth.instance.signOut();
    Navigator.of(_context).popAndPushNamed('/loginview');
  }

  final List<String> posts = <String> ['A, B, C'];
  final List <int> colorCode = <int> [500, 600, 100];
  final List <double> fontSize = <double> [30, 15, 70];

  Widget? creadorDeItemLista(BuildContext contect, int index) {
    return Text('Post' + posts[index],
    style: TextStyle(color: Colors.pinkAccent[colorCode[index]],
    fontSize: fontSize[index]));
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: ListView.builder(
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
      ),
    );
  }
}