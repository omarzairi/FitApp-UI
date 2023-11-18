import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/User.dart';
import 'package:fitapp/utils/theme_colors.dart';


class ProfileUser extends StatefulWidget {
  const ProfileUser({super.key});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}


class _ProfileUserState extends State<ProfileUser> {




  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    User? user = userController.user;


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
      body:
      SingleChildScrollView(
        child: Column(
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
            SizedBox(height: 30,),

        GetBuilder<UserController>(
          builder: (controller) {
            User? user = controller.user;

            return ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
              ),
              onPressed: () {
                Get.toNamed('/changeusername');
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Name",
                    style: TextStyle(fontSize: 15),
                  ),
                  Text(
                    '${user?.prenom} ${user?.nom}',
                    style: TextStyle(fontSize: 15),
                  ),
                  Icon(Icons.arrow_forward_ios),
                ],
              ),
            );
          },
        ),
            SizedBox(height: 30,),
            ElevatedButton(

              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () {  Get.toNamed('/changemail');},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Email",style: TextStyle(
                      fontSize: 15
                  )),
                  Text('${user?.email}',style: TextStyle(
                      fontSize: 15
                  ),
                  ),
                  Icon(Icons.arrow_forward_ios)
                ],
              )
              ,
            ),
            SizedBox(height: 30,),
            ElevatedButton(

              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () { Get.toNamed('/changepassword'); },
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
            ),
            SizedBox(height: 100,),
            ElevatedButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),

                  ),
                ),
              ),
              onPressed: () async {


              },
              child:Text("Delete account",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 15,
                  color: Colors.red
              ),)
            ),

          ],
        ),
      )


    );
  }
}
