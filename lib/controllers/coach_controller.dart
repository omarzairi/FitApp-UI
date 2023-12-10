import 'package:fitapp/services/coach_service.dart';
import 'package:get/get.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../services/network_service.dart';

class CoachController extends GetxController {
  late Coach coach;
  final storage = const FlutterSecureStorage();
  var isLoading = true.obs;
  var coachesList = <Coach>[].obs;

  @override
  Future<void> onInit() async {

    print("onInit");
    await getAllCoaches(); // Move the initialization here
    super.onInit();
  }
  Future<Coach> addCoach(Map<String, dynamic> coachData) async {
    try {
      var response = await CoachService().createCoach(coachData);
      if (response.statusCode == 200) {
        // Check if 'data' field is present in the response
        if (response.data != null && response.data is Map<String, dynamic>) {
          coach = Coach.fromJson(response.data!);

          storage.write(key: "coachToken", value: response.data['token']);

          return coach;
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
  void searchACoachwithQuery(Map<String, dynamic> query) async
  {
    try{
      isLoading(true);
      var networkservice = NetworkService();
      var response = await networkservice.searchCoaches(query);
      if(response.statusCode ==200)
      {
        var coaches = Coach.fromJsonList(response.data);
        if (coaches != null) {
          coachesList.assignAll(coaches);
          print("from query");
          print(coaches[0].nom);
        }
      }
    }
    catch(error)
    {
      throw Exception(error.toString());
    }
    finally {
      print("is lading false");
      isLoading(false);
    }
  }

  Future<void> updateCoach(String id, Map<String, dynamic> coachData) async {
    try {
      var response = await CoachService().updateCoach(id, coachData);
      if (response.statusCode == 200) {
        coach = response.data;
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Coach getCoach(int index) {
    return coachesList[index];
  }

  Future<void> getAllCoaches() async {
    try {
      isLoading(true);

      var response = await CoachService().getCoaches();
      if (response.statusCode == 200) {
        var coaches = Coach.fromJsonList(response.data);
        if (coaches != null) {
          coachesList.assignAll(coaches);
          print(coachesList);
        }
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
      throw Exception(e.toString());
    } finally {
      isLoading(false);
    }
  }
  Future<void> loginCoach(Map<String, dynamic> coachData) async {
    try {
      CoachController userController = Get.find<CoachController>();
      var response = await CoachService().loginCoach(coachData);
      print(response.data);
      if (response.statusCode == 200) {
        userController.coach= (Coach.fromJson(response.data));
        this.coach = (Coach.fromJson(response.data));
        storage.write(key: "coachToken", value: response.data['token']);
        print(this.coach);
      } else {
        Get.snackbar("Error", "Wrong email or password");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Coach> getCoachById(String id) async {
    try {
      var response = await CoachService().getCoachById(id);
      coach = Coach.fromJson(response.data);
      return coach;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<Coach?> getLoggedCoach() async {
    try {
      print("getLoggedUser");
      var response = await CoachService().getLoggedCoach();
      print(response.data);
      coach = Coach.fromJson(response.data);
      print(coach);
      return coach;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
 Future<void> deleteCoach(String id) async {
    try {
      var response = await CoachService().deleteCoach(id);
      if (response.statusCode == 200) {
        coach = null as Coach;
        await storage.delete(key: 'coachToken');

      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  Future<void> changePassword(String id, Map<String, dynamic> coachData) async {
    try {
      var response = await CoachService().changePassword(id, coachData);
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
