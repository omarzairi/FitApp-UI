import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
class ObjectifService {
  late Dio dio;

  ObjectifService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/objectifs',
        receiveTimeout: 3000,
      ),
    );
  }
  final storage=const FlutterSecureStorage() ;
  Future<Response> getData(String endpoint) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> addObjectif(Map<String, dynamic>objectifData) async {
    try {
      Response response = await dio.post('/addObjectif', data: objectifData,
    options: Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },
    )

      );
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }
  
  Future<Response> getObjectiveByUserId(String id) async{
    try
        {
          Response response = await dio.get("/getObjectifByUserId/$id",options: Options(
            headers: {
              'Content-Type': 'application/json', // Add any headers you need
              'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
            },));
          return response;
        }
        catch(e)
    {
      throw Exception(e.toString());
    }
}
}
