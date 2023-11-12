import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import '../utils/theme_colors.dart';
import 'package:fitapp/Pages/aliment_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class LoginScreen extends StatefulWidget {
   LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late String _email;

  late String _password;

  Future<void> sendFormData() async{
    final body=jsonEncode({'email':_email,'password':_password});
    print(body);

    final url = Uri.parse('https://fit-app-api.azurewebsites.net/api/users/loginUser');
    try{
      final response = await http.post(url,
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8',
          },
          body: body
      );
      if(response.statusCode!=200){
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wrong email or password')),
        );

      }
      else{
        final storage = new FlutterSecureStorage();
        await storage.write(key: 'userToken', value: jsonDecode(response.body)['token']);
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlimentListPage(mealType:"breakfast" ,)),

        );
      }
      print(response.body);
    }
    catch(e){
      print(e);
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
        title: Text("Sign in",
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
          child: Column(




            children: <Widget>[

              const SizedBox(height: 50),
              const Text(
                'Welcome to FitApp',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Please login to your account',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: 300,
                child: TextField(
                  onChanged: (value) {
                    setState(() {
                      _email = value;
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
                  obscureText: true,
                  onChanged: (value) {
                    setState(() {
                      _password = value;
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Password',
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
                    'Login',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Forgot Password?',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

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
    );
  }
}
