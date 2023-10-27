import 'package:flutter/material.dart';
import 'package:kyty/FirestoreObjects/FbPost.dart';
import 'package:kyty/SingleTone/DataHolder.dart';

class PostView extends StatefulWidget {

  @override
  State<PostView> createState() => _PostViewState();
}
class _PostViewState extends State<PostView> {
  late FbPost selectedPost;

  @override
  void initState() async{
    super.initState();
    setState(() async {
      selectedPost = await DataHolder().initCachedFbPost();
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title: Text(DataHolder().sNombre)),
      body: Column(
        children: [
          Text(DataHolder().selectedPost.titulo),
          Text(DataHolder().selectedPost.cuerpo),
          Image.asset("resources/logo_kyty.png", width: 70),
          TextButton(onPressed: null, child: Text("Like"))
        ],
      ),
    );
  }
}
