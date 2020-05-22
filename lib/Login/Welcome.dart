import 'package:Hospital_FastWay/Login/Signin.dart';
import 'package:Hospital_FastWay/Login/Signnup.dart';
import 'package:flutter/material.dart';

class WelcomeaPage extends StatefulWidget{
  @override
  _WelcomeaPageState createState() => new _WelcomeaPageState();
}

class _WelcomeaPageState extends State<WelcomeaPage>{
  @override 
   Widget build(BuildContext context){
     return Scaffold(
       appBar: AppBar(
         title:Align(alignment: Alignment.center, child:Text("Fast_Way",style: TextStyle(fontSize: 30.0))),
       ),
       body: Column(
         mainAxisAlignment: MainAxisAlignment.center,
         crossAxisAlignment: CrossAxisAlignment.stretch,
         children: <Widget>[
           Hero(
            tag: 'hero',
            child: Padding(
            padding: EdgeInsets.only(left: 16.0, right: 16.0, bottom: 60.0,top: 1.0),
          child: CircleAvatar(
             backgroundColor: Colors.transparent,
             radius: 125.0,
             child: Image.asset('assets/logo.png'),
        ),
      ),
    ),
           RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              color: Colors.blue[800],
             onPressed: navigateToSignIn,
             child: Text('Login', style: TextStyle(fontSize: 20.0, color: Colors.white)),
           ),
           RaisedButton(
                elevation: 5.0,
                shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30.0)),
              color: Colors.blue[400],
             onPressed: navigateToSignUp,
             child: Text('Create an account', style: TextStyle(fontSize: 20.0, color: Colors.white)),
           )
         ],
        ),
     );
   }
   void navigateToSignIn(){
     Navigator.push(context,MaterialPageRoute(builder: (context) => LoginPage(), fullscreenDialog: true));
   }
   void navigateToSignUp(){
      Navigator.push(context,MaterialPageRoute(builder: (context) => SignUp()));
   }
   }