import 'dart:convert';

import 'package:fitapp/classes/Aliment.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;


Future<List<Aliment>> fetchAliments() async {
  final response =
      await http.get(Uri.parse('https://fit-app-api.azurewebsites.net/api/aliments'));

  if (response.statusCode == 200) {
    List<dynamic> body = jsonDecode(response.body);
    return body.map((dynamic item) => Aliment.fromJson(item)).toList();
  } else {
    throw Exception('Failed to load aliments');
  }
}

class AlimentListPage extends StatefulWidget {
  @override
  _AlimentListPageState createState() => _AlimentListPageState();
}

class _AlimentListPageState extends State<AlimentListPage> {
  late Future<List<Aliment>> futureAliments;

  @override
  void initState() {
    super.initState();
    futureAliments = fetchAliments() as Future<List<Aliment>>;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Aliment List'),
      ),
      body: FutureBuilder<List<Aliment>>(
        future: futureAliments,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(snapshot.data![index].name),
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }

          // By default, show a loading spinner.
          return CircularProgressIndicator();
        },
      ),
    );
  }
}