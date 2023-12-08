import 'package:fitapp/controllers/coach-messageController.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../common_widgets/conversation_coach.dart';
import '../controllers/ChatController.dart';

class CoachConversationList extends StatefulWidget {
  const CoachConversationList({Key? key}) : super(key: key);

  @override
  State<CoachConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<CoachConversationList> {
  TextEditingController userSearch = TextEditingController();
  CoachChatController chatController = Get.put(CoachChatController()); // Initialize ChatController

  @override
  void initState() {
    super.initState();
    chatController.getCoachLatestConvos(); // Fetch latest messages on initialization
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColor.lightGray,
      appBar: AppBar(
        backgroundColor: TColor.white,
        centerTitle: true,
        elevation: 0,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Container(
            margin: const EdgeInsets.all(8),
            height: 40,
            width: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: TColor.lightGray,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: TColor.black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          "Conversations",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                Icons.more_horiz,
                color: TColor.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            decoration: BoxDecoration(
              color: TColor.white,
              borderRadius: BorderRadius.circular(15),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black12,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                )
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: userSearch,
                    decoration: InputDecoration(
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      prefixIcon: Icon(
                        Icons.search,
                        color: TColor.gray.withOpacity(0.5),
                        size: 20,
                      ),
                      hintText: "Search",
                    ),
                  ),
                ),
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  width: 1,
                  height: 25,
                  color: TColor.gray.withOpacity(0.3),
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    margin: const EdgeInsets.all(8),
                    height: 40,
                    width: 40,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: TColor.lightGray,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.filter_list,
                      color: TColor.black,
                      size: 20,
                    ),
                  ),
                )
              ],
            ),
          ),
          Obx(() {
            if (chatController.isLoading.value) {
              return CircularProgressIndicator();
            } else {
              return Expanded(
                child: ListView.builder(
                  itemCount: chatController.coachLatestConvo.length,
                  shrinkWrap: true,
                  padding: EdgeInsets.only(top: 16),
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return CoachConversationListItem(
                      id: chatController.coachLatestConvo[index].id,
                      fullName: chatController.coachLatestConvo[index].fullName,
                      message: chatController.coachLatestConvo[index].fromSelf
                          ? "You: ${chatController.coachLatestConvo[index].message}"
                          : chatController.coachLatestConvo[index].message,
                      image: chatController.coachLatestConvo[index].image,
                      timestamp: chatController.coachLatestConvo[index].timestamp,
                      isMessageRead: chatController.coachLatestConvo[index].fromSelf,
                    );
                  },
                ),
              );
            }
          }),
        ],
      ),
    );
  }
}