import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/PostCellView.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import '../Custom/BottomMenu.dart';
import '../Custom/PostGridCellView.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  bool bIsList = false;

  void onBottonMenuPressed(int indice) {
    print("--> HOME!" + indice.toString());
    setState(() {
      if(indice == 0){
        bIsList = true;
      }
      else if(indice == 1){
        bIsList = false;
      }
    });
  }

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
    for (int i = 0; i < querySnapshot.docs.length; i++) {
      setState(() {
        posts.add(querySnapshot.docs[i].data());
      });
    }
  }

  final List <String> postsOLD = <String>['A', 'B', 'C'];
  final List <int> colorCode = <int>[600, 500, 100];
  final List <double> fontSize = <double>[30, 15, 70];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(evento: onBottonMenuPressed),
      /*
        ListView.separated(
          padding: EdgeInsets.all(8),
          itemCount: posts.length,
          itemBuilder: creadorDeItemLista,
          separatorBuilder: creadorDeSeparadorLista,
        ):
        GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 5),
            itemCount: posts.length,
            itemBuilder: creadorDeItemMatriz
        ),
      ),*/
    );
  }

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
      dFontSize: 60,
      iColorCode: 0,
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index) {
    return PostGridCellView(sText: posts[index].titulo,
      dFontSize: 18,
      iColorCode: 17,
      dHeight: 150,
    );
  }

  Widget creadorDeSeparadorLista(BuildContext context, int index) {
    return Column(
      children: [
        Divider(),
        //Image.network("https://media.tenor.com/zBc1XhcbTSoAAAAC/nyan-cat-rainbow.gif")
      ],
    );
  }

  Widget celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    }
    else {
      return GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5),
          itemCount: posts.length,
          itemBuilder: creadorDeItemMatriz
      );
    }
  }
}