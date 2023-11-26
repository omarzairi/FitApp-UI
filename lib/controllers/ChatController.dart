import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:fitapp/models/Message.dart';
import 'package:fitapp/services/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../services/messageSocket_service.dart';

class ChatController extends GetxController {
  var chatList = <MessageModel>[].obs;
  var isLoading = true.obs;
  var userLatestConvo = <ConversationUser>[].obs;
  var coachLatestConvo=<ConversationUser>[].obs;
  var coachMessages=<MessageModel>[].obs;
  var userMessages = <MessageModel>[].obs;
  late MessageModel message;
  late MessageService msgService;
  late TextEditingController messageController;
  late UserController userController;
  var logger = Logger();
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
    msgService = MessageService();
    await msgService.init();
    userController = UserController();
    await userController.getLoggedUser();
    chatSocketService.connect(userController.user!.id!);
    chatSocketService.getMessages().listen((message) {
      // Handle incoming message
      // For example, update the chatList
      chatList.add(MessageModel.fromJson(message));
    });
    getUserLatestConvos();
  }

  void addStaticMessage(String message) {
    MessageModel messageModel = MessageModel(
      message: message,
      fromSelf: true,
    );
    chatList.add(messageModel);
  }

  Future<void> userSend(Map<String, dynamic> messageData) async {
    try {
      chatSocketService.sendMessage(messageData);

      var response = await msgService.userSend(messageData);
      if (response.statusCode == 200) {
       /* if (response.data != null && response.data is Map<String, dynamic>) {
          message = MessageModel.fromJson(response.data!);
        } else {
          _showErrorSnackbar("Invalid response structure");
        }*/
        var listMsgs=new MessageModel(fromSelf: true, message: messageData["message"]);
        print(listMsgs.message);
       this.userMessages.add(listMsgs);
        print(userMessages.toJson());
        update();

        print(response.data);

      } else {
        _showErrorSnackbar(response.data['message']);
      }
    } catch (e) {
      print('Error: $e');
      _showErrorSnackbar("An error occurred while sending the message");
    }
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
      print('Error: $e');
      _showErrorSnackbar("An error occurred while sending the message");
    }
  }

  Future<void> getUserMessages(Map<String, dynamic> messageData) async {
    try {
      var response = await msgService.getUserMessages(messageData);

      if (response.statusCode == 200) {
        var userMess = MessageModel.fromJsonList(response.data);
        if (userMess != null) {
          userMessages.assignAll(userMess);
          print(userLatestConvo);
        }
      }
    } finally {
      isLoading(false); // Set loading to false after updating userMessages
    }
  }

  Future<void> getUserLatestConvos() async {
    try {
      var response = await msgService.getUserLatestConvos();

      if (response.statusCode == 200) {
        var userConvo = ConversationUser.fromJsonList(response.data);
        if (userConvo != null) {
          userLatestConvo.assignAll(userConvo);
          print(userLatestConvo);
        }

      }
    } finally {
      isLoading(false); // Set loading to false after updating userLatestConvo
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
    } finally {
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
    } finally {
      isLoading(false); // Set loading to false after updating coachLatestConvo
    }
  }











  void _showErrorSnackbar(String message) {
    Get.snackbar("Error", message);
    throw Exception(message);
  }
}