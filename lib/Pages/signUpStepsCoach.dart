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
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController yearsOfExperience = TextEditingController();
  final TextEditingController specialityController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController phoneNumber = TextEditingController();

  int index = 0;
  String _sex = 'Male';

  Future<void> sendFormData() async {
    try {
      await CoachController().addCoach({
        "nom": nameController.text,
        "prenom": lastNameController.text,
        "email": _email,
        "password": _password,
        "sex": _sex,
        "age": int.tryParse(ageController.text) ?? 0,
        "description": descriptionController.text,
        "yearsOfExperience": int.tryParse(yearsOfExperience.text) ?? 0,
        "speciality": specialityController.text,
        "price": int.tryParse(priceController.text) ?? 0,
        "phoneNumber": phoneNumber.text,
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
          if (index < 4) {
            setState(() {
              index++;
            });
          } else if (index == 4) {
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
            isActive: index > 1,
            content: Column(
              children: [
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownButton<String>(
                    value: _sex,
                    onChanged: (String? value) {
                      setState(() {
                        _sex = value!;
                      });
                    },
                    items: const [
                      DropdownMenuItem<String>(
                        value: 'Male',
                        child: Text('Male'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Female',
                        child: Text('Female'),
                      ),
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
              ],
            ),
          ),
          Step(
            title: const Text("Specialty and Years of Experience"),
            isActive: index > 2,
            content: Column(
              children: [
                TextFormField(
                  controller: specialityController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Specialty'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Specialty';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: yearsOfExperience,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Years of Experience'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Years of Experience';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Step(
            title: const Text("Price and Phone Number"),
            isActive: index > 3,
            content: Column(
              children: [
                TextFormField(
                  controller: priceController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Price'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Price';
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: phoneNumber,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Phone Number';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
          Step(
            title: const Text("Description"),
            isActive: index > 4,
            content: Column(
              children: [
                TextFormField(
                  controller: descriptionController,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your Description';
                    }
                    return null;
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
