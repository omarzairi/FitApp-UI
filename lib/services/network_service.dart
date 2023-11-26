import 'package:dio/dio.dart';

class NetworkService {
  late Dio dio;

  NetworkService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/',
        receiveTimeout: 3000,
      ),
    );
  }

  Future<Response> getData(String endpoint) async {
    try {
      Response response = await dio.get(endpoint);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Response> postData(String endpoint, dynamic data) async {
    try {
      Response response = await dio.post(endpoint, data: data);
      return response;
    } catch (e) {
      throw Exception(e.toString());
    }
  }


  Future<Response> searchAlimentByCategory(Map<String,dynamic> query)
  async {
    Response response = await dio.post('/aliments/search',data:query);
    return response;
  }


}