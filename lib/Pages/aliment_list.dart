import 'dart:convert';

import 'package:fitapp/classes/Aliment.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

Future<List<Aliment>> fetchAliments() async {
  final response = await http
      .get(Uri.parse('https://fit-app-api.azurewebsites.net/api/aliments'));

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
  late List<bool> selectedAliments;

  @override
  void initState() {
    super.initState();
    futureAliments = fetchAliments();
    selectedAliments = [];
  }

  String formatNumber(double num) {
    return num % 1 == 0 ? num.toInt().toString() : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder<List<Aliment>>(
        future: futureAliments,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done &&
              selectedAliments.isEmpty) {
            selectedAliments = List<bool>.filled(snapshot.data!.length, false);
          }
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data?.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Row(
                    children: <Widget>[
                      Checkbox(
                        value: selectedAliments[index],
                        onChanged: (bool? value) {
                          setState(() {
                            selectedAliments[index] = value!;
                          });
                        },
                      ),
                      ClipOval(
                        child: Image.network(
                          snapshot.data![index].image!,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              snapshot.data![index].name,
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Row(
                              children: <Widget>[
                                Text(
                                  '${formatNumber(snapshot.data![index].calories)}',
                                  style: TextStyle(
                                    color: Colors.blueAccent,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  ' / ${formatNumber(snapshot.data![index].servingSize)} ${snapshot.data![index].servingUnit}',
                                  style: TextStyle(
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
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
      floatingActionButton: selectedAliments.contains(true)
          ? FloatingActionButton.extended(
              onPressed: () {
                // Add your action here
              },
              label: Text('Add (${selectedAliments.where((b) => b).length})'),
              icon: Icon(Icons.check),
            )
          : null,
    );
  }
}
