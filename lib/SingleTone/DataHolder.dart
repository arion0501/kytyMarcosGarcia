import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/FirestoreObjects/FbUsuario.dart';
import 'package:kyty/SingleTone/FirebaseAdmin.dart';
import 'package:kyty/SingleTone/GeolocAdmin.dart';
import 'package:kyty/SingleTone/HttpAdmin.dart';
import 'package:kyty/SingleTone/PlatformAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../FirestoreObjects/FbPost.dart';

class DataHolder {

  static final DataHolder _dataHolder = DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();
  GeolocAdmin geolocAdmin = GeolocAdmin();
  late PlatformAdmin platformAdmin;
  HttpAdmin httpAdmin = HttpAdmin();
  FbUsuario? usuario;

  String sNombre = "Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;

  DataHolder._internal() {
    initCachedFbPost();
  }

  void initDataHolder() {
    sPostTitle = "Titulo de Post";
  }

  void initPlatformAdmin(BuildContext context) {
    platformAdmin = PlatformAdmin(context: context);
  }

  factory DataHolder() {
    return _dataHolder;
  }

  void crearPostEnFB(FbPost post) {
    CollectionReference<FbPost> postRef = db
        .collection("Post")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post,_) => post.toFirestore());

    postRef.add(post);
  }

  void saveSelectedPostInCache() async {
    if(selectedPost != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('titulo', selectedPost!.titulo);
      prefs.setString('cuerpo', selectedPost!.cuerpo);
      prefs.setString('imagen', selectedPost!.imagen);
    }
  }

  Future<FbUsuario?> loadFbUsuario() async {
    String uidUser = FirebaseAuth.instance.currentUser!.uid;

    DocumentReference<FbUsuario> reference = db.collection('Users')
        .doc(uidUser)
        .withConverter(fromFirestore: FbUsuario.fromFirestore,
        toFirestore: (FbUsuario usuario, _) => usuario.toFirestore());

    DocumentSnapshot<FbUsuario> docSnap = await reference.get();
    usuario = docSnap.data();

    return usuario;
  }

  Future<FbPost?> initCachedFbPost() async {
    if(selectedPost != null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpostTitulo = prefs.getString('titulo');
    fbpostTitulo ??= "";

    String? fbpostCuerpo = prefs.getString('cuerpo');
    fbpostCuerpo ??= "";

    String? fbpostImagen = prefs.getString('imagen');
    fbpostImagen ??= "";

    selectedPost = FbPost(titulo: fbpostTitulo, cuerpo: fbpostCuerpo,
    imagen: fbpostImagen);

    return selectedPost;
  }

  void suscribeACambiosGPSUsuario () {
    geolocAdmin.registrarCambiosLoc(posicionDelMovilCambio);
  }

  void posicionDelMovilCambio(Position? position) {
    usuario!.geoloc = GeoPoint(position!.latitude, position.longitude);
    fbAdmin.actualizarPerfilUsuario(usuario!);
  }
}