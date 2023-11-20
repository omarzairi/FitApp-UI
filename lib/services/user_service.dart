import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserService {
  late Dio dio;
  final storage=const FlutterSecureStorage() ;
  UserService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/users',
        receiveTimeout: 3000,
      ),
    );
  }


  Future<Response> getUserById(String id) async {

      Response response = await dio.get('/getUserById/$id',options: Options(
      headers: {
      'Content-Type': 'application/json', // Add any headers you need
      'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },));
      return response;



  }

  Future<Response> createUser(Map<String, dynamic> userData) async {
    Response response = await dio.post('/addUser', data: userData);
    return response;
  }


  Future<Response> updateUser(String id, userData) async {

      Response response = await dio.put('/updateUser/$id', data: userData,options:
      Options(
        headers: {
          'Content-Type': 'application/json', // Add any headers you need
          'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
        },));
      return response;

  }

  Future<Response> loginUser(userData)async{

      Response response = await dio.post('/loginUser',data: userData);
      return response;


  }

  Future<Response> getLoggedUser() async {
    Response response = await dio.get('/loggedUser',options: Options(
      headers: {
    'Content-Type': 'application/json', // Add any headers you need
    'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
    },));
    return response;

  }

  Future<Response> deleteUser(String id) async {
    Response response = await dio.delete('/deleteUser/$id',options:
    Options(
      headers: {
    'Content-Type': 'application/json', // Add any headers you need
    'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
    },));

    return response;
  }


  Future<Response> changePassword(String id, Map<String, dynamic> userData) async {
    Response response = await dio.put('/changePassword/$id', data: userData,options:
    Options(
      headers: {
        'Content-Type': 'application/json', // Add any headers you need
        'Authorization': 'Bearer ${await storage.read(key: 'userToken')}', // Example of an Authorization header
      },));
    return response;
  }

}
