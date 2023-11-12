import 'dart:convert';
import 'package:fitapp/classes/Aliment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

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
                startDegreeOffset: 5,
                sections: showingSections(),
              ),
            ),
          ),
          const Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Indicator(color: Colors.blue, text: 'Calories'),
              Indicator(color: Colors.orange, text: 'Protein'),
              Indicator(color: Colors.purple, text: 'Carbs'),
              Indicator(color: Colors.green, text: 'Fat'),
              Indicator(color: Colors.red, text: 'Sugar'),
            ],
          ),
        ],
      ),
    );
  }

  List<PieChartSectionData> showingSections() {

    return [
      PieChartSectionData(
        color: Colors.blue,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15),
        value: calories,
        radius: 50.0,
      ),
      PieChartSectionData(
        color: Colors.orange,
        value: protein,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15),

        radius: 50.0,
      ),
      PieChartSectionData(
        color: Colors.purple,
        value: carbs,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15),

        radius: 50.0,
      ),
      PieChartSectionData(
        color: Colors.green,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15),

        value: fat,
        radius: 50.0,
      ),
      PieChartSectionData(
        color: Colors.red,
        value: sugar,
        titleStyle: const TextStyle( color: Colors.white, fontSize: 15),

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
  final Aliment aliment;

  const AlimentDetails({Key? key, required this.aliment}) : super(key: key);

  @override
  _AlimentDetailsState createState() => _AlimentDetailsState();
}

class _AlimentDetailsState extends State<AlimentDetails> {
  late Aliment _aliment;

  @override
  void initState() {
    super.initState();
    _aliment = widget.aliment;
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
        body: SingleChildScrollView(
        child: Padding(
        padding: const EdgeInsets.all(16.0),
    child: Column(


          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              child: Image(
                image: NetworkImage(_aliment.image ?? ''),
                fit: BoxFit.contain,
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(_aliment.image ?? ''),
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            const SizedBox(height: 16),


                Text(
                  _aliment.name,
                  style: const TextStyle(

                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                    color: Colors.black,
                    fontFamily: 'Poppins',
                    fontFamilyFallback: <String>[
                      'Noto Sans CJK SC',
                      'Noto Color Emoji',
                    ],
                  ),


            ),
            const SizedBox(height: 40),
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailItem('Calories', _aliment.calories.toString()),
                      _buildDetailItem('Protein', _aliment.protein.toString()),
                    ],
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildDetailItem('Carbs', _aliment.carbs.toString()),
                      _buildDetailItem('Fat', _aliment.fat.toString()),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 40),
            PieChartSample2(
              calories: _aliment.calories,
              protein: _aliment.protein,
              carbs: _aliment.carbs,
              fat: _aliment.fat,
              sugar: _aliment.sugar,
            ),
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
