import 'package:fitapp/models/Message.dart';
import 'package:get/get.dart';

class ChatController extends GetxController{
  var chatList = <MessageModel>[].obs;
  var isLoading = true.obs;


  void addStaticMessage(String message){
    MessageModel messageModel = MessageModel(
      message: message,
      fromSelf: true,
    );
    chatList.add(messageModel);
  }


}