import 'package:Hospital_FastWay/HospitalsScreen/KalubovilaDisplay.dart';
import 'package:Hospital_FastWay/Login/Signnup.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


class LoginPage extends StatefulWidget{
  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage>{
  String _email, _password;
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
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
                labelText: ' Email'
              ),
            ),
            SizedBox(height: 20.0),
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
              onPressed: signIn,
              child: Text('Loging',style: TextStyle(fontSize: 20.0, color: Colors.white)),
            ),
            FlatButton(
              onPressed: navigateToSignUp,
              child: Text('Create an account', style:TextStyle(fontSize: 20.0, fontWeight: FontWeight.w300,color: Colors.red)),
            )
          ],
        )
      )
      );
  }
  Future<void> signIn() async{
    final formState = _formkey.currentState;
    if(formState.validate()){
      formState.save();
      try{
        AuthResult user = await FirebaseAuth.instance.signInWithEmailAndPassword(email: _email, password: _password);
        assert(user != null);
        Navigator.push(context,MaterialPageRoute(builder: (context) => HomeKalubovila(), fullscreenDialog: true));
      }catch (e){
        print(e.message);
      }
    }
  }
  void navigateToSignUp(){
      Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
      }
}