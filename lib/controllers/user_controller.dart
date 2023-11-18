import 'package:fitapp/Pages/homepage/homepage.dart';
import 'package:fitapp/services/user_service.dart';
import 'package:get/get.dart';
import 'package:fitapp/models/User.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Pages/aliment_list.dart';

class UserController extends GetxController {
  User? user;
  final storage = const FlutterSecureStorage();


  @override
  Future<void> onInit() async {

    super.onInit();
    print("onInit");
    await getLoggedUser();
    print("done");
  }

  Future<User?> addUser(Map<String, dynamic> userData) async {
    try {
      var response = await UserService().createUser(userData);
      if (response.statusCode == 200) {
        // Check if 'data' field is present in the response
        if (response.data != null && response.data is Map<String, dynamic>) {
          user = User.fromJson(response.data!);

          storage.write(key: "userToken", value: response.data['token']);

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

  Future<void> updateUser(String id, Map<String, dynamic> userData) async {
    try {
      var response = await UserService().updateUser(id, userData);
      if (response.statusCode == 200) {
        user = response.data;
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> loginUser(Map<String, dynamic> userData) async {
    try {
      UserController userController = Get.find<UserController>();
      var response = await UserService().loginUser(userData);
      if (response.statusCode == 200) {
        userController.user = (User.fromJson(response.data['user']));
        storage.write(key: "userToken", value: response.data['token']);
        print("new logged user"+ userController.user!.nom);
        Get.offAll(HomeView());
      } else {
        Get.snackbar("Error", "Wrong email or password");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<User?> getUserById(String id) async {
    try {
      var response = await UserService().getUserById(id);
      user = User.fromJson(response.data);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<User?> getLoggedUser() async {
    try {
      print("getLoggedUser");
      var response = await UserService().getLoggedUser();
      print(response.data);
      user = User.fromJson(response.data);
      print(user);
      return user;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

}
