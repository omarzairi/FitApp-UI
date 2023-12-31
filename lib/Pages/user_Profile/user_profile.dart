import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/User.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:fitapp/controllers/objectif_controller.dart';

import '../../models/Objectif.dart';
import '../homepage/footer.dart';


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
    ObjectifController objectifController = Get.find<ObjectifController>();
    Objectif? objectif = objectifController.objectif;


    Future<void> _showConfirmationDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirmation'),
            content: Text('Are you sure you want to delete your account?'),
            actions: <Widget>[
              TextButton(
                onPressed: () {

                  Navigator.of(context).pop();
                },
                child: Text('No'),
              ),
              TextButton(
                onPressed: () async {
                  try {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      },
                    );

                    await userController.deleteUser(user?.id as String);
                    Navigator.pop(context);
                    Get.offAllNamed('/');
                  }catch(e){
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('An error has occurred'),
                        backgroundColor: Colors.redAccent,
                        duration: Duration(seconds: 3),
                      ),
                    );
                  }

                },
                child: Text('Yes'),
              ),

            ],
          );
        },
      );
    }


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

            return TextButton(

              style: ButtonStyle(
                side: MaterialStateProperty.all<BorderSide>(
                  BorderSide.none, // Ensure that the border is explicitly set to none
                ),

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
                    style: TextStyle(fontSize: 15,
                      color: Colors.black,),
                  ),
                  Text(
                    '${user?.prenom} ${user?.nom}',
                    style: TextStyle(fontSize: 15,color: Colors.black,),
                  ),
                  Icon(Icons.arrow_forward_ios,color: Colors.black,),
                ],
              ),
            );
          },
        ),
            SizedBox(height: 20,),
            TextButton(

              style: ButtonStyle(

                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () {  Get.toNamed('/changemail');},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Email",style: TextStyle(
                      fontSize: 15,
                    color: Colors.black,
                  )),
                  Text('${user?.email}',style: TextStyle(
                      fontSize: 15,
                    color: Colors.black,
                  ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: Colors.black,)
                ],
              )
              ,
            ),SizedBox(height: 20,),
            TextButton(

              style: ButtonStyle(

                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () {  Get.toNamed('/currentweight');},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Current weight",style: TextStyle(
                      color: Colors.black,
                      fontSize: 15
                  )),
                  Text('${user?.poids} kg',style: TextStyle(
                    color: Colors.black,
                      fontSize: 15
                  ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: Colors.black,)
                ],
              )
              ,
            ),SizedBox(height: 20,),
            TextButton(

              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () {  Get.toNamed('/targetweight');},
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Target weight",style: TextStyle(
                      fontSize: 15,
                    color: Colors.black,
                  )),
                  Text('${objectif?.poidsObj} kg',style: TextStyle(color: Colors.black,
                      fontSize: 15
                  ),
                  ),
                  Icon(Icons.arrow_forward_ios,color: Colors.black,)
                ],
              )
              ,
            ),SizedBox(height: 20,),


            TextButton(

              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.white),

              ),
              onPressed: () { Get.toNamed('/changepassword'); },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [
                  Text("Password",style: TextStyle(
                      fontSize: 15,
                    color: Colors.black,
                  )),

                  Icon(Icons.arrow_forward_ios,color: Colors.black,)
                ],
              ),

            ),
            SizedBox(height: 50,),
            TextButton(
              style: ButtonStyle(
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.all(15)),
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                    side: BorderSide(color: Colors.red),

                  ),
                ),
              ),
              onPressed: () async {

                _showConfirmationDialog(context);

              },
              child:Text("Delete account",textAlign: TextAlign.center,style: TextStyle(
                  fontSize: 15,
                  color: Colors.white
              ),)
            ),

          ],
        ),
      ),
        bottomNavigationBar: Footer(
          selectTab: 3,
        )


    );
  }
}
