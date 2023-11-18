//routes file
import 'package:fitapp/Pages/conversation_list.dart';
import 'package:fitapp/Pages/homepage/homepage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/aliment_list.dart';
import '../Pages/firstPage.dart';
import '../Pages/login.dart';
import '../Pages/SignUp.dart';
import '../Pages/signUpStepsUser.dart';
import '../Pages/user_profile.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => FirstPage()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/chat', page: ()=>ConversationList()),
    // GetPage(name: '/home', page: ()=>HomeView()),
    GetPage(name: '/alimentlist', page: () => AlimentListPage()),
    GetPage(name: '/profile', page: () => ProfileUser()),
  ];


}
