import 'package:fitapp/controllers/coach-messageController.dart';
import 'package:flutter/material.dart';
import 'package:fitapp/models/Message.dart';
import 'package:fitapp/controllers/ChatController.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class CoachChatDetailPage extends StatefulWidget {
  final String id;
  final String fullName;
  final String image;

  const CoachChatDetailPage({
    Key? key,
    required this.id,
    required this.fullName,
    required this.image,
  }) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<CoachChatDetailPage> {
  List<MessageModel> messages = [];
  late TextEditingController _messageController;
  late CoachChatController _chatController;
  ScrollController _scrollController = ScrollController();




  @override
  void initState() {
    super.initState();
    _chatController = Get.put(CoachChatController());
    _loadMessages();
  }

  Future<void> _loadMessages() async {
    try {
      await _chatController.getCoachMessages({'to': widget.id});
      setState(() {
        messages = List.from(_chatController.coachMessages);
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
      body: Column(
        children: <Widget>[
          Expanded(
            child: Obx(() => ListView.builder(
              controller: _scrollController,
              itemCount: _chatController.coachMessages.length,
              reverse: true, // Set reverse to true
              padding: EdgeInsets.only(top: 10, bottom: 60),
              itemBuilder: (context, index) {
                final reversedIndex = _chatController.coachMessages.length - index - 1;
                return Container(
                  padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
                  child: Align(
                    alignment: (_chatController.coachMessages[reversedIndex].fromSelf == false
                        ? Alignment.topLeft
                        : Alignment.topRight),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: (_chatController.coachMessages[reversedIndex].fromSelf == false
                            ? Colors.grey.shade200
                            : TColor.primaryColor2),
                      ),
                      padding: EdgeInsets.all(16),
                      child: Text(
                        _chatController.coachMessages[reversedIndex].message,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                  ),
                );
              },
            )),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Container(
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
                        _chatController.coachSend({
                          'to': widget.id,
                          'message': _chatController.messageController.text,
                        });
                        _chatController.messageController.clear();

// Update the state to include the new message
                        setState(() {
                          messages.add(_chatController.coachMessages.last);
                        });
                        _loadMessages();
                      },
                      child: Icon(Icons.send, color: Colors.white, size: 18),
                      backgroundColor: TColor.primaryColor2,
                      elevation: 0,
                    ),
                  ],
                ),
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
    _scrollController.dispose();
    super.dispose();
  }
}
