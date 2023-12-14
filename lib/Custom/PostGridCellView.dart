import 'package:flutter/material.dart';
import '../FirestoreObjects/FbPost.dart';

class PostGridCellView extends StatelessWidget{

  final List<FbPost> post;
  final Function(int indice)? onItemListClickedFun;


  const PostGridCellView({super.key,
    required this.post,
    required this.onItemListClickedFun
  });

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
        ),
        padding: const EdgeInsets.all(8),
        itemCount: post.length,
        itemBuilder: (context, index) {

          return InkWell(
            child: Container(
              color: Colors.indigoAccent,
              child: Center(
                child: Text(
                  post[index].titulo,
                  style: const TextStyle(fontSize: 20, color: Colors.orange),
                ),
              ),
            ),
            onTap: () {
              onItemListClickedFun!(index);
            },
          );
        }
    );
  }
}