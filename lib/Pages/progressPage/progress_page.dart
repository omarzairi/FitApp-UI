import 'package:fitapp/controllers/progressController.dart';
import 'package:fitapp/models/Progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../controllers/user_controller.dart';
import '../../models/User.dart';


class ProgressChart extends StatefulWidget {
  const ProgressChart({Key? key}) : super(key: key);

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  final storage = const FlutterSecureStorage();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProgressWeight?>(
      future: getProgressByUserId(),
      builder: (BuildContext context, AsyncSnapshot<ProgressWeight?> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            ProgressWeight? progress = snapshot.data;
            if (progress == null || progress.weightList.isEmpty) {
              return Scaffold(
                appBar: AppBar(
                  title: Text('Progress Chart'),
                ),
                body: Center(
                  child: Text('No data available for chart.'),
                ),
              );
            }

            return Scaffold(
              appBar: AppBar(
                title: Text('Progress Chart'),
              ),
              body: Column(

                children: [
                  SizedBox(height: 20,),
                  Container(
                    width: double.infinity,
                    height: 400,

                    child: SfCartesianChart(
                      enableAxisAnimation: true,
                      primaryXAxis: DateTimeAxis(
                          dateFormat: DateFormat('dd MMM'),
                          edgeLabelPlacement: EdgeLabelPlacement.shift,
                          plotOffset: 20,
                          labelAlignment: LabelAlignment.center,
                          intervalType: DateTimeIntervalType.days,
                        interval:3,





                      ),
                      title: ChartTitle(text: 'Weight Progress'),
                      legend: Legend(isVisible: true),
                      tooltipBehavior: TooltipBehavior(enable: true),

                      series: <LineSeries<WeightEntry, DateTime>>[
                        LineSeries<WeightEntry, DateTime>(
                          markerSettings: MarkerSettings(
                            isVisible: true,
                            width: 6,
                            shape: DataMarkerType.circle,
                          ),
                          dataSource: progress.weightList,
                          xValueMapper: (WeightEntry entry, _) => entry.date,
                          yValueMapper: (WeightEntry entry, _) => entry.weight,
                          dataLabelSettings: DataLabelSettings(isVisible: true),

                          name: 'Weight Progress',
                          width: 3,

                        ),
                      ],


                    ),
                  ),
                ],
              ),
            );
          } else {
            return Scaffold(
              appBar: AppBar(
                title: Text('Progress Chart'),
              ),
              body: Center(
                child: Text('No Data'),
              ),
            );
          }
        } else {
          return Scaffold(
            appBar: AppBar(
              title: Text('Progress Chart'),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }

  Future<ProgressWeight?> getProgressByUserId() async {
    try {
      var token = await storage.read(key: 'userToken');
      if (token == null) {
        return null;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print("decodedToken: $decodedToken");

      var response = await ProgressController().getProgressByUserId(decodedToken['_id']);
      print("progress Page: $response");
      return response;
    } catch (e) {
      print("Error in getProgressByUserId: $e");
      return null;
    }
  }
}
