import 'package:fitapp/Pages/LoginCoach.dart';
import 'package:fitapp/Pages/SignUpCoach.dart';
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
import '../Pages/user_Profile/target_weight.dart';
import '../Pages/user_Profile/current_weight.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => FirstPage()),
    GetPage(name: '/login', page: () => const LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),
    GetPage(name: '/chat', page: ()=>const ConversationList()),
    GetPage(name: '/home', page: ()=>const HomeView()),
    GetPage(name: '/alimentlist', page: () => AlimentListPage()),

    GetPage(name: '/signupCoach', page: () => CoachSignUpScreen()),
    GetPage(name: '/loginCoach', page: () =>LoginCoachScreen()),
    GetPage(name: '/profile', page: () => ProfileUser()),
    GetPage(name:'/changeusername', page: ()=>ChangeName()),
    GetPage(name:'/changemail', page: ()=>ChangeMail()),
    GetPage(name:'/changepassword', page: ()=>ChangePassword()),

    GetPage(name:'/targetweight', page: ()=>const TargetWeight()),
    GetPage(name:'/currentweight', page: ()=>const CurrentWeight()),


  ];


}