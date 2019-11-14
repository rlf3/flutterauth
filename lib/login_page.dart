
import 'package:flutter/material.dart';
import 'auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({this.auth, this.onSignedIn});
  final BaseAuth auth;
  final VoidCallback onSignedIn;
  @override
  State<StatefulWidget> createState() => new _LoginPageState();
  }

enum FormType{
  login,
  register
}
class _LoginPageState extends State<LoginPage>{

  final formKey = new GlobalKey<FormState>();

  String _email;
  String _password;
  FormType _formType = FormType.login;

  bool validateAndSave(){
    final form = formKey.currentState;
    if (form.validate()) {
      form.save(); 
      //print('Form is valid. Email: $_email, password: $_password');
      return true;
    } 
      return false;
      //print('Form is invalid. Email: $_email, password: $_password');
    
  }

void validateAndSubmit() async {
  if (validateAndSave()) {
    try{
      //FirebaseUser user = await FirebaseAuth.instance.signInWithEmailAndPassword(emai: _email, password: _password);

      if (_formType == FormType.login) {
        
        String userId = await widget.auth.signInWithEmailAndPassword(_email, _password);

          //FirebaseUser user = (await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password)).user;

          //print('Sing in: ${user.uid}');
          print('Sing in: $userId');
            
      } else {
        //FirebaseUser user = (await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password)).user;
        //print('Registered user: ${user.uid}');
        String userId = await widget.auth.createUserWithEmailAndPassword(_email, _password);
        print('Registered user: $userId');
      }
      widget.onSignedIn();
    } 
    catch (e){
      print('error: $e');
    }
  }
}

void moveToRegister(){
  formKey.currentState.reset();
  setState(() {
      _formType = FormType.register;
  });

}

void moveToLogin(){
  formKey.currentState.reset();
  setState(() {
      _formType = FormType.login;
  });

}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: new Text('Flutter login demo'),
        ),
        body: new Container(
          padding: EdgeInsets.all(16.0),
          child: new Form(
            key: formKey,
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: buildInputs() + buildSubmitButtons(),
            ),
          ),
        ),
    );
  }


  List<Widget> buildInputs(){
    return[
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'Email'),
                  validator: (value) => value.isEmpty ? 'Email can\' be empty': null,
                  onSaved: (value) => _email = value,
                ),
                new TextFormField(
                  decoration: new InputDecoration(labelText: 'password'),
                  obscureText: true,
                  validator: (value) => value.isEmpty ? 'Password can\' be empty': null,
                  onSaved: (value) => _password = value,
                ),
    ];
  }

  List<Widget> buildSubmitButtons() {
    if (_formType == FormType.login) {
      return[
        new RaisedButton(
                    child: new Text('Login', style: new TextStyle(fontSize: 20.0)),
                    onPressed: validateAndSubmit,
                  ),
                  new FlatButton(
                    child: new Text('Create an account', style: new TextStyle(fontSize: 20.0),),
                    onPressed: moveToRegister,
                  )
      ];      
    } else {
      return[
      new RaisedButton(
                  child: new Text('Create an account', style: new TextStyle(fontSize: 20.0)),
                  onPressed: validateAndSubmit,
                ),
                new FlatButton(
                  child: new Text('Have you an account? Login', style: new TextStyle(fontSize: 20.0),),
                  onPressed: moveToLogin,
                )
      ];
    }

  }

}