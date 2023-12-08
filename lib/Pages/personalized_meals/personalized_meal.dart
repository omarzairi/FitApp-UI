import 'package:fitapp/Pages/personalized_meals/personalized_meal_details.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitapp/controllers/personalized_meal_controller.dart';

import '../../utils/theme_colors.dart';

class PersonalizedMealScreen extends StatefulWidget {
  @override
  _PersonalizedMealScreenState createState() => _PersonalizedMealScreenState();
}

class _PersonalizedMealScreenState extends State<PersonalizedMealScreen> {
  final PersonalizedMealController personalizedMealController =
      Get.put(PersonalizedMealController());

  @override
  void initState() {
    super.initState();
    if (personalizedMealController.personalizedMealList.isEmpty) {
      personalizedMealController.fetchPersonalizedMeals();
    }
  }

  void createPersonalizedMeal(Map<String, dynamic> mealData) async {
    try {
      personalizedMealController.createPersonalizedMeal(mealData);
      personalizedMealController.fetchPersonalizedMeals();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  removeMeal(String id) async {
    try {
      personalizedMealController.deletePersonalizedMeal(id);
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
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
        title: Text("Personalized Meal",
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),
      ),
      body: Obx(
        () => personalizedMealController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10),
                        child: Text(
                          'Your Meals' +
                              '( ${personalizedMealController.personalizedMealList.length})',
                          style: TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                      SizedBox(width: 100),
                      ElevatedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            // This allows the bottom sheet to take full height
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20.0),
                                topRight: Radius.circular(20.0),
                              ),
                            ),
                            builder: (BuildContext context) {
                              final TextEditingController _nameController =
                                  TextEditingController();
                              return SingleChildScrollView(
                                child: Container(
                                  padding: EdgeInsets.only(
                                      bottom: MediaQuery.of(context)
                                          .viewInsets
                                          .bottom),
                                  // This makes sure the bottom sheet adjusts itself when keyboard appears
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                        vertical: 60, horizontal: 20),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: <Widget>[
                                        Text(
                                          'Create A New Personalized Meal',
                                          style: TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        TextField(
                                          controller: _nameController,
                                          decoration: InputDecoration(
                                            labelText: 'Name',
                                            border: OutlineInputBorder(),
                                          ),
                                        ),
                                        SizedBox(height: 20.0),
                                        ElevatedButton(
                                          onPressed: () {
                                            //create a new personalized meal if the name is not empty
                                            if (_nameController.text != '') {
                                              createPersonalizedMeal({
                                                'name': _nameController.text,
                                                'aliments': [],
                                              });
                                            }
                                            Navigator.pop(context);
                                          },
                                          child: Text(
                                            'Create',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15,
                                            ),
                                          ),
                                          style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStateProperty.all<
                                                        Color>(
                                                    TColor.secondaryColor1),
                                            shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                              RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                              ),
                                            ),
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.symmetric(
                                                    vertical: 15,
                                                    horizontal: 50)),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                              TColor.secondaryColor1),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Icon(Icons.add, color: Colors.white, size: 15),
                            Text(
                              'Create',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.w400,
                                fontFamily: 'Poppins',
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: personalizedMealController
                          .personalizedMealList.length,
                      itemBuilder: (context, index) {
                        var meal = personalizedMealController
                            .personalizedMealList[index];
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    PersonalizedMealDetails(meal: meal),
                              ),
                            );
                          },
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Container(
                                  width: 90,
                                  height: 90,
                                  child: Wrap(
                                    children: (meal.aliments.toList()
                                          ..shuffle())
                                        .take(4)
                                        .toList()
                                        .asMap()
                                        .entries
                                        .map((entry) {
                                      int idx = entry.key;
                                      var aliment = entry.value;
                                      BorderRadius borderRadius;
                                      if (idx == 0) {
                                        borderRadius = BorderRadius.only(
                                            topLeft: Radius.circular(8.0));
                                      } else if (idx == 1) {
                                        borderRadius = BorderRadius.only(
                                            topRight: Radius.circular(8.0));
                                      } else if (idx == 2) {
                                        borderRadius = BorderRadius.only(
                                            bottomLeft: Radius.circular(8.0));
                                      } else {
                                        borderRadius = BorderRadius.only(
                                            bottomRight: Radius.circular(8.0));
                                      }
                                      return ClipRRect(
                                        borderRadius: borderRadius,
                                        child: Image.network(
                                          aliment.image ?? '',
                                          width: 32,
                                          height: 32,
                                          fit: BoxFit.cover,
                                        ),
                                      );
                                    }).toList(),
                                  ),
                                ),
                                title: Text(meal.name),
                                subtitle:
                                    Text('${meal.aliments.length} aliments'),
                                trailing: IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          title: Text('Confirm'),
                                          content: Text(
                                              'Are you sure you want to delete this meal?'),
                                          actions: <Widget>[
                                            TextButton(
                                              child: Text('Cancel'),
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                            TextButton(
                                              child: Text('Delete'),
                                              onPressed: () async {
                                                await removeMeal(meal.id);
                                                setState(() {
                                                  personalizedMealController
                                                      .personalizedMealList
                                                      .removeWhere((element) =>
                                                          element.id ==
                                                          meal.id);
                                                });
                                                Navigator.of(context).pop();
                                              },
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
