import 'package:dio/dio.dart';
import 'package:fitapp/models/Aliment.dart';

class ConsumptionService {
  late Dio dio;

  ConsumptionService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/consumptions',
        connectTimeout: 5000,
        receiveTimeout: 3000,
      ),
    );
  }

  Future<Response> getAllConsumptions() async {
    try {
      Response response = await dio.get('/');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> getConsumptionById(String id) async {
    try {
      Response response = await dio.get('/$id');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> addAlimentToAConsumption(String id, String alimentId, int quantity) async {
    try {
      Response response = await dio.put('/$id/aliment/$alimentId', data: {'quantity': quantity});
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> createConsumption(Map<String, dynamic> consumptionData) async {
    try {
      Response response = await dio.post('/', data: consumptionData);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> updateConsumption(String id, Map<String, dynamic> updatedData) async {
    try {
      Response response = await dio.put('/$id', data: updatedData);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> deleteConsumption(String id) async {
    try {
      Response response = await dio.delete('/$id');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> getNutritionFactsToday(String user) async {
    try {
      Response response = await dio.get('/nutritionFactsToday/$user');
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}