import 'package:dio/dio.dart';
import 'package:fitapp/models/Aliment.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ConsumptionService {
  late Dio dio;
  final storage = const FlutterSecureStorage();
  ConsumptionService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/consumptions',
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
      Response response = await dio.get('/getbyid/$id');
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

  Future<Response> getConsumptionsForUserByDate(Map<String,dynamic> consumptionData) async {
    try
        {
          print("Request URL: ${dio.options.baseUrl}/getTodayConsumptions");
          print("Headers: ${dio.options.headers}");
          print(consumptionData);
          Response response = await dio.post('/getTodayConsumptions',data:consumptionData,options:Options(
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer ${await storage.read(key:'userToken')}',
            },));
          return response;
        }
        catch(error)
          {
            throw Exception(error.toString());
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

  Future<Response> getNutritionFactsToday(String user,Map<String,dynamic> datastuff) async {
    try {
      Response response = await dio.post('/nutritionFactsToday/$user',data:datastuff);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}