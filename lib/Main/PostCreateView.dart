import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import '../Custom/KTTextField.dart';
import '../SingleTone/DataHolder.dart';

class PostCreateView extends StatelessWidget {

  FirebaseFirestore db = FirebaseFirestore.instance;
  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();
  TextEditingController tecImagen = TextEditingController();
  ImagePicker _picker = ImagePicker();

  void onGalleryClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  }

  void onCameraClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
  }

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

          Row(
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galería")),
              TextButton(onPressed: onCameraClicked, child: Text("Cámara"))
            ],
          ),

          TextButton(onPressed: () {
            FbPost postNuevo = new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
                imagen:  tecImagen.text);

            DataHolder().crearPostEnFB(postNuevo);

            Navigator.of(context).popAndPushNamed("/homeview");
          },
              child: Text("Postear")
          )
        ],
      ),
    );
  }
}