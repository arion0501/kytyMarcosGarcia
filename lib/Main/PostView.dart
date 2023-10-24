import 'package:flutter/material.dart';
import 'package:kyty/SingleTone/DataHolder.dart';

class PostView extends StatelessWidget{

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.asset("resources/logo_kyty.png", width: 70),
          TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}