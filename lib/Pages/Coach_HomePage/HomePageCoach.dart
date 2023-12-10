import 'package:fitapp/Pages/Coach_HomePage/drawerCoach.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/round_button.dart';
import '../../utils/theme_colors.dart';

class HomePageCoach extends StatefulWidget {
    const HomePageCoach({Key? key});

    @override
    State<HomePageCoach> createState() => _HomePageCoachState();
}

class _HomePageCoachState extends State<HomePageCoach> {
    @override
    Widget build(BuildContext context) {
        return Scaffold(
            appBar: AppBar(
                title: Text("Coach Home Page"),
            ),
            drawer: HomeDrawerCoach(),
            body: Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                        Text(
                            'Welcome to your home page',
                            style: TextStyle(fontSize: 20),
                        ),
                        SizedBox(height: 20),
                    ],
                ),
            ),
        );
    }
}
