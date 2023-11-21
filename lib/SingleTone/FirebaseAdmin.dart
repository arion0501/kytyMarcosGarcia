import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';

class FirebaseAdmin {

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore db = FirebaseFirestore.instance;

  void actualizarPerfilUsuario(FbUsuario usuario) async {
    // UID del usuario que está logeado
    String uidUser = FirebaseAuth.instance.currentUser!.uid;
    // Crear documento con un ID nuestro
    await db.collection("Users").doc(uidUser).set(usuario.toFirestore());
  }
}