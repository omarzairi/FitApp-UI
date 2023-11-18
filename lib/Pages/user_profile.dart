import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/User.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}


class _ProfileUserState extends State<ProfileUser> {




  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar:AppBar(
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
          "Profile",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body:Column(
        children: [
          SizedBox(height: 10,),
          Container(
            width: double.maxFinite,
            child: Text("Account informations",style: TextStyle(
              fontSize: 20,


            ),
            textAlign: TextAlign.center,),
          )
          ,
          SizedBox(height: 10,),

          Container(

            width: double.maxFinite,
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Name",style: TextStyle(
                    fontSize: 15
                )),
                Text("",style: TextStyle(
                  fontSize: 15
                ),
                ),
                Icon(Icons.arrow_forward_ios)
              ],
            )
            ,
          ),
          SizedBox(height: 10,),
          Container(
            width: double.maxFinite,
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [

                Text("Email",style: TextStyle(
                    fontSize: 15,

                )),
                Text("Name",style: TextStyle(
                  fontSize: 15
                ),),
                Icon(Icons.arrow_forward_ios)
              ],
            )
            ,
          ),
          SizedBox(height: 10,),
          Container(
            width: double.maxFinite,
            height: 50,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.white,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,

              children: [
                Text("Password",style: TextStyle(
                    fontSize: 15
                )),
                Icon(Icons.arrow_forward_ios)
              ],
            )
            ,
          )
        ],
      )


    );
  }
}
