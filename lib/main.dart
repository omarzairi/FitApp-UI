
import 'package:fitapp/Pages/firstPage.dart';
import 'package:fitapp/Pages/login.dart';
import 'package:fitapp/routes/route.dart';

import 'package:fitapp/Pages/homepage/homepage.dart';

import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final storage = const FlutterSecureStorage();

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
              return HomeView();
            } else {
              return FirstPage(); // Replace with your login view
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
