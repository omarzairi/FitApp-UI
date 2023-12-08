import 'package:fitapp/services/coach_service.dart';
import 'package:get/get.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoachController extends GetxController {
  late Coach coach;
  final storage = const FlutterSecureStorage();

  @override
  Future<void> onInit() async {


    print("onInit");
    // await getLoggedUser();
    print("done");
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

  Future<void> loginCoach(Map<String, dynamic> coachData) async {
    try {
      var response = await CoachService().loginCoach(coachData);
      if (response.statusCode == 200) {
        coach = Coach.fromJson(response.data);

        storage.write(key: "coachToken", value: response.data['token']);
        // Assuming you have a route for the coach's page
        // Adjust the route accordingly based on your app structure
        // Get.offAll(CoachHomePage());
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
}
