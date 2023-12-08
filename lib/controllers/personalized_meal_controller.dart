import 'package:get/get.dart';

import 'package:fitapp/services/personalized_meal_service.dart';

import '../models/PersonalizedMeal.dart';

class PersonalizedMealController extends GetxController {
  var personalizedMealList = <PersonalizedMeal>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    fetchPersonalizedMeals();
    super.onInit();
  }

  void fetchPersonalizedMeals() async {
    try {
      isLoading(true);
      var personalizedMealService = PersonalizedMealService();
      var response =
          await personalizedMealService.getPersonalizedMealByUser('userId');
      if (response.statusCode == 200) {
        print(response.data);
        var personalizedMeals = PersonalizedMeal.fromJsonList(response.data);
        if (personalizedMeals != null) {
          personalizedMealList.assignAll(personalizedMeals);
        }
      }
    } finally {
      isLoading(false);
    }
  }

  Future<void> createPersonalizedMeal(Map<String, dynamic> mealData) async {
    try {
      var personalizedMealService = PersonalizedMealService();
      var response =
          await personalizedMealService.createPersonalizedMeal(mealData);
      if (response.statusCode == 201) {
        fetchPersonalizedMeals();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  PersonalizedMeal getPersonalizedMeal(int index) {
    return personalizedMealList[index];
  }

  Future<void> updatePersonalizedMeal(
      String id, Map<String, dynamic> mealData) async {
    try {
      var personalizedMealService = PersonalizedMealService();
      var response =
          await personalizedMealService.updatePersonalizedMeal(id, mealData);
      if (response.statusCode == 200) {
        fetchPersonalizedMeals();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> deletePersonalizedMeal(String id) async {
    try {
      var personalizedMealService = PersonalizedMealService();
      var response = await personalizedMealService.deletePersonalizedMeal(id);
      if (response.statusCode == 200) {
        fetchPersonalizedMeals();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> addAlimentToMeal(String mealId, String alimentId) async {
    try {
      var personalizedMealService = PersonalizedMealService();
      var response =
          await personalizedMealService.addAlimentToMeal(mealId, alimentId);
      if (response.statusCode == 200) {
        fetchPersonalizedMeals();
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
