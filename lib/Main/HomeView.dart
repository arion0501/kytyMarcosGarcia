import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:kyty/Custom/DrawerCustom.dart';
import 'package:kyty/Custom/PostCellView.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/SingleTone/DataHolder.dart';
import '../Custom/BottomMenu.dart';
import '../Custom/PostGridCellView.dart';
import '../OnBoarding/LoginView.dart';

class HomeView extends StatefulWidget {
  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  void fHomeViewDrawerOntap(int indice) {
    if(indice == 0){
      FirebaseAuth.instance.signOut();
      //Navigator.of(context).pop();
      //Navigator.of(context).popAndPushNamed("/loginview");
      Navigator.of(context).pushAndRemoveUntil (
        MaterialPageRoute (builder: (BuildContext context) =>  LoginView()),
        ModalRoute.withName('/loginview'),
      );
    }
    else if(indice == 1){

    }
  }

  FirebaseFirestore db = FirebaseFirestore.instance;
  final List<FbPost> posts = [];
  final Map<String, FbPost> mapPosts = Map();
  bool bIsList = false;

  void onBottonMenuPressed(int indice) {
    print("--> HOME " + indice.toString() + "!" );
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
    determinarTempLocal();
  }

  determinarTempLocal() async {
    Position position = await DataHolder().geolocAdmin.determinePosition();
    double valor = await DataHolder().httpAdmin.pedirTemperaturasEn(position.latitude, position.longitude);
    print('La temperatura en el sitio donde estás es: ${valor}');
  }

  void descargarPosts() async {
    posts.clear();

    CollectionReference<FbPost> ref = db.collection("Post")
        .withConverter(fromFirestore: FbPost.fromFirestore,
        toFirestore: (FbPost post, _) => post.toFirestore());

    //QuerySnapshot<FbPost> querySnapshot = await collection.get();

    ref.snapshots().listen(datosDescargados, onError: descargaPostError);
  }

  void datosDescargados(QuerySnapshot<FbPost> postsDescargados) {
    for (int i = 0; i < postsDescargados.docChanges.length; i++) {
      FbPost temp = postsDescargados.docChanges[i].doc.data()!;
      mapPosts[postsDescargados.docChanges[i].doc.id] = temp;
    }
    setState(() {
      posts.clear();
      posts.addAll(mapPosts.values);
    });
    /*posts.clear();
    for (int i = 0; i < postsDescargados.docs.length; i++) {
      setState(() {
        posts.add(postsDescargados.docs[i].data());
      });
    }*/
  }

  void descargaPostError(error) {
    print("Listen failed: $error");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Kyty"),
        /*actions: [
            IconButton(
              icon: const Icon(Icons.refresh),
              tooltip: 'Refrescar Lista',
              onPressed: descargarPosts,
            )]*/
      ),
      body: Center(
        child: celdasOLista(bIsList),
      ),
      bottomNavigationBar: BottomMenu(evento: onBottonMenuPressed),
      drawer: DrawerCustom(onItemTap: fHomeViewDrawerOntap),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushNamed("/postcreateview");
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.miniEndDocked,
    );
  }

  void onItemListaClicked(int index) {
    DataHolder().selectedPost = posts[index];
    DataHolder().saveSelectedPostInCache();
    Navigator.of(context).pushNamed('/postview');
  }

  Widget? creadorDeItemLista(BuildContext context, int index) {
    return PostCellView(sText: posts[index].titulo,
        dFontSize: DataHolder().platformAdmin.getScreenHeight()*0.02,
        iColorCode: Colors.pink,
        iPosicion: index,
        onItemListClickedFun: onItemListaClicked
    );
  }

  Widget? creadorDeItemMatriz(BuildContext context, int index) {
    return PostGridCellView(
      post: posts,
      onItemListClickedFun: onItemListaClicked,
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

  Widget? celdasOLista(bool isList) {
    if (isList) {
      return ListView.separated(
        padding: EdgeInsets.all(8),
        itemCount: posts.length,
        itemBuilder: creadorDeItemLista,
        separatorBuilder: creadorDeSeparadorLista,
      );
    }
    else {
      return creadorDeItemMatriz(context, posts.length);
    }
  }
}