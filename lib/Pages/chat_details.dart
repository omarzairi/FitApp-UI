import 'package:flutter/material.dart';
import 'package:fitapp/models/Message.dart';
import 'package:fitapp/controllers/ChatController.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ChatDetailPage extends StatefulWidget {
  final String id;
  final String fullName;
  final String image;

  const ChatDetailPage({
    Key? key,
    required this.id,
    required this.fullName,
    required this.image,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {
  List<MessageModel> messages = [];
  late TextEditingController _messageController;
  late ChatController _chatController;

  @override
  void initState() {
    super.initState();
    _chatController = Get.put(ChatController());
    _loadMessages();
  }
  Future<void> _loadMessages() async {
    try {
      // Use the getUserMessages method from ChatController
      await _chatController.getUserMessages({'to': widget.id});
      setState(() {
        // Update messages using the userMessages list from the controller
        messages = List.from(_chatController.userMessages);
      });
    } catch (e) {
      print('Error loading messages: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.image),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(widget.fullName, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w400)),
                      SizedBox(height: 3,),
                      Text("Online", style: TextStyle(color: Colors.grey.shade600, fontSize: 12)),
                    ],
                  ),
                ),
                Icon(Icons.settings, color: Colors.black54),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: <Widget>[
          ListView.builder(
            itemCount: messages.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 10, bottom: 10),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                child: Align(
                  alignment: (messages[index].fromSelf == false ? Alignment.topLeft : Alignment.topRight),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: (messages[index].fromSelf == false ? Colors.grey.shade200 : TColor.primaryColor2),
                    ),
                    padding: EdgeInsets.all(16),
                    child: Text(messages[index].message, style: TextStyle(fontSize: 15)),
                  ),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: TColor.primaryColor2,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 20),
                    ),
                  ),
                  SizedBox(width: 15,),
                  Expanded(
                    child: TextField(
                      controller: _chatController.messageController,
                      decoration: InputDecoration(
                        hintText: "Write message...",
                        hintStyle: TextStyle(color: Colors.black54),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                  SizedBox(width: 15,),
                  FloatingActionButton(
                    onPressed: () {
                      _chatController.userSend({
                        'recipientId': widget.id,
                        'message': _chatController.messageController.text,
                      });
                    },
                    child: Icon(Icons.send, color: Colors.white, size: 18),
                    backgroundColor: TColor.primaryColor2,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }
}
