import 'package:fitapp/Pages/aliment_list.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';

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
        primarySwatch: secondaryColor1Swatch,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: TextTheme(
          bodyText2: TextStyle(fontFamily: 'Poppins', fontSize: 18),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf1f6f9),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'FitApp',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 50,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Track your meals and workouts',
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: TColor.secondaryColor1,

        onPressed: () {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AlimentListPage(mealType: 'Breakfast')),
            );
          });
        },
        child: Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
