import 'package:fitapp/models/Consumption.dart';
import 'package:fitapp/services/consumption_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/ConsumptionFacts.dart';

class ConsumptionController extends GetxController {
  final storage = const FlutterSecureStorage();

  ConsumptionFact? consumptionFact;

  List<dynamic>? consumption;

  @override
  Future<void> onInit() async {
    super.onInit();
    print("onInit Consumption");
  }

  Future<void> getConsumptionsByDate(Map<String, dynamic> consumptionData) async
  {
    try {
      var response = await ConsumptionService().getConsumptionsForUserByDate(
          consumptionData);
      if (response.statusCode == 200) {
        if (response.data != null) {
          consumption = response.data;
          print(response);
        }
        else {
          throw Exception("Error : not found!");
        }
      }
    }
    catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<ConsumptionFact?> getFacts(String user,
      Map<String, dynamic> datastuff) async {
    try {
      var response = await ConsumptionService().getNutritionFactsToday(
          user, datastuff);
      print(datastuff);
      if (response.statusCode == 200) {
        if (response.data != null) {
          consumptionFact = ConsumptionFact.fromJson(response.data!);
          print(response);
          return consumptionFact;
        }
        else {
          Get.snackbar("Error", "Invalid response structure");
          throw Exception("Invalid response structure");
        }
      }
      else {
        Get.snackbar("Error", response.data['message']);
        throw Exception("error why");
      }
    }
    catch (e) {
      throw Exception(e.toString());
    }
  }

  //return the consumption with a given meal type 1
  Consumption? getConsumptionByMealType(String mealType) {
    if (consumption != null) {
      for (int i = 0; i < consumption!.length; i++) {
        if (consumption![i]['mealType'].
        toString().
        toLowerCase() == mealType
            .toString()
            .toLowerCase()) {
          return Consumption.fromJson(consumption![i]);
        }
      }
    }
    return null;
  }


  //update consumption locally
  void updateConsumption(Consumption consumption) {
    if (this.consumption != null) {
      for (int i = 0; i < this.consumption!.length; i++) {
        if (this.consumption![i]['_id'].toString() == consumption.id) {
          this.consumption![i] = consumption.toJson();
        }
      }
    }
  }
}