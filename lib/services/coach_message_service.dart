import 'package:dio/dio.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessageCoachService {
  late Dio dio;
  final storage = const FlutterSecureStorage();

  // Use a factory constructor to perform asynchronous initialization
  factory MessageCoachService() {
    return MessageCoachService._internal();
  }

  MessageCoachService._internal();

  Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/messages',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Authorization': 'Bearer ${await storage.read(key: 'coachToken')}',
        },
      ),
    );
  }



  Future<Response> coachSend(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/coachSend', data: messageData);
    } catch (e) {
      throw Exception('Failed to send coach message: $e');
    }
  }



  Future<Response> getCoachMessages(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/getCoachMessages', data: messageData);
    } catch (e) {
      throw Exception('Failed to get coach messages: $e');
    }
  }



  Future<Response> getCoachLatestConvos() async {
    try {
      return await dio.get('/getCoachLatestConvos');
    } catch (e) {
      throw Exception('Failed to get coach latest convos: $e');
    }
  }
}


