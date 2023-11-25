import 'package:dio/dio.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MessageService {
  late Dio dio;
  final storage = const FlutterSecureStorage();

  // Use a factory constructor to perform asynchronous initialization
  factory MessageService() {
    return MessageService._internal();
  }

  MessageService._internal();

  Future<void> init() async {
    dio = Dio(
      BaseOptions(
        baseUrl: 'https://fit-app-api.azurewebsites.net/api/messages',
        connectTimeout: 5000,
        receiveTimeout: 3000,
        headers: {
          'Authorization': 'Bearer ${await storage.read(key: 'userToken')}',
        },
      ),
    );
  }

  Future<Response> userSend(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/userSend', data: messageData);
    } catch (e) {
      throw Exception('Failed to send user message: $e');
    }
  }

  Future<Response> coachSend(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/coachSend', data: messageData);
    } catch (e) {
      throw Exception('Failed to send coach message: $e');
    }
  }

  Future<Response> getUserMessages(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/getUsersMessages', data: messageData);
    } catch (e) {
      throw Exception('Failed to get user messages: $e');
    }
  }

  Future<Response> getCoachMessages(Map<String, dynamic> messageData) async {
    try {
      return await dio.post('/getCoachMessages', data: messageData);
    } catch (e) {
      throw Exception('Failed to get coach messages: $e');
    }
  }

  Future<Response> getUserLatestConvos() async {
    try {
      return await dio.get('/getMyLatestConvos');
    } catch (e) {
      throw Exception('Failed to get user latest convos: $e');
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
