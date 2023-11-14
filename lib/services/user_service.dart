import 'package:dio/dio.dart';

class UserService {
  late Dio dio;

  UserService() {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/users',

      ),
    );
  }


  Future<Response> getUserById(String id) async {

      Response response = await dio.get('/getUserById/$id');
      return response;



  }

  Future<Response> createUser(Map<String, dynamic> userData) async {
    Response response = await dio.post('/addUser', data: userData);
    return response;
  }


  Future<Response> updateUser(String id, userData) async {

      Response response = await dio.put('/updateUser/$id', data: userData);
      return response;

  }

  Future<Response> loginUser(userData)async{

      Response response = await dio.post('/loginUser',data: userData);
      return response;


  }

}
