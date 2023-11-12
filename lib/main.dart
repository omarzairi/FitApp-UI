import 'package:flutter/material.dart';
import 'package:fitapp/Pages/signUpSteps.dart';
import 'package:fitapp/Pages/login.dart';
import 'package:fitapp/Pages/SignUp.dart';
import 'package:fitapp/Pages/firstPage.dart';
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FitApp',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'Montserrat', fontSize: 18),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return  SignUpScreen();
      // appBar: AppBar(
      //   title: Text('FitApp Home Page'),
      // ),


  }
}
