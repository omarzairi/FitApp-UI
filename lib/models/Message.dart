class MessageModel{
  final bool fromSelf;
  final String message;

  MessageModel({required this.fromSelf, required this.message});

  factory MessageModel.fromJson(Map<String, dynamic> json) {
    return MessageModel(
      fromSelf: json['fromSelf'],
      message: json['message'],
    );
  }

  static List<MessageModel> fromJsonList(List<dynamic> json) {
    List<MessageModel> messages = [];
    json.forEach((element) {
      messages.add(MessageModel.fromJson(element));
    });
    return messages;
  }

Map<String, dynamic> toJson() {
    return {
      'fromSelf': fromSelf,
      'message': message,
    };
  }
}