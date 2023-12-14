import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Custom/KTTextField.dart';
import 'package:kyty/SingleTone/DataHolder.dart';
import '../FirestoreObjects/FbUsuario.dart';

class PhoneLoginView extends StatefulWidget {
  const PhoneLoginView({super.key});

  @override
  State<PhoneLoginView> createState() => _PhoneLoginViewState();
}

class _PhoneLoginViewState extends State<PhoneLoginView> {

  TextEditingController tecPhone = TextEditingController();
  TextEditingController tecVerify = TextEditingController();
  String sVerificationCode = "";
  bool blMostrarVerification = false;

  void enviarTelefonoPressed() async{
    String sTelefono = tecPhone.text;

    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: sTelefono,
      verificationCompleted: verificacionCompletada,
      verificationFailed: verificacionFallida,
      codeSent: codigoEnviado,
      codeAutoRetrievalTimeout: tiempoDeEsperaAcabado,
    );
  }

  void enviarVerifyPressed() async{
    String smsCode = tecVerify.text;

    // Create a PhoneAuthCredential with the code
    PhoneAuthCredential credential =
    PhoneAuthProvider.credential(verificationId: sVerificationCode, smsCode: smsCode);

    // Sign the user in (or link) with the credential
    await FirebaseAuth.instance.signInWithCredential(credential);
    FbUsuario? usuario = await DataHolder().loadFbUsuario();
    if(usuario != null) {
      print("nombre login user: ${usuario.nombre}");
      print("edad login user: ${usuario.edad}");
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed('/perfilview');
    }
  }

  void verificacionCompletada(PhoneAuthCredential credencial) async{
    await FirebaseAuth.instance.signInWithCredential(credencial);
    FbUsuario? usuario = await DataHolder().loadFbUsuario();

    if(usuario != null) {
      print("nombre login user: ${usuario.nombre}");
      print("edad login user: ${usuario.edad}");
      Navigator.of(context).popAndPushNamed("/homeview");
    }
    else{
      Navigator.of(context).popAndPushNamed('/perfilview');
    }
  }

  void verificacionFallida(FirebaseAuthException excepcion) {
    if (excepcion.code == 'invalid-phone-number') {
      print('The provided phone number is not valid.');
    }
  }

  void codigoEnviado(String codigo, int? resendToken) async{
    sVerificationCode = codigo;
    setState(() {
      blMostrarVerification = true;
    });
  }

  void tiempoDeEsperaAcabado(String tiempoCodigo) {

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          KTTextField(labelText: 'Número de teléfono', tecController: tecPhone),
          TextButton(onPressed: enviarTelefonoPressed, child: const Text('Enviar')),
          if(blMostrarVerification)
            KTTextField(labelText: 'Número de verificación', tecController: tecVerify),
          if(blMostrarVerification)
            TextButton(onPressed: enviarVerifyPressed, child: const Text('Enviar')),
        ],
      ),
    );
  }
}