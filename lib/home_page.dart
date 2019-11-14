import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutterauth/auth.dart';

class Homepage extends StatelessWidget {
  Homepage({this.auth, this.onSignedOut});
  final BaseAuth auth;
  final VoidCallback onSignedOut;
  
  void _signOut() async {
    try {
      await auth.signedOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }
  
  @override
  
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('Welcome bar'),
        actions: <Widget>[
          new FlatButton(
            child: new Text('Logout', style: new TextStyle(fontSize: 17.0, color: Colors.white),),
            onPressed: _signOut,
          )
        ],
      ),
      body: new Container(
        child: new Center(
          child: new Text('Welcome center', style: new TextStyle(fontSize: 20.0)),
        ),
      ),
    );
  }
}

