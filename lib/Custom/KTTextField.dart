import 'package:flutter/material.dart';

class KTTextField extends StatelessWidget {

  String labelText;
  TextEditingController tecController;
  bool isPassword;
  double paddingHorizontal;
  double paddingVertical;

  KTTextField ({super.key, 
    this.labelText = "",
    required this.tecController,
    this.isPassword = false,
    this.paddingHorizontal= Checkbox.width,
    this.paddingVertical = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(padding: EdgeInsets.symmetric(horizontal: paddingHorizontal, vertical: paddingVertical),
      child: Flexible(child: SizedBox(width: 450, child: TextField(
        controller: tecController,
        obscureText: isPassword,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          filled: true,
          fillColor: Colors.white,
          labelText: labelText,
        ),
      ),
      ),
      ),
    );
  }
}