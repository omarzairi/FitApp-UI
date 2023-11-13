import 'package:fitapp/services/consumption_service.dart';
import 'package:get/get.dart';
import 'package:fitapp/models/Aliment.dart';
import 'package:fitapp/services/network_service.dart';

class AlimentController extends GetxController {
  var alimentList = <Aliment>[].obs;
  var isLoading = true.obs;
  RxList<bool> selectedAliments = <bool>[].obs;


  @override
  void onInit() {
    super.onInit();
    fetchAliments();
  }

  void fetchAliments() async {
    try {
      isLoading(true);
      var networkService = NetworkService();
      var response = await networkService.getData('/aliments');
      if (response.statusCode == 200) {
        var aliments = Aliment.fromJsonList(response.data);
        if (aliments != null) {
          alimentList.assignAll(aliments);
          selectedAliments.assignAll(List<bool>.filled(aliments.length, false));
          print(selectedAliments);
          print(alimentList);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Aliment getAliment(int index) {
    return alimentList[index];
  }

void toggleSelection(int index) {
  selectedAliments[index] = !selectedAliments[index];
}

  Future<void> addAlimentToConsumption(
      String consumptionId, String alimentId, int quantity) async {
    try {
      var consumptionService = ConsumptionService();
      var response = await consumptionService.addAlimentToAConsumption(
          consumptionId, alimentId, quantity);
      if (response.statusCode == 200) {
        // Handle the response here
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  void clearSelection() {
    selectedAliments.assignAll(List<bool>.filled(alimentList.length, false));
  }
}
