import 'package:fitapp/Pages/homepage/tabButton.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/theme_colors.dart';

class Footer extends StatefulWidget{

  @override
  State<Footer> createState() => _MainTabViewState();
}

class _MainTabViewState extends State<Footer> {
  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
          child: Container(
            decoration: BoxDecoration(color: TColor.white, boxShadow: const [
              BoxShadow(color: Colors.black12, blurRadius: 2, offset: Offset(0, -2))
            ]),
            height: kToolbarHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                TabButton(
                    icon: "assets/img/home_tab.png",
                    selectIcon: "assets/img/home_tab_select.png",
                    isActive: selectTab == 0,
                    onTap: () {
                      selectTab = 0;
                      Navigator.pushNamed(context, '/home');
                    }),
                TabButton(
                    icon: "assets/img/activity_tab.png",
                    selectIcon: "assets/img/activity_tab_select.png",
                    isActive: selectTab == 1,
                    onTap: () {
                      selectTab = 1;
                      Navigator.pushNamed(context, '/chat');
                    }),

                const  SizedBox(width: 40,),
                TabButton(
                    icon: "assets/img/camera_tab.png",
                    selectIcon: "assets/img/camera_tab_select.png",
                    isActive: selectTab == 2,
                    onTap: () {
                      selectTab = 2;
                    }),
                TabButton(
                    icon: "assets/img/profile_tab.png",
                    selectIcon: "assets/img/profile_tab_select.png",
                    isActive: selectTab == 3,
                    onTap: () {
                      selectTab = 3;
                      Navigator.pushNamed(context, '/login');
                    })
              ],
            ),
          ),
    );
  }





}