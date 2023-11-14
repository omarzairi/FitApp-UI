
import 'package:fitapp/services/user_service.dart' ;
import 'package:get/get.dart';
import 'package:fitapp/models/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Pages/aliment_list.dart';


class UserController extends GetxController{
  late User user;
  final storage=const FlutterSecureStorage() ;


  Future<User> addUser(Map<String, dynamic> userData) async {
    try {
      var response = await UserService().createUser(userData);
      if (response.statusCode == 200) {
        // Check if 'data' field is present in the response
        if (response.data != null && response.data is Map<String, dynamic>) {
          user = User.fromJson(response.data!);

          storage.write(key: "userToken", value: response.data['token'] );

          return user;
        } else {
          Get.snackbar("Error", "Invalid response structure");
          throw Exception("Invalid response structure");
        }
      } else {
        Get.snackbar("Error", response.data['message']);
        print(response.data['message']);
        throw Exception(response.data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void> updateUser(String id,Map<String,dynamic>userData) async {
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
  Future<void> loginUser(Map<String,dynamic>userData) async {
    try{
      var response= await UserService().loginUser(userData);
      if(response.statusCode==200)
        {
          user=(User.fromJson(response.data));

          storage.write(key: "userToken", value: response.data['token'] );
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
