import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fitapp/Pages/signUpStepsUser.dart';

import '../utils/theme_colors.dart';

class SignUpScreen extends StatefulWidget {
   SignUpScreen({super.key});


  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {



  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmpasswordController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();


  Future<void> sendFormData()async {
    if(passwordController.text!=confirmpasswordController.text){
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Passwords do not match')),
      );
      return;
    }else {
      if(_formKey.currentState!.validate()) {

        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) =>
              UserStepperForm(email: emailController.text,
                password: passwordController.text,)),
        );
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid email or password'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: TColor.black,
              size: 20,
            ),
          ),
        ),
        title: Text("Sign up",
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),

      ),
      body: SingleChildScrollView(

        child: SizedBox(
          width: double.maxFinite,

          child: Form(
            key: _formKey,
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
                  child: TextFormField(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email address';
                      }

                      // Email validation using a regular expression
                      final emailRegex = RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                      if (!emailRegex.hasMatch(value)) {
                        return 'Please enter a valid email address';
                      }

                      return null; // Return null if the email is valid
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
                  child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    controller: passwordController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please enter your password';
                      }
                      if(value.length<8){
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
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
                  child: TextFormField(
                    autovalidateMode:AutovalidateMode.onUserInteraction,
                    controller: confirmpasswordController,
                    validator: (value){
                      if(value==null || value.isEmpty){
                        return 'Please enter your password';
                      }
                      if(value.length<8){
                        return 'Password must be at least 8 characters long';
                      }
                      return null;
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


                  child: Image.asset('assets/img/google_logo.png'),
                ),


              ],
            ),
          ),
        ),
      ),
    );
  }
}
