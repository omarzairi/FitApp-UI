import 'package:fitapp/Pages/LoginCoach.dart';
import 'package:fitapp/Pages/SignUpCoach.dart';
import 'package:fitapp/Pages/coachesList.dart';
import 'package:fitapp/Pages/conversation_list.dart';
import 'package:fitapp/Pages/homepage/homepage.dart';
import 'package:fitapp/Pages/progressPage/progress_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/aliment_list.dart';
import '../Pages/coach/coachListMessages.dart';
import '../Pages/coachConversation_list.dart';
import '../Pages/firstPage.dart';
import '../Pages/login.dart';
import '../Pages/SignUp.dart';
import '../Pages/personalized_meals/personalized_meal.dart';
import '../Pages/signUpStepsUser.dart';
import '../Pages/user_Profile/user_profile.dart';
import '../Pages/user_Profile/change_name.dart';
import '../Pages/user_Profile/change_mail.dart';
import '../Pages/user_Profile/change_password.dart';
import '../Pages/user_Profile/target_weight.dart';
import '../Pages/user_Profile/current_weight.dart';
import '../Pages/Coach_Profile/description.dart';
import '../Pages/Coach_Profile/change_mailCoach.dart';
import '../Pages/Coach_Profile/change_passwordCoach.dart';
import '../Pages/Coach_Profile/change_nameCoach.dart';
import '../Pages/Coach_Profile/change_phoneNumberCoach.dart';
import '../Pages/Coach_Profile/change_priceCoach.dart';
import '../Pages/Coach_Profile/Coach_profile.dart';
import '../Pages/Coach_HomePage/HomePageCoach.dart';



class AppRoutes {
static final routes = [
GetPage(name: '/', page: () => FirstPage()),
GetPage(name: '/login', page: () => const LoginScreen()),
GetPage(name: '/signup', page: () => SignUpScreen()),
GetPage(name: '/chat', page: ()=>const ConversationList()),
GetPage(name:'/chatCoach', page: ()=>const CoachConversationList()),
GetPage(name: '/home', page: ()=>const HomeView()),
GetPage(name: '/alimentlist', page: () => AlimentListPage()),
GetPage(name: '/coachlist', page: () => CoachesListPage()),
GetPage(name: '/signupCoach', page: () => CoachSignUpScreen()),
GetPage(name: '/loginCoach', page: () =>LoginCoachScreen()),
GetPage(name: '/profile', page: () => ProfileUser()),
GetPage(name:'/changeusername', page: ()=>ChangeName()),
GetPage(name:'/changemail', page: ()=>ChangeMail()),
GetPage(name:'/changepassword', page: ()=>ChangePassword()),
GetPage(name:'/ProfileCoach',page: ()=>ProfileCoach()),
GetPage(name: "/changeEmailCoach", page: ()=>ChangeMailCoach())  ,
GetPage(name: "/changePasswordCoach", page: ()=>ChangePasswordCoach())  ,
GetPage(name: "/changeNameCoach", page: ()=>ChangeNameCoach())  ,
GetPage(name: "/changePhoneNumberCoach", page: ()=>ChangePhoneNumber())  ,
GetPage(name: "/changePriceCoach", page: ()=>ChangePriceCoach())  ,
GetPage(name: "/descriptionCoach", page: ()=>ChangeDescription())  ,
GetPage(name: "/HomePageCoach", page: ()=>HomePageCoach())  ,


GetPage(name:'/targetweight', page: ()=>const TargetWeight()),
GetPage(name:'/currentweight', page: ()=>const CurrentWeight()),
  GetPage(name: '/progress', page: () => const ProgressChart(),),



  GetPage(name: '/personalizedmeal', page: () => PersonalizedMealScreen()),

];


}
