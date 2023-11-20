import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/User.dart';
import 'package:fitapp/utils/theme_colors.dart';

class ChangeMail extends StatefulWidget {
  const ChangeMail({super.key});

  @override
  State<ChangeMail> createState() => _ChangeMailState();
}

class _ChangeMailState extends State<ChangeMail> {
  TextEditingController email = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    User? user = userController.user;

    Future<void> updateUser() async {
      if(_formKey.currentState!.validate())
        {
          try {
            // Show loading indicator
            showDialog(
              context: context,
              builder: (BuildContext context) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              },
            );

            await UserController().updateUser(
              user?.id as String,
              {"email": email.text} as Map<String, dynamic>,
            );

            // Dismiss loading indicator
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Email changed successfully'),
                backgroundColor: Colors.lightGreen,
                duration: Duration(seconds: 3),
              ),
            );

            Get.offAllNamed('/profile');
          } catch (e) {
            // Dismiss loading indicator in case of an error
            Navigator.pop(context);

            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('An error has occurred'),
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
            content: Text('Please enter a valid email'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );

      }

    }

    email.text = user?.email ?? '';

    return Scaffold(
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
          "Edit email",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        width: double.maxFinite,
        margin: EdgeInsets.all(20),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20,),
              Text("Email", textAlign: TextAlign.end,),
              SizedBox(height: 20,),
              TextFormField(

                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email address';
                  }

                  final emailRegex =
                  RegExp(r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$');
                  if (!emailRegex.hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }

                  return null;
                },
                controller: email,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40,),
              ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                child: Text("Confirm", style: TextStyle(color: Colors.white)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
