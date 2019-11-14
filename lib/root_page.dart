import 'package:flutter/material.dart';
import 'package:flutterauth/auth_provider.dart';
import 'login_page.dart';

import 'home_page.dart';
import 'auth_provider.dart';

class RootPage extends StatefulWidget {
  // final BaseAuth auth;
  // RootPage({this.auth});

  @override
    State<StatefulWidget> createState() => new _RootPageState();
}

enum AuthStatus{
  notSignedIn,
  signedIn
}

class _RootPageState extends State<RootPage> {
  AuthStatus authStatus = AuthStatus.signedIn;
  
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    var auth = AuthProvider.of(context).auth;
    auth.currentUser().then((userId){
      setState((){
        authStatus = userId == null ? AuthStatus.notSignedIn : AuthStatus.signedIn;
      });
    });
    
  }

/*   initState(){
    super.initState();

  } */

  void _signedIn(){
    setState(() {
     authStatus = AuthStatus.signedIn;
    });
  }

  void _signedOut(){
      setState(() {
     authStatus = AuthStatus.notSignedIn;
    });
  }

  @override
  Widget build(BuildContext context) {
    switch(authStatus){
      case AuthStatus.notSignedIn:
        return new LoginPage(
          //auth: widget.auth,
          onSignedIn: _signedIn,);
          
      case AuthStatus.signedIn:
        return new Homepage(
          //auth: widget.auth,
          onSignedOut: _signedOut,

        );

    }

  }
}

