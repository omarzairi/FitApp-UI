import 'package:fitapp/controllers/personalized_meal_controller.dart';
import 'package:fitapp/models/Aliment.dart';
import 'package:fitapp/models/PersonalizedMeal.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../controllers/aliment_controller.dart';
import '../alimentDetails.dart';

class PersonalizedMealDetails extends StatefulWidget {
  final PersonalizedMeal meal;

  const PersonalizedMealDetails({Key? key, required this.meal})
      : super(key: key);

  @override
  _PersonalizedMealDetailsState createState() =>
      _PersonalizedMealDetailsState();
}

class _PersonalizedMealDetailsState extends State<PersonalizedMealDetails> {
  late PersonalizedMeal _meal;
  final PersonalizedMealController _mealController = Get.find();
  final AlimentController _alimentController = Get.put(AlimentController());

  @override
  void initState() {
    super.initState();
    _meal = widget.meal;
    _alimentController.fetchAliments();
  }

  void removeAlimentFromMeal(Aliment aliment) {
    setState(() {
      _meal.aliments.remove(aliment);
    });
    _mealController.updatePersonalizedMeal(_meal.id, _meal.toJson());
  }

  void addAlimentToMeal(Aliment aliment) {
    setState(() {
      _meal.aliments.add(aliment);
    });
    _mealController.updatePersonalizedMeal(_meal.id, _meal.toJson());
  }

  @override
  Widget build(BuildContext context) {
    final AlimentController _alimentController = Get.put(AlimentController());
    var media = MediaQuery.of(context).size;

    double totalCalories =
        _meal.aliments.fold(0, (sum, aliment) => sum + aliment.calories);
    double totalProtein =
        _meal.aliments.fold(0, (sum, aliment) => sum + aliment.protein);
    double totalCarbs =
        _meal.aliments.fold(0, (sum, aliment) => sum + aliment.carbs);
    double totalFat =
        _meal.aliments.fold(0, (sum, aliment) => sum + aliment.fat);
    double totalSugar =
        _meal.aliments.fold(0, (sum, aliment) => sum + aliment.sugar);

    List<Aliment> randomAliments =
        (_meal.aliments.toList()..shuffle()).take(4).toList();

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
        title: Text(_meal.name,
            style: TextStyle(
              color: TColor.black,
              fontSize: 20,
              letterSpacing: 1,
              fontWeight: FontWeight.w500,
            )),
        actions: [
          InkWell(
            onTap: () {},
            child: Container(
              margin: const EdgeInsets.all(8),
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: TColor.lightGray,
                  borderRadius: BorderRadius.circular(10)),
              child: Icon(
                Icons.more_horiz,
                color: TColor.black,
                size: 20,
              ),
            ),
          )
        ],
      ),
      body: Stack(
        children: [
          Positioned.fill(
            child: GridView.count(
              crossAxisCount: 2,
              children: randomAliments.map((aliment) {
                return Image.network(
                  aliment.image ?? '',
                  fit: BoxFit.cover,
                );
              }).toList(),
            ),
          ),
          Positioned(
            top: MediaQuery.of(context).size.height * 0.35,
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 3,
                    blurRadius: 10,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            padding: EdgeInsets.only(left: 10),
                            child: Text(
                              'Your Aliments' + '( ${_meal.aliments.length})',
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
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20.0),
                                    topRight: Radius.circular(20.0),
                                  ),
                                ),
                                builder: (BuildContext context) {
                                  final TextEditingController _nameController =
                                      TextEditingController();
                                  return StatefulBuilder(
                                    builder: (BuildContext context,
                                        StateSetter setState) {
                                      return SingleChildScrollView(
                                        child: Container(
                                          padding: EdgeInsets.only(
                                              bottom: MediaQuery.of(context)
                                                  .viewInsets
                                                  .bottom),
                                          child: Container(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 60, horizontal: 20),
                                            child: Obx(() {
                                              List<Aliment> allAliments =
                                                  _alimentController
                                                      .alimentList;
                                              List<Aliment> alimentsNotInMeal =
                                                  allAliments
                                                      .where((aliment) => !_meal
                                                          .aliments
                                                          .contains(aliment))
                                                      .toList();
                                              return Column(
                                                children: [
                                                  Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 10,
                                                            horizontal: 20),
                                                    decoration: BoxDecoration(
                                                      color: TColor.lightGray,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10),
                                                    ),
                                                    child: TextField(
                                                      controller:
                                                          _nameController,
                                                      decoration:
                                                          InputDecoration(
                                                        hintText:
                                                            'Search for an aliment',
                                                        hintStyle: TextStyle(
                                                          color: TColor.black,
                                                          fontSize: 15,
                                                          fontWeight:
                                                              FontWeight.w300,
                                                        ),
                                                        border:
                                                            InputBorder.none,
                                                        prefixIcon: Icon(
                                                          Icons.search,
                                                          color: TColor.black,
                                                        ),
                                                      ),
                                                      onChanged: (value) {
                                                        if (value.isNotEmpty) {
                                                          _alimentController
                                                              .searchAlimentwithQuery({
                                                            "name": value
                                                          });
                                                        } else {
                                                          _alimentController
                                                              .fetchAliments();
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                  SizedBox(height: 20),
                                                  Container(
                                                    height: 400,
                                                    child: ListView.builder(
                                                      itemCount:
                                                          alimentsNotInMeal
                                                              .length,
                                                      itemBuilder:
                                                          (context, index) {
                                                        Aliment aliment =
                                                            alimentsNotInMeal[
                                                                index];
                                                        return MealRow(
                                                          key: UniqueKey(),
                                                          aliment: aliment,
                                                          icon: Icon(
                                                            Icons.add,
                                                            color: Colors.green,
                                                          ),
                                                          selected: false,
                                                          onTap: () {
                                                            addAlimentToMeal(
                                                                aliment);
                                                            setState(() {
                                                              alimentsNotInMeal
                                                                  .remove(
                                                                      aliment);
                                                            });
                                                          },
                                                        );
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              );
                                            }),
                                          ),
                                        ),
                                      );
                                    },
                                  );
                                },
                              );
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  TColor.secondaryColor1),
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
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
                                  'Add',
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
                      Container(
                        height: 200, // Adjust the height as needed
                        child: ListView.builder(
                          itemCount: _meal.aliments.length,
                          itemBuilder: (context, index) {
                            Aliment aliment = _meal.aliments[index];
                            return MealRow(
                              key: UniqueKey(),
                              // Add a unique key
                              aliment: aliment,
                              icon: Icon(Icons.delete, color: Colors.red),
                              selected: false,
                              // Update this as needed
                              onTap: () => removeAlimentFromMeal(aliment),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "Nutrition facts",
                        style: TextStyle(
                            color: TColor.black,
                            fontSize: 16,
                            fontFamily: 'Poppins',
                            letterSpacing: 1,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: _meal.aliments.length,
                            itemBuilder: (context, index) {
                              Aliment aliment = _meal.aliments[index];
                              return InkWell(
                                onTap: () => removeAlimentFromMeal(aliment),
                                child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8, horizontal: 4),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(
                                          colors: [
                                            TColor.primaryColor2
                                                .withOpacity(0.4),
                                            TColor.primaryColor1
                                                .withOpacity(0.4)
                                          ],
                                        ),
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${aliment.name}: ${aliment.calories}',
                                            style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 14,
                                            ),
                                          ),
                                        )
                                      ],
                                    )),
                              );
                            }),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Analysis of the nutrition facts",
                              style: TextStyle(
                                  color: TColor.black,
                                  fontSize: 16,
                                  fontFamily: 'Poppins',
                                  letterSpacing: 0.9,
                                  fontWeight: FontWeight.w700),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      PieChartSample2(
                        calories: totalCalories,
                        protein: totalProtein,
                        carbs: totalCarbs,
                        fat: totalFat,
                        sugar: totalSugar,
                      ),
                      SizedBox(
                        height: media.width * 0.25,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MealRow extends StatelessWidget {
  final Aliment aliment;
  final bool selected;
  final Icon icon;
  final VoidCallback onTap;

  const MealRow({
    Key? key,
    required this.aliment,
    required this.selected,
    required this.icon,
    required this.onTap,
  }) : super(key: key);

  String formatNumber(double num) {
    return num % 1 == 0 ? num.toInt().toString() : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 2),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: TColor.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 2)],
        ),
        child: Row(
          children: [
            Container(
              width: 65,
              height: 65,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 6,
                  ),
                ],
                image: DecorationImage(
                  image: NetworkImage(aliment.image ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(
              width: 15,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    aliment.name,
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    "${formatNumber(aliment.calories)} calories | ${formatNumber(aliment.servingSize)} ${aliment.servingUnit}",
                    style: TextStyle(color: TColor.gray, fontSize: 12),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: onTap,
              child: Padding(
                  padding: const EdgeInsets.all(10.0), child: this.icon),
            ),
          ],
        ),
      ),
    );
  }
}
