import 'package:flutter/material.dart';
import 'package:flutterauth/services/auth_provider.dart';
import 'package:flutterauth/services/auth.dart';

class HomePage extends StatelessWidget {
  const HomePage({this.onSignedOut});
  final VoidCallback onSignedOut;

  Future<void> _signOut(BuildContext context) async {
    try {
      final BaseAuth auth = AuthProvider.of(context).auth;
      await auth.signOut();
      onSignedOut();
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome'),
        actions: <Widget>[
          FlatButton(
            child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.white)),
            onPressed: () => _signOut(context),
          ),



          PopupMenuButton(
            itemBuilder: (BuildContext context){
              return [
                PopupMenuItem(
                  child: FlatButton(
                          child: Text('Logout', style: TextStyle(fontSize: 17.0, color: Colors.black)),
                          onPressed: () => _signOut(context),
                          ),
                ),
                
              ];
            },
          ),






        ],
      ),
      body: Container(
        child: Center(child: Text('Welcome', style: TextStyle(fontSize: 32.0))),
      ),
    );
  }
}
