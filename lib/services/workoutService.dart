

import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class WorkoutService{
  late Dio dio;
  final storage = const FlutterSecureStorage();
  WorkoutService(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/workouts',
      ),
    );
  }

  Future<Response> getAllWorkouts() async{
    Response response = await dio.get('/workout/all');
    return response;
  }

  Future<Response> searchWorkoutwithQuery(Map<String, dynamic> query) async{
    Response response = await dio.post('/search/querysearch',data: query);
    return response;
  }

  Future<Response> addWorkoutToList(String id) async{
    Response response = await dio.post('/$id',options: Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },));
    return response;
  }

  Future<Response> deleteWorkoutListUser(String id) async{
    Response response = await dio.delete('/$id',
        options: Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },));
    return response;
  }
  Future<Response> getWorkoutlistUser() async{
    Response response = await dio.get("/",
        options: Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },));
    return response;
  }

}