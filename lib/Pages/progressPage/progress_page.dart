import 'package:fitapp/controllers/progressController.dart';
import 'package:fitapp/models/Progress.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import '../../controllers/objectif_controller.dart';
import '../../controllers/user_controller.dart';
import '../../models/Objectif.dart';
import '../../models/User.dart';
import '../../utils/theme_colors.dart';
import '../homepage/footer.dart';

class ProgressChart extends StatefulWidget {
  const ProgressChart({Key? key}) : super(key: key);

  @override
  State<ProgressChart> createState() => _ProgressChartState();
}

class _ProgressChartState extends State<ProgressChart> {
  final storage = const FlutterSecureStorage();
  TextEditingController newWeight=TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: Future.wait([getProgressByUserId(), getObjectifByUserId()]),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Text("Error: ${snapshot.error}");
          } else if (snapshot.hasData) {
            ProgressWeight? progress = snapshot.data![0] as ProgressWeight?;
            Objectif? objectif = snapshot.data![1] as Objectif?;
            if (progress == null || progress.weightList.isEmpty) {
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    "Progress",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: Center(
                  child: Text('No data available for chart.'),
                ),
              );
            }

            print("objectif : $objectif");
            if (objectif != null) {
              double lastWeight = progress.weightList.last.weight;
              double weightDiff= objectif.poidsObj-progress.weightList.first.weight;
              double currentProgress=lastWeight-progress.weightList.first.weight;
              double percentage = (currentProgress / weightDiff) * 100;


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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    "Progress",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(
                        height: 20,
                      ),
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
                            interval: 3,
                          ),

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
                              yValueMapper: (WeightEntry entry, _) =>
                                  entry.weight,
                              dataLabelSettings:
                                  DataLabelSettings(isVisible: true),
                              name: 'Weight Progress',
                              width: 3,
                              color: TColor.primaryColor1,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),


                      if (currentProgress<0) Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.all(12.0),

                            child: new LinearPercentIndicator(
                              // width: MediaQuery.of(context).size.width - 50,
                              barRadius: Radius.circular(10),

                              animation: true,
                              lineHeight: 30.0,
                              animationDuration: 1500,
                              percent: 0.0,
                              center: Text("${percentage.toStringAsFixed(1)}%",style: TextStyle(color: Colors.white),),
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              progressColor: TColor.primaryColor1,
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text("${progress.weightList.first.weight.toString()} Kg",
                                  style: TextStyle(
                                    fontSize: 15,

                                  ),
                                ),


                                Row(
                                  children: [
                                    Icon(Icons.flag_outlined),
                                    Text(objectif.poidsObj.toString() + " Kg",
                                      style: TextStyle(
                                        fontSize: 15,

                                      ),)
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ) else if(percentage>=100) Container(
                        padding: EdgeInsets.all(12.0),
                        child: Text(
                          "Goal Achieved!",  // Customize this message
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: TColor.primaryColor1,  // Customize the color
                          ),
                        ),
                      ) else if(percentage<100)
                        Column(
                          children: [
                            Padding(
                              padding: EdgeInsets.all(12.0),

                              child: new LinearPercentIndicator(
                                // width: MediaQuery.of(context).size.width - 50,
                                barRadius: Radius.circular(10),

                                animation: true,
                                lineHeight: 30.0,
                                animationDuration: 1500,
                                percent: percentage/100,
                                center: Text("${percentage.toStringAsFixed(1)}%",style: TextStyle(color: Colors.white),),
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                progressColor: TColor.primaryColor1,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(horizontal: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${progress.weightList.first.weight.toString()} Kg",
                                    style: TextStyle(
                                      fontSize: 15,

                                    ),
                                  ),


                                  Row(
                                    children: [
                                      Icon(Icons.flag_outlined),
                                      Text(objectif.poidsObj.toString() + " Kg",
                                        style: TextStyle(
                                          fontSize: 15,

                                        ),)
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        )

                      ,
                      SizedBox(
                        height: 15,
                      ),
                      TextButton(onPressed:(){
                        weightIn(context);
                      }, child: Text("Weight in",style: TextStyle(color: TColor.primaryColor1),)),



                    ],
                  ),
                ),
                  bottomNavigationBar: Footer(
                    selectTab: 2,
                  )

              );
            } else {
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
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  ),
                  title: Text(
                    "Progress",
                    style: TextStyle(
                      color: TColor.black,
                      fontSize: 20,
                      letterSpacing: 1,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                body: Center(
                  child: Text('Objectif is null.'),

                ),
              );
            }
          } else {
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
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new,
                      color: TColor.black,
                      size: 20,
                    ),
                  ),
                ),
                title: Text(
                  "Progress",
                  style: TextStyle(
                    color: TColor.black,
                    fontSize: 20,
                    letterSpacing: 1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              body: Center(
                child: Text('No Data'),
              ),
                bottomNavigationBar: Footer(
                  selectTab: 2,
                )

            );
          }
        } else {
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: TColor.black,
                    size: 20,
                  ),
                ),
              ),
              title: Text(
                "Progress",
                style: TextStyle(
                  color: TColor.black,
                  fontSize: 20,
                  letterSpacing: 1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            body: Center(
              child: CircularProgressIndicator(),
            ),
              bottomNavigationBar: Footer(
                selectTab: 2,
              )

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

      var response =
          await ProgressController().getProgressByUserId(decodedToken['_id']);
      print("progress Page: $response");
      return response;
    } catch (e) {
      print("Error in getProgressByUserId: $e");
      return null;
    }
  }


  Future<Objectif?> getObjectifByUserId() async {
    try {
      var token = await storage.read(key: 'userToken');
      if (token == null) {
        return null;
      }

      Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
      print("decodedToken: $decodedToken");

      var response =
          await ObjectifController().getObjectiveByUserId(decodedToken['_id']);
      print("progress Page: $response");
      return response;
    } catch (e) {
      print("Error in getProgressByUserId: $e");
      return null;
    }
  }

  Future<void> weightIn(BuildContext context)
  {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Weight In'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Enter your weight'),
              SizedBox(height: 20,),
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: newWeight,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter your target weight';
                        }

                        final target = RegExp(r'^\d*\.?\d*$');
                        if (!target.hasMatch(value)) {
                          return 'Your weight should not contain caracters';
                        }

                        return null;
                      },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Weight',
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Confirm'),
              onPressed: () async {
  if (_formKey.currentState!.validate()) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    var token = await storage.read(key: 'userToken');
    if (token == null) {
      return null;
    }

    Map<String, dynamic> decodedToken = JwtDecoder.decode(token);
    print("decodedToken: $decodedToken");
    await ProgressController().addProgressToAUser(
        decodedToken['_id'], {"poids": double.parse(newWeight.text)});

    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProgressChart(),
      ),
    );
  }else
    {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter a valid weight'),
          backgroundColor: Colors.redAccent,
          duration: Duration(seconds: 3),
        ),
      );
    }
              },
            ),
          ],
        );
      },
    );



  }
}
