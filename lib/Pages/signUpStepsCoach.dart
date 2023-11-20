import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:fitapp/models/Coach.dart';
import 'package:fitapp/controllers/coach_controller.dart';
import 'package:get/get.dart';

class SignUpStepsCoach extends StatefulWidget {
  final String email;
  final String password;

  SignUpStepsCoach({required this.email, required this.password});

  @override
  State<SignUpStepsCoach> createState() => _SignUpStepsCoachState();
}

class _SignUpStepsCoachState extends State<SignUpStepsCoach> {
  late String _email;
  late String _password;

  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _password = widget.password;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController sexController = TextEditingController();

  int index = 0;
  String _sex='Male';

  Future<void> sendFormData() async {
    try {
      await CoachController().addCoach({
        "nom": nameController.text,
        "prenom": lastNameController.text,
        "email": _email,
        "password": _password,
        "sex": _sex,
        "age": int.parse(ageController.text),
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully'),
          backgroundColor: Colors.lightGreen,
          duration: Duration(seconds: 3),
        ),
      );

      // Navigate to the desired screen after successful signup
      Get.offAllNamed('/loginCoach');
    } catch (e) {
      print('Error in sendFormData: $e');
      // Handle the error as needed.
    }
  }

  @override
  Widget build(BuildContext context) {
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
                borderRadius: BorderRadius.circular(10)),
            child: Icon(
              Icons.arrow_back_ios_new,
              color: TColor.black,
              size: 20,
            ),
          ),
        ),
        title: Text(
          "Informations",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Stepper(
        currentStep: index,
       onStepCancel: () {
  if (index > 0) {
    setState(() {
      index--;
    });
  }
},
onStepContinue: () async {
  if (index < 1) {
    setState(() {
      index++;
    });
  } else if (index == 1) {
    // Add any additional validation if needed
    await sendFormData();
  }
},
        onStepTapped: (int indexStep) {
          setState(() {
            index = indexStep;
          });
        },
        steps: <Step>[
          Step(
            title: const Text("Name and Last Name"),
            content: Column(
              children: [
                TextFormField(
                  controller: nameController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: lastNameController,
                  decoration: const InputDecoration(labelText: 'Last name'),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                ),
              ],
            ),
            isActive: index > 0,
          ),
            Step(
            title: const Text("Sex and Age"),
            isActive: index >1,
            content: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownMenu(
                    width: 300,
                    initialSelection: _sex,
                    onSelected: (String? value) {
                      setState(() {
                        _sex = value!;

                      });
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(
                          value: 'Male', label: 'Male'),
                      DropdownMenuEntry(value: 'Female', label: 'Female'),


                    ],
                  ),
                ),
                TextFormField(
                  controller: ageController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Age'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Age';
                    }
                    return null;
                  },

                ),
]
          ),
          ),
        ],
      ),
    );
  }
}
