import 'package:flutter/material.dart';

class AlimentDetails extends StatefulWidget {
  @override
  _AlimentDetailsState createState() => _AlimentDetailsState();
}

class _AlimentDetailsState extends State<AlimentDetails> {
  final List<String> aliments = ['Aliment 1', 'Aliment 2', 'Aliment 3']; // Add your aliments here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aliment List'),
      ),
      body: ListView.builder(
        itemCount: aliments.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(aliments[index]),
          );
        },
      ),
    );
  }
}