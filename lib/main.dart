import 'package:flutter/material.dart';
import 'package:flutterauth/auth.dart';

//import 'login_page.dart';
import 'auth.dart';

import 'root_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'flutter login demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new RootPage(auth: new Auth())
    );
  }
}