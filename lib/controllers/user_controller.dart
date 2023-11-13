import 'dart:collection';

import 'package:fitapp/services/user_service.dart' ;
import 'package:get/get.dart';
import 'package:fitapp/models/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Pages/aliment_list.dart';
import '../Pages/signUpStepsUser.dart';

class UserController extends GetxController{
  late User user;
  final storage=const FlutterSecureStorage() ;

  Future<void> addUser(userData) async {
    try{
      var response= await UserService().createUser(userData);
      if(response.statusCode==200)
        {
          user=response.data;
          // Get.offAll( UserStepperForm(usermap: HashMap,));

        }
      else{
        Get.snackbar("Error", response.data['message'] );
      }

    }
    catch(e){
      throw Exception(e.toString());
    }

  }
  Future<void> updateUser(String id,userData) async {
    try{
      var response= await UserService().updateUser(id,userData);
      if(response.statusCode==200)
      {
        user=response.data;


      }
      else{
        Get.snackbar("Error", response.data['message'] );
      }


    }
    catch(e){
      throw Exception(e.toString());
    }

  }
  Future<void> loginUser(userData) async {
    try{
      var response= await UserService().loginUser(userData);
      if(response.statusCode==200)
        {
          user=response.data;
          Get.offAll(const AlimentListPage(mealType:"breakfast" ,));

        }
      else{
        Get.snackbar("Error", "Wrong email or password");
      }



    }
    catch(e){
      throw Exception(e.toString());
    }

  }
  Future<void> getUserById(String id) async {
    try{
      var response= await UserService().getUserById(id);
      user=response.data;

    }
    catch(e){
      throw Exception(e.toString());
    }

  }










}
