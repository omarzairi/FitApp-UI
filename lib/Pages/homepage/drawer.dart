import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomeDrawer extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(0)),
              color: Color(0xffFB7AFF),
            ),
            child: Image.asset(
                "assets/img/bg_dots.png"),
          ),
          ListTile(
            title: const Text('Dashboard'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Consumption'),
            onTap: () {},
          ),
          ListTile(
            title: const Text('Chat Room'),
            onTap: () {

            },
          )
        ],
      ),
    );
  }

}