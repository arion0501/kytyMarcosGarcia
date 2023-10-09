import 'package:flutter/material.dart';

class ContainerView extends StatelessWidget {

  final String sText;
  final int iColorCode;
  final double dFontSize;
  final double dPadding;

  const ContainerView({
    required this.sText,
    required this.iColorCode,
    required this.dFontSize,
    required this.dPadding
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(dPadding),
      color: Colors.teal[iColorCode],
      child: Text(sText, style: TextStyle(fontSize: dFontSize)),
    );
  }
}