import 'package:flutter/material.dart';
import 'package:kyty/Custom/ContainerView.dart';

class GridCellView extends StatelessWidget {

  final String sText;
  final int iColorCode;
  final double dFontSize;
  final bool bPrimary;
  final double dPadding;

  const GridCellView({
    required this.sText,
    required this.iColorCode,
    required this.dFontSize,
    required this.bPrimary,
    required this.dPadding
  });

  @override
  Widget build(BuildContext context) {
    return GridView.z(
      primary: bPrimary,
      padding: EdgeInsets.all(dPadding),
      crossAxisSpacing: 10,
      mainAxisSpacing: 10,
      crossAxisCount: 2,
      children: <Widget>[
        ContainerView(
          sText: 'hola',
          dPadding: 8,
          dFontSize: 12,
          iColorCode: 5
        ),
        ContainerView(
            sText: 'adios',
            dPadding: 11,
            dFontSize: 3,
            iColorCode: 9
        ),
        ContainerView(
            sText: 'hola',
            dPadding: 8,
            dFontSize: 12,
            iColorCode: 5
        ),
        ContainerView(
            sText: 'adios',
            dPadding: 11,
            dFontSize: 3,
            iColorCode: 9
        ),
      ],
    );
  }
}