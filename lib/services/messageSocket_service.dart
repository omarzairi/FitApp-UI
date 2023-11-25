import 'dart:async';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class ChatSocketService {
  late IO.Socket socket;
  late StreamController<Map<String, dynamic>> _messageController;

  ChatSocketService() {
    _messageController = StreamController<Map<String, dynamic>>.broadcast();
  }

  void connect(String userId) {
    socket = IO.io('http://fit-app-api.azurewebsites.net', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket.connect();
    socket.emit('add-user', userId);

    socket.on('msg-recieve', (data) {
      _messageController.add(data);
    });
  }



  void sendMessage(Map<String, dynamic> data) {
    socket.emit('send-msg', data);
  }

  Stream<Map<String, dynamic>> getMessages() {
    return _messageController.stream;
  }

  void dispose() {
    _messageController.close();
  }
}
