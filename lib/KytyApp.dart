import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kyty/Main/HomeView.dart';
import 'package:kyty/Main/HomeView2.dart';
import 'package:kyty/Main/PostCreateView.dart';
import 'package:kyty/OnBoarding/PerfilView.dart';
import 'package:kyty/Splash/SplashView.dart';
import 'Main/PostView.dart';
import 'OnBoarding/LoginView.dart';
import 'OnBoarding/RegisterView.dart';

class KytyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    MaterialApp materialApp;
    if (kIsWeb) {
      materialApp = MaterialApp(title: "KyTy Miau!",
        routes: {
          '/loginview':(context) => LoginView(),
          '/registerview':(context) => RegisterView(),
          '/homeview':(context) => HomeView(),
          '/splashview':(context) => SplashView(),
          '/perfilview':(context) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview':(context) => PostCreateView(),
        },
        initialRoute: '/loginview',
      );
    }
    else {
      materialApp = MaterialApp(title: "KyTy Miau!",
        routes: {
          '/loginview':(context) => LoginView(),
          '/registerview':(context) => RegisterView(),
          '/homeview2':(context) => HomeView2(),
          '/splashview':(context) => SplashView(),
          '/perfilview':(context) => PerfilView(),
          '/postview':(context) => PostView(),
          '/postcreateview':(context) => PostCreateView(),
        },
        initialRoute: '/homeview2',
      );
    }
    materialApp = MaterialApp(title: "KyTy Miau!",
      routes: {
        '/loginview':(context) => LoginView(),
        '/registerview':(context) => RegisterView(),
        '/homeview':(context) => HomeView(),
        '/splashview':(context) => SplashView(),
        '/perfilview':(context) => PerfilView(),
        '/postview':(context) => PostView(),
        '/postcreateview':(context) => PostCreateView(),
      },
      initialRoute: '/homeview',
    );

    return materialApp;
  }
}