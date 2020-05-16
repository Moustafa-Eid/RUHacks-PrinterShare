import 'package:flutter/material.dart';
import 'package:printershare/pages/home.dart';

void main() => runApp(MaterialApp(
  initialRoute: '/',
  routes: {
    '/': (context) => Home(),
  },
));

