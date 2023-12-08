import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/img/logo.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: null,
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text('Dashboard'),
            onTap: () {
              Get.toNamed("/home");
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: const Text('Profile'),
            onTap: () {
              Get.toNamed("/profile");
            },
          ),
          ListTile(
            leading: Icon(Icons.fastfood),
            title: const Text('Personalized Meal'),
            onTap: () {
              Get.toNamed("/personalizedmeal");
            },
          ),
          ListTile(
            leading: Icon(Icons.event_repeat),
            title: const Text('Consumption'),
            onTap: () {
              Get.toNamed("/alimentlist");
            },
          ),
          ListTile(
            leading: Icon(Icons.chat),
            title: const Text('Chat Room'),
            onTap: () {
              Get.toNamed("/chat");
            },
          )
        ],
      ),
    );
  }
}
