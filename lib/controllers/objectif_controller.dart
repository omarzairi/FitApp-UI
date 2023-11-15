import 'package:dio/dio.dart';
import 'package:fitapp/models/Objectif.dart';
import 'package:fitapp/services/objectif_service.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../Pages/aliment_list.dart';
class ObjectifController extends GetxController{

  final storage=const FlutterSecureStorage() ;
  late Objectif objectif;

  Future<void> addObjectif(Map<String, dynamic> objectifData) async {
    try {
      var response = await ObjectifService().addObjectif(objectifData);

      if (response.statusCode == 200) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          objectif = Objectif.fromJson(response.data!);

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

  Future<Objectif> getObjectiveByUserId(String id) async {
    try {
      var response = await ObjectifService().getObjectiveByUserId(id);
      print(response);
      objectif = Objectif.fromJson(response.data!);
      return objectif;
    } catch (e) {
      print('Error fetching objective: $e');
      // Add more detailed error handling based on the DioError type
      if (e is DioError) {
        print('DioError details: ${e.response?.data}');
      }
      throw Exception('Error fetching objective');
    }
  }

}
