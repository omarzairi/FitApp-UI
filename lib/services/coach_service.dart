import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class CoachService {
  late Dio dio;
  final storage = const FlutterSecureStorage();

  CoachService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/coaches',
        receiveTimeout: 3000,
      ),
    );
  }

  Future<Response> getCoachById(String id) async {
    try {
      Response response = await dio.get('/getCoachById/$id', options: Options(
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${await storage.read(key: 'coachToken')}',
        },
      ));
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Response> createCoach(Map<String, dynamic> coachData) async {
    try {
      Response response = await dio.post('/addCoach', data: coachData);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Response> updateCoach(String id, coachData) async {
    try {
      Response response = await dio.put('/updateCoach/$id', data: coachData);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Response> loginCoach(coachData) async {
    try {
      Response response = await dio.post('/loginCoach', data: coachData);
      return response;
    } catch (error) {
      throw Exception(error.toString());
    }
  }

  Future<Response> getLoggedCoach() async {
    Response response = await dio.get('/loggedCoach',options: Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'coachToken')}', // Example of an Authorization header
      },));
    return response;

  }

}
