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
import '../Pages/user_Profile/user_profile.dart';
import '../Pages/user_Profile/change_name.dart';
import '../Pages/user_Profile/change_mail.dart';
import '../Pages/user_Profile/change_password.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => FirstPage()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/chat', page: ()=>const ConversationList()),
    GetPage(name: '/home', page: ()=>const HomeView()),
    GetPage(name: '/alimentlist', page: () => AlimentListPage()),
    GetPage(name: '/profile', page: () => const ProfileUser()),
    GetPage(name:'/changeusername', page: ()=>const ChangeName()),
    GetPage(name:'/changemail', page: ()=>const ChangeMail()),
    GetPage(name:'/changepassword', page: ()=>const ChangePassword()),

  ];


}
