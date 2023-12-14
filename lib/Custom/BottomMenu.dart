import 'package:flutter/material.dart';

class BottomMenu extends StatelessWidget{

  Function (int indice)? evento;

  BottomMenu({super.key,required this.evento
  });

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => evento!(0), child: const Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => evento!(1), child: const Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => evento!(2), icon: Image.asset("resources/logo_kyty.png", width: 30, height: 30))
        ]
    );
  }
}