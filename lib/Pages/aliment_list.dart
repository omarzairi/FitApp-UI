import 'package:flutter/material.dart';

class AlimentListPage extends StatefulWidget {
  @override
  _AlimentListPageState createState() => _AlimentListPageState();
}

class _AlimentListPageState extends State<AlimentListPage> {
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