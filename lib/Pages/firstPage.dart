import 'package:flutter/material.dart';
import 'package:fitapp/Pages/login.dart';
import 'package:fitapp/Pages/SignUp.dart';

class FirstPage extends StatelessWidget {
  const FirstPage({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration:const BoxDecoration(
          image: DecorationImage(
            image: NetworkImage("https://previews.123rf.com/images/lightwise/lightwise1808/lightwise180800018/106354793-lifestyle-background-and-healthy-active-fitness-living-with-exercise-and-nutritios-diet-with-3d.jpg"),
            fit: BoxFit.cover,
          )
        ),
        child: Column(
          children: [
            // Top Column
            const Expanded(
              flex: 2,
              child: Column(
                children: [
                  SizedBox(height: 100),
                  Text(
                    'Welcome to FitApp',
                    style: TextStyle(color: Colors.white, fontSize: 40.0,
                    fontWeight: FontWeight.bold),
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
                        style:ButtonStyle(
                          backgroundColor:MaterialStateProperty.all(
                            Colors.green[500]

                          ) ,
                          shape: MaterialStateProperty.all(RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ))
                        ) ,

                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SignUpScreen()),

                          );
                        },
                        child: const Text(
                          'I am new',
                          style: TextStyle(color: Colors.white, fontSize: 20.0,
                          fontWeight: FontWeight.bold),
                        ),

                      ),
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      'Already Have an account?',
                      style: TextStyle(color: Colors.white, fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      height: 50,
                      child: ElevatedButton(
                        style:ButtonStyle(
                            backgroundColor:MaterialStateProperty.all(
                                Colors.white

                            ) ,
                            shape: MaterialStateProperty.all(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ))
                        ) ,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginScreen()),
                          );
                        },
                        child: const Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black, fontSize: 20.0,
                          fontWeight: FontWeight.bold),
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

