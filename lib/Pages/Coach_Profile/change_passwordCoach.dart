import 'package:flutter/material.dart';

import 'package:get/get.dart';


import 'package:fitapp/controllers/coach_controller.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:fitapp/utils/theme_colors.dart';

class ChangePasswordCoach extends StatefulWidget {
  const ChangePasswordCoach({super.key});

  @override
  State<ChangePasswordCoach> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePasswordCoach> {
  TextEditingController oldpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    CoachController coachController = Get.find<CoachController>();
    Coach? coach = coachController.coach;
    Future<void> updatePassword() async {
      if(_formKey.currentState!.validate()) {
        try {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return Center(
                child: CircularProgressIndicator(),
              );
            },
          );

          await CoachController().changePassword(
              coach?.id as String,
              {
                "oldPassword": oldpassword.text,
                "newPassword": newpassword.text,

              }
          );
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Password changed successfully'),
              backgroundColor: Colors.lightGreen,
              duration: Duration(seconds: 3),
            ),
          );

          Get.offAllNamed('/ProfileCoach');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Wrong password'),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
            ),
          );
          print('Error in sendFormData: $e');
          // Handle the error as needed.
        }
      }
      else{
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid password'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
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
          "Edit password",
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
        child: Container(
          margin: EdgeInsets.all(20),
          width: double.maxFinite,

          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 20,),
                Text("Old password",textAlign: TextAlign.end,),
                SizedBox(height: 20,),

                TextFormField(
                    controller: oldpassword,
                    obscureText: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    )


                ),SizedBox(height: 20,),
                Text("New password",textAlign: TextAlign.end,),
                SizedBox(height: 20,),

                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your password';
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },
                  controller: newpassword,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),

                  obscureText: true,


                ),
                SizedBox(height: 40,),
                ElevatedButton(onPressed: (){
                  updatePassword();
                }, child: Text("Confirm",style: TextStyle(color: Colors.white)),)
              ],
            ),
          ),
        ),
      )

      ,

    );
  }
}
