import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/User.dart';
import 'package:fitapp/utils/theme_colors.dart';

class ChangeName extends StatefulWidget {
  const ChangeName({super.key});

  @override
  State<ChangeName> createState() => _ChangeNameState();
}

class _ChangeNameState extends State<ChangeName> {
  TextEditingController name = TextEditingController();
  TextEditingController lastname = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    User? user = userController.user;

    Future<void> updateUser() async {
      if (_formKey.currentState!.validate()) {
        try {
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
            {
              "prenom": name.text,
              "nom": lastname.text,
            } as Map<String, dynamic>,
          );
          Navigator.pop(context);
          print('name User : ${user?.prenom}');
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Name changed successfully'),
              backgroundColor: Colors.lightGreen,
              duration: Duration(seconds: 3),
            ),
          );

          Get.offAllNamed('/profile');
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('An error has occurred  '),
              backgroundColor: Colors.redAccent,
              duration: Duration(seconds: 3),
            ),
          );
          print('Error in sendFormData: $e');
          // Handle the error as needed.
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid name'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    name.text = user?.prenom ?? '';
    lastname.text = user?.nom ?? '';

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
          "Edit name",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Container(
        margin: EdgeInsets.all(20),
        width: double.maxFinite,
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20,
              ),
              Text(
                "Name",
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                controller: name,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }

                  final name = RegExp(r'^[a-zA-Z]+$');
                  if (!name.hasMatch(value)) {
                    return 'Your name should not contain numbers';
                  }

                  return null;
                },
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                "LastName",
                textAlign: TextAlign.end,
              ),
              SizedBox(
                height: 20,
              ),
              TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: lastname,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }

                    final name = RegExp(r'^[a-zA-Z]+$');
                    if (!name.hasMatch(value)) {
                      return 'Your name should not contain numbers';
                    }

                    return null;
                  }),
              SizedBox(
                height: 40,
              ),
              ElevatedButton(
                onPressed: () {
                  updateUser();
                },
                child: Text("Confirm", style: TextStyle(color: Colors.white)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
