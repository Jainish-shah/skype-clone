import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:skpye_clone/resources/firebase_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shimmer/shimmer.dart';
import 'package:skpye_clone/utils/universal_variables.dart';
import 'home_screen.dart';

class LoginScreen extends StatefulWidget {
  @override
  LoginScreenState createState() => LoginScreenState();
}

class LoginScreenState extends State<LoginScreen> {
  
  FirebaseRepository _repository = FirebaseRepository();
  
  bool isLoginPressed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: UniversalVariables.blackColor,
      body: Stack(
        children: [
          Center(
            child: loginButton()
          ),
          isLoginPressed ? 
            Center(
              child: CircularProgressIndicator(),
          )
          :Container()
        ],
      ),
    );
  }

//===>USE BELOW CODE FOR GRADIENT STYLE OF LOGIN BUTTON
  // Widget loginButton() {
  //   return FlatButton(
  //       shape: RoundedRectangleBorder(
  //         borderRadius: BorderRadius.circular(60),
  //       ),
  //       //padding: 0.0, 
  //       //elevation: 10,
  //       splashColor: Colors.lightBlue[100],
  //       child: Ink(
  //         decoration: new BoxDecoration(
  //           borderRadius: BorderRadius.circular(60),
  //           gradient: new LinearGradient(
  //             colors: [Colors.red[500],Colors.orange[300]],
  //             begin: Alignment.topLeft,
  //             end: Alignment.bottomRight,
  //           ),
  //         ),
  //       padding: EdgeInsets.symmetric(horizontal: 40,vertical: 20),
  //       child: Text(
  //         "LOGIN",
  //         style: TextStyle(
  //           fontSize: 35,
  //           color: Colors.white,
  //           fontWeight: FontWeight.w900,
  //           letterSpacing: 1.2 
  //         )
  //       ),
  //       ),
  //       onPressed: ()=>performLogin(),
  //     );
  //   }

  Widget loginButton() {
    return Shimmer.fromColors(
      baseColor: Colors.white,
      highlightColor: UniversalVariables.senderColor,
      child: FlatButton(
        padding: EdgeInsets.all(35),
        child: Text(
          "LOGIN",
          style: TextStyle(
              fontSize: 35, fontWeight: FontWeight.w900, letterSpacing: 1.2),
        ),
        onPressed: () => performLogin(),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }

  void performLogin() {
    print('trying to perform login');

    setState(() {
      isLoginPressed=true;
    });

    _repository.signIn().then((FirebaseUser user){
      if(user != null){
        authenticateUser(user);
      }
      else{
        print("There was an error");
      }
    });
  }

  void authenticateUser(FirebaseUser user){
    _repository.authenticateUser(user).then((isNewUser){
      setState(() {
        isLoginPressed = false;
      });

      if(isNewUser){
        _repository.addDataToDb(user).then((value){
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context){
            return HomeScreen();    
            }));
        });
      }
      else  
      {
        Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (context){
          return HomeScreen();    
        }));
      }
    });
  }
}