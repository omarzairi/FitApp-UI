import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../models/User.dart';
import '../utils/theme_colors.dart';
import'package:fitapp/Pages/aliment_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/controllers/objectif_controller.dart';
import 'package:fitapp/controllers/progressController.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';




class UserStepperForm extends StatefulWidget {
  final String email;
  final String password;

   UserStepperForm({super.key, required String this.email, required String this.password});


  @override
  State<UserStepperForm> createState() => _StepsState();
}

class _StepsState extends State<UserStepperForm> {
  late  String _email;
  late  String _password;
  @override
  void initState() {
    super.initState();
    _email = widget.email;
    _password = widget.password;
  }

  final TextEditingController nameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController weightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController weightObjController = TextEditingController();
  final TextEditingController weightPerWeekController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final storage = const FlutterSecureStorage();

  int index = 0;
  String _selectedItem = '0.5';
  String _selectItem1 = 'Sedentary';
  String _sex='Male';

  Future<void> sendFormData() async {
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
        final responseUser = await UserController().addUser({
          "nom": lastNameController.text,
          "prenom": nameController.text,
          "email": _email,
          "password": _password,
          "age": int.parse(ageController.text),
          "taille": double.parse(heightController.text),
          "poids": double.parse(weightController.text) ,
          "sex": _sex,
        });


print("user :: ${responseUser?.id}");




        final responseProgress = await ProgressController().addProgress(
            {
              "user": responseUser?.id,
              "listePoids":[
                {
                  "poids":double.parse(weightController.text) ?? 0.0,

                }

              ]
            }

        );



    print("user id ${responseUser?.id}");
        final responseObj = await ObjectifController().addObjectif({
          "poidsObj": double.parse(weightObjController.text),
          "poidsParSemaine": double.parse(_selectedItem),
          "actPhysique": _selectItem1,
          "user": responseUser?.id,
        });
        Navigator.pop(context);

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Account created successfully'),
            backgroundColor: Colors.lightGreen,
            duration: Duration(seconds: 3),),
        );

        Get.offAllNamed('/profile');
      } catch (e) {
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
          content: Text('Please enter valid informations'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );
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
        title: Text("Informations",
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),

      ),
      body: Form(
        key: _formKey,
        child: Stepper(
          currentStep: index,
          onStepCancel: () {
            if (index > 0) {
              setState(() {
                index--;
              });
            }
          },
          onStepContinue: () async {
            if(index == 4){
              await sendFormData();
            }
            else {
              setState(() {
                index++;
              });
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

                      final name = RegExp(r'^[a-zA-Z]+$');
                      if (!name.hasMatch(value)) {
                        return 'Your name should not contain numbers';
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
                        return 'Please enter your name';
                      }

                      final name = RegExp(r'^[a-zA-Z]+$');
                      if (!name.hasMatch(value)) {
                        return 'Your name should not contain numbers';
                      }

                      return null;
                    },

                  )
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
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your age';
                      }

                      final name = RegExp(r'^\d+$');
                      if (!name.hasMatch(value)) {
                        return 'Your age should not contain letters';
                      }

                      return null;
                    },

                  ),


]
            ),
            ),
            Step(
              title: const Text("Weight and Height"),
              content: Column(
                children: [
                  TextFormField(

                    decoration: const InputDecoration(labelText: 'Weight (kg)'),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    controller:weightController ,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }

                      final name = RegExp(r'^\d+$');
                      if (!name.hasMatch(value)) {
                        return 'Your weight should not contain letters';
                      }

                      return null;
                    },

                  ),
                  TextFormField(
                    controller: heightController,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: const InputDecoration(labelText: 'Height (cm)'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your height';
                      }

                      final name = RegExp(r'^\d+$');
                      if (!name.hasMatch(value)) {
                        return 'Your height should not contain letters';
                      }

                      return null;
                    },

                  )
                ],
              ),
              isActive: index > 2,
            ),
            Step(
              title: const Text("Weight objectif and weight per week"),
              isActive: index > 3,
              content: Column(children: [
                TextFormField(
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  controller: weightObjController,
                  decoration: const InputDecoration(labelText: 'Ojectif (kg)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your objectif weight';
                    }

                    final name = RegExp(r'^\d+$');
                    if (!name.hasMatch(value)) {
                      return 'Your objectif weight should not contain letters';
                    }

                    return null;
                  },

                ),
                const SizedBox(height: 16),
                SizedBox(
                  width: double.maxFinite,
                  child: DropdownMenu(
                    initialSelection: _selectedItem,
                    width: 300,
                    onSelected: (String? value) {
                      setState(() {
                        _selectedItem = value!;

                      });
                    },
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: '0', label: '0 Kg'),
                      DropdownMenuEntry(value: '0,125', label: '1/8 Kg'),
                      DropdownMenuEntry(value: '0.25', label: '1/4 Kg'),
                      DropdownMenuEntry(value: '0.5', label: '1/2 Kg'),
                      DropdownMenuEntry(value: '1', label: '1 Kg'),
                    ],
                  ),
                ),
              ]),
            ),
            Step(
              title: const Text("Physical activity"),
              isActive: index > 4,
              content: DropdownMenu(
                 initialSelection: _selectItem1,


                width: 300,
                onSelected: (String? value) {
                  setState(() {
                    _selectItem1 = value!;

                  });
                },
                dropdownMenuEntries: const [
                  DropdownMenuEntry(value: 'Sedentary', label: 'Sedentary'),
                  DropdownMenuEntry(
                      value: 'Moderately active', label: 'Moderately active'),
                  DropdownMenuEntry(value: 'Active', label: 'Active'),
                  DropdownMenuEntry(value: 'Very active', label: 'Very active'),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

