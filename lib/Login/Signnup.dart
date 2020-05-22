import 'package:Hospital_FastWay/Login/Signin.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  @override
  _SignUpState createState() => new _SignUpState();
}

class _SignUpState extends State<SignUp>{
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  String _email , _password;
  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:Form(
        key: _formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Align(alignment: Alignment.centerLeft, child:Text(" Email",style: TextStyle(fontSize: 20.0))),
            TextFormField(
              validator: (input){
                assert(input != null);
                if(input.isEmpty){
                  return 'please type an email';
                }
              },
              onSaved: (input) => _email = input,
              decoration: InputDecoration(
                labelText: ' Email',
              ),
            ),
            SizedBox(height: 30.0,),
            Align(alignment: Alignment.centerLeft, child:Text(" Password",style: TextStyle(fontSize: 20.0))),
            TextFormField(
              validator: (input){
                if(input.length<8){
                  return 'need to be 8 characters';
                }
              },
              onSaved: (input) => _password = input,
              decoration: InputDecoration(
                labelText: ' password'
              ),
              obscureText: true,
            ),
            SizedBox(height: 15.0),
            RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              color: Colors.blue,
              onPressed: signUp,
              child: Text('Sign up', style: TextStyle(fontSize: 20.0, color: Colors.white)),
            )
          ],
        )
      )
      );
  }
  void signUp() async{
    if(_formkey.currentState.validate()){
      _formkey.currentState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: _email, password: _password);
        assert(user != null);
        Navigator.of(context).pop();
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => LoginPage(),fullscreenDialog: true));
      }catch (e){
        print(e.message);
      }
    }
  }
}