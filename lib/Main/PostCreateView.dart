import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../Custom/KTTextField.dart';
import '../SingleTone/DataHolder.dart';

class PostCreateView extends StatefulWidget {

  @override
  State<PostCreateView> createState() => _PostCreateViewState();
}

class _PostCreateViewState extends State<PostCreateView> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  TextEditingController tecTitulo = TextEditingController();
  TextEditingController tecCuerpo = TextEditingController();
  TextEditingController tecImagen = TextEditingController();

  ImagePicker _picker = ImagePicker();
  File _imagePreview = File("");

  void subirImagen() async {
    final storageRef = FirebaseStorage.instance.ref();

    final rutaAFicheroEnNube = storageRef.child("mountains.jpg");

    try {
      await rutaAFicheroEnNube.putFile(_imagePreview);
    } on FirebaseException catch (o) {

    }
  }

  void onGalleryClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if(image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
  }

  void onCameraClicked() async {
    XFile? image = await _picker.pickImage(source: ImageSource.camera);
    if(image != null) {
      setState(() {
        _imagePreview = File(image.path);
      });
    }
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

          if(_imagePreview.path != "")
          Image.file(_imagePreview, width: 250, height: 250),

          Row(
            children: [
              TextButton(onPressed: onGalleryClicked, child: Text("Galería")),
              TextButton(onPressed: onCameraClicked, child: Text("Cámara"))
            ],
          ),

          TextButton(onPressed: () {
            subirImagen();

            /*FbPost postNuevo = new FbPost(
                titulo: tecTitulo.text,
                cuerpo: tecCuerpo.text,
                imagen:  tecImagen.text);

            DataHolder().crearPostEnFB(postNuevo);

            Navigator.of(context).popAndPushNamed("/homeview");*/
          },
              child: Text("Postear")
          )
        ],
      ),
    );
  }
}