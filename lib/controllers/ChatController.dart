import 'package:fitapp/models/ConversationUser.dart';
import 'package:fitapp/models/Message.dart';
import 'package:fitapp/services/message_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  var chatList = <MessageModel>[].obs;
  var isLoading = true.obs;
  var userLatestConvo = <ConversationUser>[].obs;
  var userMessages = <MessageModel>[].obs;
  late MessageModel message;
  late MessageService msgService;
  late TextEditingController messageController;

  @override
  void onInit() {
    super.onInit();
    messageController = TextEditingController();
    initialize();
  }
  @override
  void onClose() {
    // Dispose the controller when it's not needed anymore
    messageController.dispose();
    super.onClose();
  }

  Future<void> initialize() async {
    msgService = MessageService();
    await msgService.init();
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
      var response = await msgService.userSend(messageData);
      if (response.statusCode == 200) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          message = MessageModel.fromJson(response.data!);
        } else {
          _showErrorSnackbar("Invalid response structure");
        }
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
      var response = await msgService.coachSend(messageData);

      if (response.statusCode == 200) {
        if (response.data != null && response.data is Map<String, dynamic>) {
          message = MessageModel.fromJson(response.data!);
        } else {
          _showErrorSnackbar("Invalid response structure");
        }
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




  void _showErrorSnackbar(String message) {
    Get.snackbar("Error", message);
    throw Exception(message);
  }
}