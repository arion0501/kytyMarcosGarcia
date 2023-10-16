import 'package:flutter/material.dart';

class PostGridCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;
  final double dHeight;

  const PostGridCellView({super.key,
    required this.sText,
    required this.iColorCode,
    required this.dFontSize,
    required this.dHeight
  });

  @override
  Widget build(BuildContext context) {
    return
      FractionallySizedBox(
        child: Container(
            color: Colors.amber[iColorCode],
            child: Center(
              child: Text(sText,style: TextStyle(fontSize: dFontSize),
              ),
            )
        ),
      );
  }
}