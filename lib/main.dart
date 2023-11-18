
import 'package:fitapp/Pages/SignUp.dart';
import 'package:fitapp/Pages/firstPage.dart';
import 'package:fitapp/Pages/login.dart';
import 'package:fitapp/controllers/objectif_controller.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/routes/route.dart';

import 'package:fitapp/Pages/homepage/homepage.dart';

import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fitapp/Pages/user_Profile/user_profile.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/Pages/user_Profile/change_name.dart';
import 'package:fitapp/Pages/user_Profile/change_password.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController());
  Get.put(ObjectifController());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = const FlutterSecureStorage();
  final userController = Get.put(UserController());


  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: '/',
      getPages: AppRoutes.routes,
      debugShowCheckedModeBanner: false,
      title: 'FitApp',
      theme: ThemeData(
        primarySwatch: secondaryColor1Swatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        scaffoldBackgroundColor: Colors.white,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'Poppins', fontSize: 18),
        ),

      ),
      home: FutureBuilder<String?>(
        future: storage.read(key: 'userToken'),
        builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator(); // Show a loading spinner while waiting
          } else {
            if (snapshot.data != null) {
              return SignUpScreen();
            } else {
              return ProfileUser(); // Replace with your login view
            }
          }
        },
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage();
    // return Scaffold(
    //
    //
    //   //body: AlimentDetails()
    //
    //   backgroundColor: Color(0xFFf1f6f9),
    //   body: Center(
    //     child: Column(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: <Widget>[
    //         Text(
    //           'FitApp',
    //           style: TextStyle(
    //             fontFamily: 'Montserrat',
    //             fontSize: 50,
    //             fontWeight: FontWeight.bold,
    //           ),
    //         ),
    //         SizedBox(height: 20),
    //         Text(
    //           'Track your meals and workouts',
    //           style: TextStyle(
    //             fontFamily: 'Montserrat',
    //             fontSize: 18,
    //           ),
    //         ),
    //       ],
    //     ),
    //   ),
    //   floatingActionButton: FloatingActionButton(
    //     backgroundColor: TColor.secondaryColor1,
    //
    //     onPressed: () {
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         Navigator.push(
    //           context,
    //           MaterialPageRoute(
    //               builder: (context) => AlimentListPage(mealType: 'Breakfast')),
    //         );
    //       });
    //     },
    //     child: Icon(Icons.add, color: Colors.white),
    //   ),
    // );
  }
}
