

import 'package:get/get.dart';
import 'package:fitapp/services/progressService.dart';


import '../models/Progress.dart';


class ProgressController extends GetxController {

  late ProgressWeight progress;

  Future<void> addProgress(Map<String, dynamic> progressData) async {
    try {
      print(progressData);
      ProgressController progressController = Get.find<ProgressController>();
      var response = await ProgressService().createProgress(progressData);

      if (response.statusCode == 200) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          print("response addProgress : ${response.data}");
          progressController.progress = ProgressWeight.fromJson(response.data!);
        } else {
          Get.snackbar("Error", "Invalid response structure");
          throw Exception("Invalid response structure");
        }
      } else {
        Get.snackbar("Error", "Failed to add progress. Status code: ${response.statusCode}");
        print("Failed to add progress. Status code: ${response.statusCode}");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred: $e");
      print('Error: $e');
      throw Exception(e.toString());
    }
  }


  Future<ProgressWeight?> getProgressByUserId(String id) async {
    try {

      var response = await ProgressService().getProgressByUserId(id);
      progress = ProgressWeight.fromJson(response.data!);
      return progress;
    } catch (e) {
      print('Error fetching progress: $e');

      throw Exception('Error fetching progress');
    }
  }

  Future<void> addProgressToAUser(String id, Map<String, dynamic> progressData) async {
    try {
      ProgressController progressController = Get.find<ProgressController>();
      var response = await ProgressService().addProgressToAUser(id, progressData);
      if (response.statusCode == 200) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          progressController.progress = ProgressWeight.fromJson(response.data!);
        } else {
          Get.snackbar("Error", "Invalid response structure");
          throw Exception("Invalid response structure");
        }
      } else {
        Get.snackbar("Error", response.data['message']);
      }
    } catch (e) {
      print('Error: $e');
      throw Exception(e.toString());
    }
  }
}
