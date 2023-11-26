import 'package:fitapp/models/Consumption.dart';
import 'package:fitapp/services/consumption_service.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

import '../models/ConsumptionFacts.dart';

class ConsumptionController extends GetxController{
  final storage=const FlutterSecureStorage() ;

  ConsumptionFact? consumptionFact;

  List<dynamic>? consumption;
  @override
  Future<void> onInit() async {

    super.onInit();
    print("onInit Consumption");
  }

  Future<void> getConsumptionsByDate(Map<String,dynamic> consumptionData) async
  {
    try
        {
          var response = await ConsumptionService().getConsumptionsForUserByDate(consumptionData);
          if(response.statusCode == 200)
            {
              if(response.data != null)
                {
                  consumption = response.data;
                  print(response);
                }
              else
                {
                  throw Exception("Error : not found!");
                }
            }
        }
        catch(error)
    {
      throw Exception(error.toString());
    }
  }

  Future<ConsumptionFact?> getFacts(String user,Map<String,dynamic> datastuff)
  async {
    try
        {
          var response = await ConsumptionService().getNutritionFactsToday(user,datastuff);
          print(datastuff);
          if(response.statusCode == 200)
            {
              if(response.data != null)
                {
                  consumptionFact = ConsumptionFact.fromJson(response.data!);
                  print(response);
                  return consumptionFact;
                }
              else
                {
                  Get.snackbar("Error", "Invalid response structure");
                  throw Exception("Invalid response structure");
                }
            }
          else{
            Get.snackbar("Error", response.data['message']);
            throw Exception("error why");
          }
        }
        catch(e)
    {
      throw Exception(e.toString());
    }
  }

}