import 'dart:convert';
import 'package:fitapp/controllers/aliment_controller.dart';
import 'package:fitapp/models/Aliment.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:get/get.dart';

import '../common_widgets/round_button.dart';
import '../utils/theme_colors.dart';

class PieChartSample2 extends StatelessWidget {
  final double calories ;
  final double protein;
  final double carbs;
  final double fat;
  final double sugar;

   PieChartSample2({
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
  });

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.8,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Expanded(
            child: PieChart(
              PieChartData(
                sectionsSpace: 0,
                centerSpaceRadius: 50,
                startDegreeOffset: 0,
                sections: showingSections(),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Indicator(color: Color(0xffEEA4CE), text: 'Calories'),
              Indicator(color: Color(0xffC58BF2), text: 'Protein'),
              Indicator(color: Color(0xff9DCEFF), text: 'Carbs'),
              Indicator(color: Color(0xff92A3FD), text: 'Fat'),
              Indicator(color: Color(0x9BDABFFF), text: 'Sugar'),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {

    return [
      PieChartSectionData(
        color:  const Color(0xffEEA4CE),
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        value: calories,
        radius: 50.0,
      ),
      PieChartSectionData(
        color: const Color(0xffC58BF2),
        value: protein,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),

        radius: 50.0,
      ),
      PieChartSectionData(
        color: const Color(0xff9DCEFF),
        value: carbs,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),

        radius: 50.0,
      ),
      PieChartSectionData(
        color: const Color(0xff92A3FD),
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
        value: fat,
        radius: 50.0,
      ),
      PieChartSectionData(
        color: const Color(0x9BDABFFF),
        value: sugar,
badgePositionPercentageOffset: 1,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15,
    fontWeight: FontWeight.bold
        ),

        radius: 50.0,
      ),
    ];
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;

  const Indicator({
    required this.color,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(text),
      ],
    );
  }
}


class AlimentDetails extends StatefulWidget {
  final int index;

  const AlimentDetails({Key? key, required this.index}) : super(key: key);

  @override
  _AlimentDetailsState createState() => _AlimentDetailsState();
}

class _AlimentDetailsState extends State<AlimentDetails> {
  late Aliment _aliment;
  final AlimentController _alimentController = Get.find();

  @override
  void initState() {
    super.initState();
    _aliment = _alimentController.getAliment(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    List nutritionArr= [
      {"Calories": _aliment.calories},
      {"Protein": _aliment.protein},
      {"Carbs": _aliment.carbs},
      {"Fat": _aliment.fat},

    ];
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
        title: Text(_aliment.name,
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
        body:
       SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(

              width: double.infinity,
              decoration: BoxDecoration(
                color: TColor.lightGray,
                image: DecorationImage(
                  image: NetworkImage(_aliment.image ?? ''),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0), // Add rounded corners
              ),
              child: Image(
                image: NetworkImage(_aliment.image ?? ''),

                fit: BoxFit.contain,

              ),
            ),
            const SizedBox(height: 16),
            Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ' Aliment name',
                                    style: TextStyle(
                                        color: TColor.black,
                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        letterSpacing: 1,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Text(
                                   ' Aliment ${_aliment.name}',
                                    style: TextStyle(
                                        color: TColor.black,

                                        fontSize: 16,
                                        fontFamily: 'Poppins',
                                        fontWeight: FontWeight.w300),
                                  ),

                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 15),
                        child: Text(
                          "Nutrition facts",
                          style: TextStyle(
                              color: TColor.black,
                              fontSize: 16,
                              fontFamily: 'Poppins',
                              letterSpacing: 1,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 60,
                        child: ListView.builder(
                            padding: const EdgeInsets.symmetric(horizontal: 12),
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: nutritionArr.length,
                            itemBuilder: (context, index) {
                              Map<String, dynamic> nObj = nutritionArr[index];
                              String key = nObj.keys.first;
                              dynamic value = nObj.values.first;
                              return Container(
                                  margin: const EdgeInsets.symmetric(
                                      vertical: 8, horizontal: 4),
                                  padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                                  decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          TColor.primaryColor2.withOpacity(0.4),
                                          TColor.primaryColor1.withOpacity(0.4)
                                        ],
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                    children: [

                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(
                                          '$key: $value',
                                          style: TextStyle(
                                            color: TColor.black,
                                            fontSize: 14,
                                          ),
                                        ),
                                      )

                                    ],
                                  ));
                            }),
                      ),
                      SizedBox(
                        height: media.width * 0.05,
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const SizedBox(
                        height: 15,
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
                        calories: _aliment.calories,
                        protein: _aliment.protein,
                        carbs: _aliment.carbs,
                        fat: _aliment.fat,
                        sugar: _aliment.sugar,
                      ),



                      SizedBox(
                        height: media.width * 0.25,
                      ),
                    ],
                  ),
                ),
              ],
            )


          ],
        ),)
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        Text(
          value,
          style: const TextStyle(fontSize: 14),
        ),
      ],
    );
  }
}
