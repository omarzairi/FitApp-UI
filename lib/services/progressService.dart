import 'package:dio/dio.dart';

class ProgressService{
  late Dio dio;

  ProgressService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/progress',

      ),
    );
  }

    Future<Response> createProgress(Map<String, dynamic>progressData) async {
      try{
        Response response= await dio.post('/addProgress',data: progressData);
        return response;
      }
      catch(e){
        throw Exception(e.toString());
      }
    }
    Future<Response> getProgressByUserId(String id) async {
      try{
        Response response= await dio.get('/getProgressByUserId/$id');
        return response;
      }
      catch(e){
        throw Exception(e.toString());
      }
    }

    Future<Response> addProgressToAUser(String id,progressData) async {
      try{
        Response response= await dio.put('/addProgressToAUser/$id',data: progressData);
        return response;
      }
      catch(e){
        throw Exception(e.toString());
      }
    }

  }

