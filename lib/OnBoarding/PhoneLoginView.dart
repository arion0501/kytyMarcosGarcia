import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/KTTextField.dart';

class PhoneLoginView extends StatefulWidget {
  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();

  void enviarTelefonoPressed() {
    String sTelefono = tecPhone.text;
    FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+44 7123 123 456',
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codigoEnviado,
      codeAutoRetrievalTimeout: codeAutoRetrievalTimeout,
    );
  }

  void enviarVerifyPressed() {

  }

  void verificacionCompletada(PhoneAuthCredential credencial) {

  }

  void verificacionFallida(FirebaseAuthException excepcion) {

  }

  void codigoEnviado(String, int? codigo) {

  }

  void codeAutoRetrievalTimeout(String tiempoCodigo) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          KTTextField(labelText: 'Número de teléfono', tecController: tecPhone),
          TextButton(onPressed: enviarTelefonoPressed, child: Text('Enviar')),
          KTTextField(labelText: 'Número de verificación', tecController: tecVerify),
          TextButton(onPressed: enviarVerifyPressed, child: Text('Enviar')),
        ],
      ),
    );
  }
}