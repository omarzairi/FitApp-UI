import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class CoachStepperForm extends StatefulWidget {
  final HashMap<String, String> usermap;
  CoachStepperForm({super.key, required this.usermap});


  @override
  State<CoachStepperForm> createState() => _StepsState();
}

class _StepsState extends State<CoachStepperForm> {
  late final HashMap<String, String> _usermap;
  @override
  void initState() {
    super.initState();
    _usermap = widget.usermap;
  }

  int index = 0;
  String _selectedItem = '1/2';
  String _selectItem1 = 'Sedentary';
  String _sex='Male';

  final HashMap<String, String> _map = HashMap<String, String>();





  Future<void> sendFormData() async{

    _map["email"] = _usermap["email"]!;
    _map["password"] = _usermap["password"]!;
    _map["actPhysique"] = _selectItem1;
    _map["poidsSemaine"] = _selectedItem;
    _map["sex"]=_sex;


    final body=jsonEncode(_map);
    final urlUser = Uri.parse('https://fit-app-api.azurewebsites.net/api/users/addUser');
    final urlObj=Uri.parse('https://fit-app-api.azurewebsites.net/api/objectifs/addObjectif');
    final responseUser= await http.post(urlUser,body:{_map["email"]!,_map["password"]!});
    final responseObj= await http.post(urlObj,body:{_map["poidsObj"]!,_map["poidsSemaine"]!,_map["actPhysique"]!});
    print(responseUser.body);
    print(responseObj.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          if(index == 3){
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
            title: const Text("Sex and Age"),
            isActive: index >0,
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
                          _map["sex"] = value;
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
                    decoration: const InputDecoration(labelText: 'Age'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your weight';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      _map["age"] = value;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your weight';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _map["poids"] = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Height (cm)'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your height';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _map["taille"] = value;
                  },
                )
              ],
            ),
            isActive: index > 1,
          ),
          Step(
            title: const Text("Weight objectif and weight per week"),
            isActive: index > 2,
            content: Column(children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Ojectif (kg)'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your objectif';
                  }
                  return null;
                },
                onChanged: (value) {
                  _map["poidsObj"] = value;
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
                      _map["poidsSemaine"] = value;
                    });
                  },
                  dropdownMenuEntries: const [
                    DropdownMenuEntry(value: '0', label: '0 Kg'),
                    DropdownMenuEntry(value: '1/8', label: '1/8 Kg'),
                    DropdownMenuEntry(value: '1/4', label: '1/4 Kg'),
                    DropdownMenuEntry(value: '1/2', label: '1/2 Kg'),
                    DropdownMenuEntry(value: '1', label: '1 Kg'),
                  ],
                ),
              ),
            ]),
          ),
          Step(
            title: const Text("Physical activity"),
            isActive: index > 3,
            content: DropdownMenu(
              initialSelection: _selectItem1,


              width: 300,
              onSelected: (String? value) {
                setState(() {
                  _selectItem1 = value!;
                  _map["actPhysique"] = value;
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
    );
  }
}

