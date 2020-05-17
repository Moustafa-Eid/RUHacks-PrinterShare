import 'package:flutter/material.dart';
import 'package:printershare/pages/home.dart';
import 'package:printershare/pages/signIn.dart';



void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => SignIn(),
        '/home': (context) => Home(),
      },
    );
  }
}