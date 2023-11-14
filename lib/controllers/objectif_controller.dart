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
          Get.snackbar("Done", "Objectif created");
          Get.offAll(const AlimentListPage(mealType: "breakfast"));
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
