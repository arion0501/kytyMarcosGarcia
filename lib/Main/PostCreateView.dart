import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import '../Custom/KTTextField.dart';
import '../SingleTone/DataHolder.dart';

class PostCreateView extends StatelessWidget {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          KTTextField(tecController: tecTitulo,
              labelText:'Escribe un titulo'),

          KTTextField(tecController: tecCuerpo,
              labelText:'Escribe un cuerpo'),

          Image.asset("resources/logo_kyty.png", width: 65),

          TextButton(onPressed: () {
            FbPost postNuevo = new FbPost(
              titulo: tecTitulo.text,
              cuerpo: tecCuerpo.text,
            );
            CollectionReference<FbPost> postsRef = db.collection("Post")
                .withConverter(
              fromFirestore: FbPost.fromFirestore,
              toFirestore: (FbPost post, _) => post.toFirestore(),
            );
            postsRef.add(postNuevo);
            Navigator.of(context).popAndPushNamed("/homeview");
            },
              child: Text("Postear")
          )
        ],
      ),
    );
  }
}