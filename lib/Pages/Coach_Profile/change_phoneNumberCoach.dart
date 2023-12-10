import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitapp/controllers/coach_controller.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:fitapp/utils/theme_colors.dart';

class ChangePhoneNumber extends StatefulWidget {
  const ChangePhoneNumber({Key? key}) : super(key: key);

  @override
  State<ChangePhoneNumber> createState() => _ChangePhoneNumberState();
}

class _ChangePhoneNumberState extends State<ChangePhoneNumber> {
  TextEditingController phoneNumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    CoachController coachController = Get.find<CoachController>();
    Coach? coach = coachController.coach;

    Future<void> updateCoach() async {
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

          await CoachController().updateCoach(
            coach?.id as String,
            {"phoneNumber": phoneNumber.text} as Map<String, dynamic>,
          );

          // Dismiss loading indicator
          Navigator.pop(context);

          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Phone number changed successfully'),
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
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please enter a valid phone number'),
            backgroundColor: Colors.redAccent,
            duration: Duration(seconds: 3),
          ),
        );
      }
    }

    phoneNumber.text = coach?.phoneNumber as String ;

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
          "Edit Phone Number",
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
              SizedBox(height: 20),
              Text("Phone Number", textAlign: TextAlign.end),
              SizedBox(height: 20),
              TextFormField(
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }

                  final phoneNumberRegex = RegExp(r'^[0-9]{8}$');
                  if (!phoneNumberRegex.hasMatch(value)) {
                    return 'Please enter a valid phone number';
                  }

                  return null;
                },
                controller: phoneNumber,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  updateCoach();
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
