import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kyty/SingleTone/FirebaseAdmin.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;
  FirebaseAdmin fbAdmin = FirebaseAdmin();

  String sNombre = "Kyty DataHolder";
  late String sPostTitle;
  FbPost? selectedPost;

  DataHolder._internal() {
    initCachedFbPost();
  }

  void initDataHolder() {
    /*sPostTitle = "Titulo de Post";
    initCachedFbPost();*/
  }

  factory DataHolder(){
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
    }
  }

  Future<FbPost?> initCachedFbPost() async {
    if(selectedPost != null) return selectedPost;

    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('cuerpo');
    fbpost_cuerpo ??= "";

    print("Shared preferences --> " + fbpost_titulo);
    selectedPost = FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);

    return selectedPost;
  }
}