import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView.dart';
import 'package:kyty/Main/HomeView2.dart';
import 'package:kyty/Main/PostCreateView.dart';
import 'package:kyty/OnBoarding/PerfilView.dart';
import 'package:kyty/SingleTone/DataHolder.dart';
import 'package:kyty/Splash/SplashView.dart';
import 'Main/PostView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/PhoneLoginView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{
  const KytyApp({super.key});


  @override
  Widget build(BuildContext context) {
    DataHolder().initPlatformAdmin(context);
    MaterialApp materialApp;
    if (kIsWeb) {
      materialApp = MaterialApp(title: "KyTy Miau!",
        routes: {
          '/loginview':(context) => LoginView(),
          '/registerview':(context) => RegisterView(),
          '/homeview':(context) => const HomeView(),
          '/splashview':(context) => const SplashView(),
          '/perfilview':(context) => PerfilView(),
          '/postview':(context) => const PostView(),
          '/postcreateview':(context) => const PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
    else {
      materialApp = MaterialApp(title: "KyTy Miau!",
        routes: {
          '/loginview':(context) => const PhoneLoginView(),
          '/registerview':(context) => RegisterView(),
          '/homeview':(context) => const HomeView2(),
          '/splashview':(context) => const SplashView(),
          '/perfilview':(context) => PerfilView(),
          '/postview':(context) => const PostView(),
          '/postcreateview':(context) => const PostCreateView(),
        },
        initialRoute: '/splashview',
      );
    }
    return materialApp;
  }
}