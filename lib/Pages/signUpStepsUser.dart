import 'dart:collection';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import '../utils/theme_colors.dart';
import'package:fitapp/Pages/aliment_list.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';


class UserStepperForm extends StatefulWidget {
  final HashMap<String, String> usermap;
   UserStepperForm({super.key, required this.usermap});


  @override
  State<UserStepperForm> createState() => _StepsState();
}

class _StepsState extends State<UserStepperForm> {
  late final HashMap<String, String> _usermap;
  @override
  void initState() {
    super.initState();
    _usermap = widget.usermap;
  }

  int index = 0;
  String _selectedItem = '0.5';
  String _selectItem1 = 'Sedentary';
  String _sex='Male';

  final HashMap<String, String> _map = HashMap<String, String>();





  Future<void> sendFormData() async {
    try {
      _map["email"] = _usermap["email"]!;
      _map["password"] = _usermap["password"]!;
      _map["actPhysique"] = _selectItem1;
      _map["poidsSemaine"] = _selectedItem;
      _map["sex"] = _sex;

      final urlUser = Uri.parse('http://10.0.2.2:5000/api/users/addUser');
      final urlObj = Uri.parse('http://10.0.2.2:5000/api/objectifs/addObjectif');
      final userBody = jsonEncode({
        'nom': _map["nom"],
        'prenom': _map["prenom"],
        'email': _map["email"]!,
        'password': _map["password"]!,
        'age': int.parse(_map["age"]!),
        'sex': _map["sex"],
        'poids': int.parse(_map["poids"]!),
        'taille': int.parse(_map["taille"]!),
      });

      final responseUser = await http.post(
        urlUser,
        headers: {'Content-Type': 'application/json'},
        body: userBody,
      );

      if (responseUser.statusCode != 200) {
        // Handle HTTP error
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${jsonDecode(responseUser.body)['message']}'),
            duration: Duration(seconds: 3),
          ),
        );
      }

      final user = jsonDecode(responseUser.body);
      final objBody = jsonEncode({
        'user': user['_id'],
        'poidsObj': int.parse(_map["poidsObj"]!),
        'poidsParSemaine': double.parse(_map["poidsSemaine"]!),
        'actPhysique': _map["actPhysique"],
      });

      final responseObj = await http.post(
        urlObj,
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ' + user['token'],
        },
        body: objBody,
      );

      if (responseObj.statusCode != 200) {
        // Handle HTTP error for the second request
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${jsonDecode(responseObj.body)['message']}'),
            duration: Duration(seconds: 3),
          ),
        );
      }
      else{
        final storage = new FlutterSecureStorage();
        await storage.write(key: 'userToken', value: user['token']);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Account created successfully'),
            duration: Duration(seconds: 3),
          ),
        );
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AlimentListPage(mealType:"breakfast" ,)),

        );
      }

      print(responseObj.body);
    } catch (e) {
      // Handle other types of errors
      print('An error occurred: $e');
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
                  decoration: const InputDecoration(labelText: 'Name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _map["prenom"] = value;
                  },
                ),
                TextFormField(
                  decoration: const InputDecoration(labelText: 'Last name'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your last name';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    _map["nom"] = value;
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
            isActive: index > 2,
          ),
          Step(
            title: const Text("Weight objectif and weight per week"),
            isActive: index > 3,
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

