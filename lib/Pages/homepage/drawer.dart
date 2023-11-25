import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration:  BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0)),
              color: TColor.primaryColor2,
            ),
            child: Image.asset(
                "assets/img/bg_dots.png"),
          ),
          ListTile(
            title:  Text('Dashboard'),
            onTap: () {Get.toNamed("/home");},
          ),
          ListTile(
            title: const Text('Consumption'),
            onTap: () {Get.toNamed("/alimentlist");},
          ),
          ListTile(
            title: const Text('Chat Room'),
            onTap: () {Get.toNamed("/chat");},
          )
        ],
      ),
    );
  }

}