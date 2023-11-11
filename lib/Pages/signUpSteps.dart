import 'dart:collection';

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
  final HashMap<String, String> _map = HashMap<String, String>();

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
      onStepContinue: () {
        setState(() {
          index++;
        });
      },
      onStepTapped: (int indexStep) {
        setState(() {
          index = indexStep;
        });
      },
      steps: <Step>[
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
          isActive: index > 0,
        ),
        Step(
          title: const Text("Weight objectif and weight per week"),
          isActive: index > 1,
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
          isActive: index > 2,
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
