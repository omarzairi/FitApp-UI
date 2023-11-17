import 'dart:convert';

import 'package:fitapp/controllers/aliment_controller.dart';
import 'package:fitapp/models/Aliment.dart';
import 'package:fitapp/common_widgets/meal_category_cell.dart';
import 'package:fitapp/common_widgets/meal_row.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'alimentDetails.dart';

class AlimentListPage extends StatefulWidget {
  String? mealType = Get.arguments;
  AlimentListPage({super.key});

  @override
  _AlimentListPageState createState() => _AlimentListPageState();
}

class _AlimentListPageState extends State<AlimentListPage> {
  AlimentController alimentController = AlimentController();
  TextEditingController txtSearch = TextEditingController();
  final storage = FlutterSecureStorage();
  List categoryArr = [
    {
      "name": "Salad",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/c_4.png",
    },
    {
      "name": "Salad",
      "image": "assets/img/c_1.png",
    },
    {
      "name": "Cake",
      "image": "assets/img/c_2.png",
    },
    {
      "name": "Pie",
      "image": "assets/img/c_3.png",
    },
    {
      "name": "Smoothies",
      "image": "assets/img/c_4.png",
    },
  ];

  Future<String?> readToken() async {
    return await storage.read(key: 'userToken');
  }
  void _onAlimentAdded(int index) {
    var aliment = alimentController.getAliment(index);
    alimentController.addAlimentToConsumption(
        '6551066650ca084d25a703fa', aliment.id, 1);
  }

  Future<void> initData() async {
    await readToken().then((userToken) {
      print('User Token: $userToken');
    });

    // Fetch data using controller
    alimentController.fetchAliments();
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  String formatNumber(double num) {
    return num % 1 == 0 ? num.toInt().toString() : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    final AlimentController alimentController = Get.put(AlimentController());
    var media = MediaQuery.of(context).size;
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
        title: Text(widget.mealType??"",
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
      backgroundColor: TColor.lightGray,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: txtSearch,
                    decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Icon(Icons.search,
                            color: TColor.gray.withOpacity(0.5), size: 20),
                        hintText: "Search Pancake"),
                  )),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 25,
                    color: TColor.gray.withOpacity(0.3),
                  ),
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
                        Icons.filter_list,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Categories",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 120,
              child: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryArr.length,
                  itemBuilder: (context, index) {
                    var cObj = categoryArr[index] as Map? ?? {};
                    return MealCategoryCell(
                      cObj: cObj,
                      index: index,
                    );
                  }),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recommendations",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
                // Wrap your Column with a Container
                constraints: BoxConstraints(
                  minHeight: media.height * 0.5,
                  maxHeight: double.infinity,
                ),
                height: media.height * 1.5,
                // Adjust the height as needed
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Expanded(
                        child: Obx(
                          () {
                            if (alimentController.isLoading.value) {
                              return Center(child: CircularProgressIndicator());
                            } else {
                              return ListView.builder(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15.0),
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: alimentController.alimentList.length,
                                itemBuilder: (context, index) {
                                  return InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                AlimentDetails(index: index),
                                          ),
                                        );
                                      },
                                      child: Obx(
                                        () => MealRow(
                                          aliment: alimentController
                                              .getAliment(index),
                                          selected: alimentController
                                              .selectedAliments[index],
                                          onTap: () {
                                            alimentController
                                                .toggleSelection(index);
                                          },
                                        ),
                                      ));
                                },
                              );
                            }
                          },
                        ),
                      )
                    ]))
          ],
        ),
      ),
      floatingActionButton: Obx(
        () => alimentController.selectedAliments.contains(true)
            ? FloatingActionButton.extended(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                backgroundColor: TColor.secondaryColor1,
                onPressed: () {
                  for (int i = 0;
                      i < alimentController.selectedAliments.length;
                      i++) {
                    if (alimentController.selectedAliments[i]) {
                      _onAlimentAdded(i);
                    }
                  }
                  alimentController.clearSelection();

                },
                label: Text(
                    'Add (${alimentController.selectedAliments.where((b) => b).length})',
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'Poppins')),
                icon: const Icon(Icons.check,
                    color: Colors.white, size: 20), // Changed color here
              )
            : Container(), // Return an empty Container when FloatingActionButton is null
      ),
    );
  }
}
