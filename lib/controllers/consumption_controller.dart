import 'package:fitapp/services/consumption_service.dart';
import 'package:get/get.dart';

import '../models/ConsumptionFacts.dart';

class ConsumptionController extends GetxController{
  late ConsumptionFact consumptionFacts;

  Future<ConsumptionFact> getFacts(String user,Map<String,dynamic> date)
  async {
    try
        {
          var response = await ConsumptionService().getNutritionFactsToday(user, date);
          if(response.statusCode == 200)
            {
              if(response.data != null)
                {
                  consumptionFacts = ConsumptionFact.fromJson(response.data!);
                  return consumptionFacts;
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