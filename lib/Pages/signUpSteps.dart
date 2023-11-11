import 'dart:collection';
import 'dart:convert';

import 'package:flutter/material.dart';

class UserStepperForm extends StatefulWidget {
  const UserStepperForm({super.key});

  @override
  State<UserStepperForm> createState() => _StepsState();
}

class _StepsState extends State<UserStepperForm> {

  int index = 0;
  String _selectedItem = '1/2';
  String _selectItem1 = 'Sedentary';
  String _sex='Male';
  String _age='18';
  final HashMap<String, String> _map = HashMap<String, String>();


  Future<void> SendFormData() async{
    _map["actPhysique"] = _selectItem1;
    _map["poidsSemaine"] = _selectedItem;
    _map["sex"]=_sex;


    final body=jsonEncode(_map);
    print(body);
  }

  @override
  Widget build(BuildContext context) {
    return Stepper(
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
          await SendFormData();
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
                  _map["poids"] = value;
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
    );
  }
}

