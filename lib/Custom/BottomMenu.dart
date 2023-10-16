import 'package:flutter/material.dart';

import '../Interfaces/BottomMenuEvents.dart';

class BottomMenu extends StatelessWidget{

  Function (int indice)? evento;

  BottomMenu({Key? key,required this.evento
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          TextButton(onPressed: () => evento!(0), child: Icon(Icons.list,color: Colors.pink,)),
          TextButton(onPressed: () => evento!(1), child: Icon(Icons.grid_view,color: Colors.pink,)),
          IconButton(onPressed: () => evento!(2), icon: Image.asset("resources/logo_kyty.png"))
        ]
    );
  }
}