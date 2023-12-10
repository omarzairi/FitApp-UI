import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:fitapp/controllers/coach_controller.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:fitapp/controllers/objectif_controller.dart';

import '../../models/Objectif.dart';
import '../homepage/footer.dart';


class ProfileCoach extends StatefulWidget {
  const ProfileCoach({super.key});

  @override
  State<ProfileCoach> createState() => _ProfileCoachState();
}


class _ProfileCoachState extends State<ProfileCoach> {




  @override
  Widget build(BuildContext context) {

    CoachController coachController = Get.find<CoachController>();
    Coach? coach = coachController.coach;
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

                    await coachController.deleteCoach(coach.id as String);
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

              GetBuilder<CoachController>(
                builder: (controller) {
                  Coach? coach = controller.coach;

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
                          '${coach?.prenom} ${coach?.nom}',
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
                onPressed: () {  Get.toNamed('/ChangeEmailCoach');},
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  children: [
                    Text("Email",style: TextStyle(
                      fontSize: 15,
                      color: Colors.black,
                    )),
                    Text('${coach?.email}',style: TextStyle(
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
