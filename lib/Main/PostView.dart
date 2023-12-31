import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/SingleTone/DataHolder.dart';

class PostView extends StatefulWidget {
  const PostView({super.key});


  @override
  State<PostView> createState() => _PostViewState();
}
class _PostViewState extends State<PostView> {
  FbPost _datosPost = FbPost(titulo: "titulo", cuerpo: "cuerpo", imagen: "imagen");

  @override
  void initState() {
    super.initState();
    cargarPostGuardadoEnCache();
  }

  void cargarPostGuardadoEnCache() async {
    var temp1 = await DataHolder().initCachedFbPost();

    setState(() {
      _datosPost = temp1!;
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(_datosPost.titulo),
          Text(_datosPost.cuerpo),
          Image.network(_datosPost.imagen, width: 70, height: 70),
          const TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}
