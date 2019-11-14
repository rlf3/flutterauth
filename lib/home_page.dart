import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

import 'package:flutterauth/auth_provider.dart';

class Homepage extends StatelessWidget {
  Homepage({
    //this.auth, 
    this.onSignedOut});
  //final BaseAuth auth;
  final VoidCallback onSignedOut;
  
  void _signOut(BuildContext context) async {
    try {
      var auth = AuthProvider.of(context).auth;
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
            onPressed: () => _signOut(context),
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

