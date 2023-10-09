import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/ContainerView.dart';
import 'package:kyty/Custom/GridCellView.dart';
import 'package:kyty/Custom/PostCellView.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  FirebaseFirestore db = FirebaseFirestore.instance;

  final List<FbPost> posts = [];

  @override
  void initState() {
    super.initState();
    descargarPosts();
  }

  void descargarPosts() async {
    CollectionReference<FbPost> collection = db.collection("Post")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    QuerySnapshot<FbPost> querySnapshot = await collection.get();
    for(int i = 0; i < querySnapshot.docs.length; i++){
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  final List <String> postsOLD = <String> ['A', 'B', 'C'];
  final List <int> colorCode = <int> [600, 500, 100];
  final List <double> fontSize = <double> [30, 15, 70];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Kyty"),),
        body: Center(
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 4),
            itemCount: posts.length,
            itemBuilder: creadorDeItemLista,
          ),
        )
    );
  }

  /* ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      ),
    );*/

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return GridCellView(
        sText: 'hola',
        iColorCode: 5,
        dFontSize: 20,
        bPrimary: false,
        dPadding: 8,
    );
  }
  /*PostCellView(sText: posts[index].titulo,
        iColorCode: 0,
        dFontSize: 20
    );*/


  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    // return Divider(thickness: 5);
    return Column(
        children: [
          Divider(),
          // CircularProgressIndicator(),
          // Image.network('resources/logo_kyty.png')
        ]
    );
  }
}