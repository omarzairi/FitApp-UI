import 'package:dio/dio.dart';
import 'package:fitapp/controllers/coach_controller.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:fitapp/models/Message.dart';
import 'package:fitapp/services/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../services/coach_message_service.dart';
import '../services/messageSocket_service.dart';

class CoachChatController extends GetxController {
  var chatList = <MessageModel>[].obs;
  var isLoading = true.obs;
  var coachLatestConvo=<ConversationUser>[].obs;
  var coachMessages=<MessageModel>[].obs;
  late MessageModel message;
  late MessageCoachService msgService;
  late TextEditingController messageController;
  var logger = Logger();
  late CoachController coachController;
  late ChatSocketService chatSocketService;

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    chatSocketService = Get.find();

    initialize();
  }

  @override
  void onClose() {
    // Dispose the controller when it's not needed anymore
    messageController.dispose();
    chatSocketService.dispose();

    super.onClose();
  }

  Future<void> initialize() async {
    msgService = MessageCoachService();
    await msgService.init();
    coachController = CoachController();
    await coachController.getLoggedCoach();
    chatSocketService.connect(coachController.coach!.id!);
    chatSocketService.getMessages().listen((message) {
      // Handle incoming message
      // For example, update the chatList
      chatList.add(MessageModel.fromJson(message));
    });
    getCoachLatestConvos();
  }

  void addStaticMessage(String message) {
    MessageModel messageModel = MessageModel(
      message: message,
      fromSelf: true,
    );
    chatList.add(messageModel);
  }


  Future<void> coachSend(Map<String, dynamic> messageData) async {
    try {
      chatSocketService.sendMessage(messageData);

      var response = await msgService.coachSend(messageData);

      if (response.statusCode == 200) {
        var listcoachMsgs=new MessageModel(fromSelf: true, message: messageData["message"]);
        print(listcoachMsgs.message);
        this.coachMessages.add(listcoachMsgs);
        print(coachMessages.toJson());
        update();

        print(response.data);

      } else {
        _showErrorSnackbar(response.data['message']);
      }
    } catch (e) {
      handleDioError(e);

    }
  }



  //coach
  Future<void> getCoachMessages(Map<String, dynamic> messageData) async {
    try {
      var response = await msgService.getCoachMessages(messageData);

      if (response.statusCode == 200) {
        var coachMess = MessageModel.fromJsonList(response.data);
        if (coachMess != null) {
          coachMessages.assignAll(coachMess);
          print(coachLatestConvo);
        }
      }
    }catch(e){
      handleDioError(e);
    }

    finally {
      isLoading(false); // Set loading to false after updating userMessages
    }
  }

  Future<void> getCoachLatestConvos() async {
    try {
      var response = await msgService.getCoachLatestConvos();

      if (response.statusCode == 200) {
        var coachConvo = ConversationUser.fromJsonList(response.data);
        if (coachConvo != null) {
          coachLatestConvo.assignAll(coachConvo);
          print(coachLatestConvo);
        }

      }
    }catch(e){
      handleDioError(e);
    }

    finally {
      isLoading(false); // Set loading to false after updating coachLatestConvo
    }
  }
  void _showErrorSnackbar(String message) {
    Get.snackbar("Error", message);
    throw Exception(message);
  }


  void handleDioError(dynamic e) {
    if (e is DioError) {
      if (e.type == DioErrorType.connectTimeout) {
        throw Exception('Connection timeout');
      } else if (e.type == DioErrorType.response) {
        throw Exception('Failed to send coach message. Server responded with error: ${e.response?.statusCode}');
      } else {
        throw Exception('Failed to send coach message: $e');
      }
    } else {
      throw Exception('Unexpected error: $e');
    }
  }

}
