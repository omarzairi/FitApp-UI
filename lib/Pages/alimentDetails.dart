import 'dart:convert';
import 'package:fitapp/classes/Aliment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fl_chart/fl_chart.dart';

Future<Aliment> fetchAliment() async {
  final response = await http.get(Uri.parse('https://fit-app-api.azurewebsites.net/api/aliments'));

  if (response.statusCode == 200) {
    dynamic body = jsonDecode(response.body)[0];
    return Aliment.fromJson(body);
  } else {
    throw Exception('Failed to load aliment');
  }
}

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
  @override
  _AlimentDetailsState createState() => _AlimentDetailsState();
}

class _AlimentDetailsState extends State<AlimentDetails> {
  late Future<Aliment> futureAliment;

  @override
  void initState() {
    super.initState();
    futureAliment = fetchAliment();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<Aliment>(
        future: futureAliment,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final aliment = snapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 200,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(aliment.image ?? ''),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(12.0),
                    ),
                  ),
                 const SizedBox(height: 16),
                  Row( children: [
                 const    Text(
                      '   Name :     ',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,color: Colors.deepPurple,
                        fontFamily: 'ubuntu', fontFamilyFallback: <String>[
                          'Noto Sans CJK SC',
                          'Noto Color Emoji',
                        ],),
                    ),
                    Text(
                      aliment.name,
                      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.normal,color: Colors.black,
                        fontFamily: 'ubuntu', fontFamilyFallback: <String>[
                          'Noto Sans CJK SC',
                          'Noto Color Emoji',
                        ],),
                    ),
                  ],),

                  const SizedBox(height: 40),
                  Container(
                    margin:const EdgeInsets.symmetric(horizontal: 16.0), // Adjust the horizontal margin as needed
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailItem(
                              'Calories',
                              aliment.calories.toString(),
                            ),
                            _buildDetailItem('Protein', aliment.protein.toString()),
                          ],
                        ),
                        const SizedBox(width: 8), // Add spacing between the two columns
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            _buildDetailItem('Carbs', aliment.carbs.toString()),
                            _buildDetailItem('Fat', aliment.fat.toString()),
                          ],
                        ),
                      ],
                    ),
                  ),


                 const SizedBox(height: 50),
                  PieChartSample2(
                    calories: aliment.calories,
                    protein: aliment.protein,
                    carbs: aliment.carbs,
                    fat: aliment.fat,
                    sugar: aliment.sugar,
                  ),
                ],
              ),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          }

          // By default, show a loading spinner.
          return const Center(child: CircularProgressIndicator());
        },
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
