//routes file
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/aliment_list.dart';
import '../Pages/firstPage.dart';
import '../Pages/login.dart';
import '../Pages/SignUp.dart';
import '../Pages/signUpStepsUser.dart';


class AppRoutes {
  static final routes = [
    GetPage(name: '/', page: () => FirstPage()),
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/signup', page: () => SignUpScreen()),

    GetPage(name: '/alimentlist', page: () => AlimentListPage(mealType:"breakfast" ,)),
  ];


}
