import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class PersonalizedMealService {
  late Dio dio;

  PersonalizedMealService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/perso',
        receiveTimeout: 3000,
      ),
    );
  }

  final storage = const FlutterSecureStorage();

  Future<Response> getPersonalizedMealByUser(String userId) async {
    try {
      Response response = await dio.get(
        '/',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> getPersonalizedMealById(String id) async {
    try {
      Response response = await dio.get(
        '/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> createPersonalizedMeal(Map<String, dynamic> mealData) async {
    try {
      Response response = await dio.post(
        '/',
        data: mealData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> updatePersonalizedMeal(String id, Map<String, dynamic> mealData) async {
    try {
      Response response = await dio.put(
        '/$id',
        data: mealData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> deletePersonalizedMeal(String id) async {
    try {
      Response response = await dio.delete(
        '/$id',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> addAlimentToMeal(String mealId, String alimentId) async {
    try {
      Response response = await dio.post(
        '/addAliment/$mealId/$alimentId',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
          },
        ),
      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}