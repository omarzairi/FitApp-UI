import 'dart:convert';

import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  late String _email;
  late String _password;
  late String _confirmPassword;

  Future<void> sendFormData()async {
    if(_password != _confirmPassword){
      print("Password and confirm password are not the same");

    }
    else{
      final body=jsonEncode({'email':_email,'password':_password});
      print(body);
    }

  }
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: const IconThemeData(color: Colors.black)
      ),
      body: SingleChildScrollView(

        child: SizedBox(
          width: double.maxFinite,

          child: Column(

            children: <Widget>[

             const SizedBox(height: 50),
             const  Text(
                'Welcome to FitApp',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const  SizedBox(height: 20),
             const  Text(
                'Create an account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
             const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _email =value;
                    });

                  },
                  decoration: InputDecoration(
                    hintText: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
             const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _password =value;
                    });

                  },
                  obscureText: true,
                  decoration: InputDecoration(

                    hintText: 'Password',
                    prefixIcon:const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value){
                    setState(() {
                      _confirmPassword =value;
                    });

                  },
                  obscureText: true,
                  decoration: InputDecoration(
                    hintText: 'Confirm password',
                    prefixIcon: const Icon(Icons.lock),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                height: 50,
                child: ElevatedButton(
                  onPressed: () async {
                    await sendFormData();
                  },

                  child: const Text(
                    'Sign up',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),



              const SizedBox(height: 20),
              const Text(
                'Or',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Container(

                height: 50,
                foregroundDecoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),


                child: Image.network('https://www.drupal.org/files/issues/2020-01-26/google_logo.png'),
              ),


            ],
          ),
        ),
      ),
    );
  }
}
