import 'package:flutter/material.dart';

class PostCellView extends StatelessWidget{

  final String sText;
  final int iColorCode;
  final double dFontSize;

  const PostCellView ({
    required this.sText,
    required this.iColorCode,
    required this.dFontSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.amber[iColorCode],
      child: Row(
        children: [
          Image.asset('resources/logo_kyty.png',
            width: 30,
            height: 45),
          Text(sText)
        ],
      )
    );
  }
}