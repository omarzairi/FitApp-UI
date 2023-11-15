import 'package:dio/dio.dart';

class UserService{
  late Dio dio;

  UserService(){
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/users',
        receiveTimeout: 3000

      )
    );
  }
  /*Future<Response> getAllUsers() async{
    try
        {
          Response res = await dio.get("/");
          return res;
        }
        catch(e)
    {
      throw Exception(e.toString());
    }
  }*/
  Future<Response> getUserById(String id) async{
    try{
      Response res = await dio.get('/getUserById/$id');

      return res;
    }
    catch(e)
    {
      throw Exception(e.toString());
    }
  }
}