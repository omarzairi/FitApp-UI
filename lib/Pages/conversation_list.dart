import 'dart:core';



import 'package:fitapp/Pages/homepage/footer.dart';
import 'package:fitapp/common_widgets/conversation_user.dart';
import 'package:fitapp/models/ConversationUser.dart';
import 'package:fitapp/utils/theme_colors.dart';

import 'package:flutter/material.dart';


class ConversationList extends StatefulWidget {

  const ConversationList({Key? key}) : super(key: key);
  @override
  State<ConversationList> createState() => _ConversationListState();
}

class _ConversationListState extends State<ConversationList> {
  TextEditingController userSearch = TextEditingController();

  //changing this later to a list of users
 // This is your static list of users
 List<ConversationUser> conversationUsers = [
   ConversationUser(id: '654cb2125f76956b671d6344', fullName: "Louati aziz", fromSelf: true,image: "https://scontent.ftun10-1.fna.fbcdn.net/v/t39.30808-1/312110773_833609441099316_7166441296701851886_n.jpg?stp=c0.29.320.320a_dst-jpg_p320x320&_nc_cat=110&ccb=1-7&_nc_sid=5f2048&_nc_ohc=nsO3hpD9MqAAX87ig2N&_nc_ht=scontent.ftun10-1.fna&oh=00_AfCkirzYBa-yBsw3n3nEgbKof_pf-o3LTypThcSlb8b0kQ&oe=6558C80B", message: "Ahla Bik", timestamp: "2023-11-14T16:19:29.941Z"),
];

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
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: TColor.black,
              size: 20,
            ),
          ),
        ),
        title: Text("Conversations",
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),
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
                  borderRadius: BorderRadius.circular(10)),
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
                      offset: Offset(0, 1))
                ]),
            child: Row(
              children: [
                Expanded(
                    child: TextField(
                      controller: userSearch,
                      decoration: InputDecoration(
                          focusedBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          prefixIcon: Icon(Icons.search,
                              color: TColor.gray.withOpacity(0.5), size: 20),
                          hintText: "Search"),
                    )),
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
                        borderRadius: BorderRadius.circular(10)),
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
          ListView.builder(
            itemCount: conversationUsers.length,
            shrinkWrap: true,
            padding: EdgeInsets.only(top: 16),
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index){
              return ConversationListItem(
                id: conversationUsers[index].id,
                fullName: conversationUsers[index].fullName,

                message: conversationUsers[index].fromSelf ? "You : "+conversationUsers[index].message : conversationUsers[index].message,
                image: conversationUsers[index].image,
                timestamp: conversationUsers[index].timestamp,
                isMessageRead: (conversationUsers[index].fromSelf)
              );
            },
          ),
        ],
      ),
      bottomNavigationBar: Footer(
        selectTab: 1,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: SizedBox(
        width: 70,
        height: 70,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, '/alimentlist');
          },
          child: Container(
            width: 65,
            height: 65,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: TColor.primaryG,
                ),
                borderRadius: BorderRadius.circular(35),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,)
                ]),
            child: Icon(Icons.add,color: TColor.white, size: 35, ),
          ),
        ),
      ),
    );
  }
}