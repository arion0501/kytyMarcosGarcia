import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPost.dart';

class PostGridCellView extends StatelessWidget{

  final List<FbPost> post;

  const PostGridCellView({super.key,
    required this.post
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: EdgeInsets.all(8),
        itemCount: post.length,
        itemBuilder: (context, index) {

          return Container(
            color: Colors.indigoAccent,
            child: Center(
              child: Text(
                post[index].titulo,
                style: TextStyle(fontSize: 20, color: Colors.orange),
              ),
            ),
          );
        }
    );
  }
}