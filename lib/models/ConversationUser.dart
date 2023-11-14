class ConversationUser{
  String id;
  String fullName;
  bool fromSelf;
  String image;
  String message;
  String timestamp;

  ConversationUser({
    required this.id,
    required this.fullName,
    required this.fromSelf,
    required this.image,
    required this.message,

    required this.timestamp,
  });


  factory ConversationUser.fromJson(Map<String, dynamic> json) {
    return ConversationUser(
      id: json['id'] ?? '',
      fullName: json['fullName'] ?? '',
      fromSelf: json['fromSelf'] ?? '',
      image: json['image'] ?? '',
      message: json['message'] ?? '',
      timestamp: json['timestamp'] ?? '',
    );
  }

  static List<ConversationUser> fromJsonList(List<dynamic> json) {
    List<ConversationUser> conversationUsers = [];
    json.forEach((element) {
      conversationUsers.add(ConversationUser.fromJson(element));
    });
    return conversationUsers;
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'fullName': fullName,
      'fromSelf': fromSelf,
      'image': image,
      'message': message,
      'timestamp': timestamp,
    };
  }
}