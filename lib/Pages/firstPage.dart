import 'package:flutter/material.dart';
import 'package:fitapp/Pages/login.dart';
import 'package:fitapp/Pages/SignUp.dart';
import 'package:fitapp/utils/theme_colors.dart';




class FirstPage extends StatefulWidget {
  FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {





  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container


        (

        decoration:
        BoxDecoration(
          image:DecorationImage(
            image: AssetImage("assets/img/baccc.png")
                ,

            fit: BoxFit.contain,
          ),

        ),

        child: Column(
          children: [



            // Top Column
            Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(height: 70),
                  Text(
                    'Welcome to FitApp',
                    style: TextStyle(
                      color:
                        Color.fromRGBO(208, 162, 247,1),
                      fontSize: 40.0,
                      fontWeight: FontWeight.bold,

                    ),
                    textAlign: TextAlign.center,
                  ),

                ],
              ),
            ),


            // Bottom Column
            Expanded(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                          MaterialStateProperty.all(Color.fromRGBO(208, 162, 247,1)),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignUpScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'I am new',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Already Have an account?',
                      style: TextStyle(
                        color:  Color.fromRGBO(208, 162, 247,1),
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.white),
                          shape: MaterialStateProperty.all(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 20.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
