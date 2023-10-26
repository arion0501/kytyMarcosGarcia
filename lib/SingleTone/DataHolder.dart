import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../FirestoreObjects/FbPost.dart';

class DataHolder {

  static final DataHolder _dataHolder = new DataHolder._internal();
  FirebaseFirestore db = FirebaseFirestore.instance;

  String sNombre="Kyty DataHolder";
  late String sPostTitle;
  late FbPost selectedPost;

  DataHolder._internal() {
    sPostTitle="Titulo de Post";
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

  void initCachedFbPost() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    String? fbpost_titulo = prefs.getString('fbpost_titulo');
    fbpost_titulo ??= "";

    String? fbpost_cuerpo = prefs.getString('fbpost_cuerpo');
    if(fbpost_cuerpo == null) {
      fbpost_cuerpo = "";
    }
    selectedPost = FbPost(titulo: fbpost_titulo, cuerpo: fbpost_cuerpo);
  }
}