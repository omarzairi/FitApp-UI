
import 'package:fitapp/Pages/homepage/meals.dart';
import 'package:fitapp/controllers/objectif_controller.dart';
import 'package:fitapp/controllers/user_controller.dart';
import 'package:fitapp/models/Objectif.dart';
import 'package:fitapp/models/User.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../common_widgets/round_button.dart';
import '../../utils/theme_colors.dart';
import 'footer.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key});




  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {




  int selectTab = 0;
  final PageStorageBucket pageBucket = PageStorageBucket();

  List<int> showingTooltipOnSpots = [21];


  List waterArr = [
    {"title": "6am - 8am", "subtitle": "600ml"},
    {"title": "9am - 11am", "subtitle": "500ml"},
    {"title": "11am - 2pm", "subtitle": "1000ml"},
    {"title": "2pm - 4pm", "subtitle": "700ml"},
    {"title": "4pm - now", "subtitle": "900ml"},
  ];

  // UserController userController = UserController();
  ObjectifController objectifController = ObjectifController();
  // late User user;
  late Objectif objective;
  //
  Future<void> initData() async {
    UserController userController = Get.find<UserController>();
    if(userController.user == null){
      await userController.getLoggedUser();
    }
    print("in the init data ${userController.user!.id!}");
    await objectifController.getObjectiveByUserId(userController.user!.id!);
    //   user=userController.user;
    objective = objectifController.objectif;
  }

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    UserController userController = Get.find<UserController>();
    var media = MediaQuery.of(context).size;
    //final UserController userController = Get.put(UserController());

    return Scaffold(
      backgroundColor: TColor.white,
      body: FutureBuilder(
        future: initData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return  Scaffold(
                drawer: const Drawer(),
                backgroundColor: TColor.white,
                appBar: AppBar(
                  backgroundColor: TColor.white,
                  title:
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder(
                        future: initData(),
                        builder: (context, snapshot) {
                          if (snapshot.connectionState == ConnectionState.done) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Welcome Back,",
                                  style: TextStyle(color: TColor.gray, fontSize: 12),
                                ),
                                Text(
                                  "${userController.user?.prenom} ${userController.user?.nom}",
                                  style: TextStyle(
                                      color: TColor.black,
                                      fontSize: 20,
                                      fontWeight: FontWeight.w700),
                                ),
                              ],
                            );
                          } else {
                            // Data is still loading, you can show a loading indicator
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      IconButton(
                          onPressed: () {
                          },
                          icon: Image.asset(
                            "assets/img/notification_active.png",
                            width: 25,
                            height: 25,
                            fit: BoxFit.fitHeight,
                          ))
                    ],
                  ),
                ),
                floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
                floatingActionButton: SizedBox(
                  width: 70,
                  height: 70,
                  child: InkWell(
                    onTap: () {
                      Navigator.pushNamed(context, '/alimentlist');
                    },
                    child: Container(
                      width: 65,
                      height: 65,
                      decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: TColor.primaryG,
                          ),
                          borderRadius: BorderRadius.circular(35),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black12,
                              blurRadius: 2,)
                          ]),
                      child: Icon(Icons.add,color: TColor.white, size: 35, ),
                    ),
                  ),
                ),
                body: SingleChildScrollView(
                  child: FutureBuilder(
                    future:initData(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done && userController.user != null) {
                        double calculatedValue = userController.user!.poids / ((userController.user!.taille / 100)*(userController.user!.taille/100));
                        return SingleChildScrollView(
                          child: SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Container(
                                    height: media.width * 0.4,
                                    decoration: BoxDecoration(
                                        gradient: LinearGradient(colors: TColor.primaryG),
                                        borderRadius: BorderRadius.circular(media.width * 0.075)),
                                    child: Stack(alignment: Alignment.center, children: [
                                      Image.asset(
                                        "assets/img/bg_dots.png",
                                        height: media.width * 0.4,
                                        width: double.maxFinite,
                                        fit: BoxFit.fitHeight,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 25, horizontal: 25),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "BMI (Body Mass Index)",
                                                  style: TextStyle(
                                                      color: TColor.white,
                                                      fontSize: 14,
                                                      fontWeight: FontWeight.w700),
                                                ),
                                                Text(
                                                  classifyBMI(calculatedValue),
                                                  style: TextStyle(
                                                      color: TColor.white.withOpacity(0.7),
                                                      fontSize: 12),
                                                ),
                                                SizedBox(
                                                  height: media.width * 0.05,
                                                ),
                                                SizedBox(
                                                    width: 120,
                                                    height: 35,
                                                    child: RoundButton(
                                                        title: "View More",
                                                        type: RoundButtonType.bgSGradient,
                                                        fontSize: 12,
                                                        fontWeight: FontWeight.w400,
                                                        onPressed: () {}))
                                              ],
                                            ),
                                            AspectRatio(
                                              aspectRatio: 1,
                                              child: PieChart(
                                                PieChartData(
                                                  pieTouchData: PieTouchData(
                                                    touchCallback:
                                                        (FlTouchEvent event, pieTouchResponse) {},
                                                  ),
                                                  startDegreeOffset: 250,
                                                  borderData: FlBorderData(
                                                    show: false,
                                                  ),
                                                  sectionsSpace: 1,
                                                  centerSpaceRadius: 0,
                                                  sections: showingSections(calculatedValue),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                    ]),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Container(
                                    padding:
                                    const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
                                    decoration: BoxDecoration(
                                      color: TColor.primaryColor2.withOpacity(0.3),
                                      borderRadius: BorderRadius.circular(15),
                                    ),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "Today's Target",
                                          style: TextStyle(
                                              color: TColor.black,
                                              fontSize: 14,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        SizedBox(
                                          width: 120,
                                          height: 35,
                                          child: RoundButton(
                                            title: objective.calories!.toStringAsFixed(0)+ " kcal",
                                            type: RoundButtonType.bgGradient,
                                            fontSize: 15,
                                            fontWeight: FontWeight.w500,
                                            onPressed: () {

                                            },
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Text(
                                    "Activity Status",
                                    style: TextStyle(
                                        color: TColor.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.02,
                                  ),
                                  SingleChildScrollView(
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25),
                                      child: Container(
                                          height: media.width * 0.8,
                                          width: double.maxFinite,
                                          decoration: BoxDecoration(
                                            color: TColor.primaryColor2.withOpacity(0.3),
                                            borderRadius: BorderRadius.circular(25),
                                          ),
                                          child:Padding(
                                            padding: const EdgeInsets.only(
                                                left: 24, right: 24, top: 16, bottom: 18),
                                            child: SingleChildScrollView(
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius: BorderRadius.only(
                                                      topLeft: Radius.circular(8.0),
                                                      bottomLeft: Radius.circular(8.0),
                                                      bottomRight: Radius.circular(8.0),
                                                      topRight: Radius.circular(68.0)),
                                                  boxShadow: <BoxShadow>[
                                                    BoxShadow(
                                                        color: Colors.grey.withOpacity(0.2),
                                                        offset: Offset(1.1, 1.1),
                                                        blurRadius: 10.0),
                                                  ],
                                                ),
                                                child: Column(
                                                  children: <Widget>[
                                                    Padding(
                                                      padding:
                                                      const EdgeInsets.only(top: 16, left: 16, right: 16),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Padding(
                                                              padding: const EdgeInsets.only(
                                                                  left: 8, right: 8, top: 4),
                                                              child: Column(
                                                                children: <Widget>[
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        height: 48,
                                                                        width: 2,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xff87A0E5).withOpacity(0.5),
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(4.0)),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 4, bottom: 2),
                                                                              child: Text(
                                                                                'Eaten',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(

                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16,
                                                                                  letterSpacing: -0.1,
                                                                                  color: Colors.grey
                                                                                      .withOpacity(0.5),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                              children: <Widget>[
                                                                                SizedBox(
                                                                                  width: 28,
                                                                                  height: 28,
                                                                                  child: Image.asset(
                                                                                      "assets/img/eaten.png"),
                                                                                ),
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                      left: 4, bottom: 3),
                                                                                  child: Text(
                                                                                    '222',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(

                                                                                      fontWeight:
                                                                                      FontWeight.w600,
                                                                                      fontSize: 16,
                                                                                      color: Colors
                                                                                          .black,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                      left: 4, bottom: 3),
                                                                                  child: Text(
                                                                                    'Kcal',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(

                                                                                      fontWeight:
                                                                                      FontWeight.w600,
                                                                                      fontSize: 12,
                                                                                      letterSpacing: -0.2,
                                                                                      color: Colors
                                                                                          .grey
                                                                                          .withOpacity(0.5),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  ),
                                                                  SizedBox(
                                                                    height: 8,
                                                                  ),
                                                                  Row(
                                                                    children: <Widget>[
                                                                      Container(
                                                                        height: 48,
                                                                        width: 2,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xffF56E98)
                                                                              .withOpacity(0.5),
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(4.0)),
                                                                        ),
                                                                      ),
                                                                      Padding(
                                                                        padding: const EdgeInsets.all(8.0),
                                                                        child: Column(
                                                                          mainAxisAlignment:
                                                                          MainAxisAlignment.center,
                                                                          crossAxisAlignment:
                                                                          CrossAxisAlignment.start,
                                                                          children: <Widget>[
                                                                            Padding(
                                                                              padding: const EdgeInsets.only(
                                                                                  left: 4, bottom: 2),
                                                                              child: Text(
                                                                                'Burned',
                                                                                textAlign: TextAlign.center,
                                                                                style: TextStyle(

                                                                                  fontWeight: FontWeight.w500,
                                                                                  fontSize: 16,
                                                                                  letterSpacing: -0.1,
                                                                                  color: Colors.grey
                                                                                      .withOpacity(0.5),
                                                                                ),
                                                                              ),
                                                                            ),
                                                                            Row(
                                                                              mainAxisAlignment:
                                                                              MainAxisAlignment.center,
                                                                              crossAxisAlignment:
                                                                              CrossAxisAlignment.end,
                                                                              children: <Widget>[
                                                                                SizedBox(
                                                                                  width: 28,
                                                                                  height: 28,
                                                                                  child: Image.asset(
                                                                                      "assets/img/burned.png"),
                                                                                ),
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                      left: 4, bottom: 3),
                                                                                  child: Text(
                                                                                    '102',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(

                                                                                      fontWeight:
                                                                                      FontWeight.w600,
                                                                                      fontSize: 16,
                                                                                      color: Colors
                                                                                          .black,
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding:
                                                                                  const EdgeInsets.only(
                                                                                      left: 8, bottom: 3),
                                                                                  child: Text(
                                                                                    'Kcal',
                                                                                    textAlign: TextAlign.center,
                                                                                    style: TextStyle(
                                                                                      fontWeight:
                                                                                      FontWeight.w600,
                                                                                      fontSize: 12,
                                                                                      letterSpacing: -0.2,
                                                                                      color: Colors
                                                                                          .grey
                                                                                          .withOpacity(0.5),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            )
                                                                          ],
                                                                        ),
                                                                      )
                                                                    ],
                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          ),
                                                          Padding(
                                                            padding: const EdgeInsets.only(right: 16),
                                                            child: Center(
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: <Widget>[
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Container(
                                                                      width: 100,
                                                                      height: 100,
                                                                      decoration: BoxDecoration(
                                                                        color: Colors.white,
                                                                        borderRadius: BorderRadius.all(
                                                                          Radius.circular(100.0),
                                                                        ),
                                                                        border: new Border.all(
                                                                            width: 4,
                                                                            color: Colors
                                                                                .blueAccent
                                                                                .withOpacity(0.2)),
                                                                      ),
                                                                      child: Column(
                                                                        mainAxisAlignment:
                                                                        MainAxisAlignment.center,
                                                                        crossAxisAlignment:
                                                                        CrossAxisAlignment.center,
                                                                        children: <Widget>[
                                                                          Text(
                                                                            '1503',
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(

                                                                              fontWeight: FontWeight.normal,
                                                                              fontSize: 24,
                                                                              letterSpacing: 0.0,
                                                                              color: Colors
                                                                                  .lightBlue,
                                                                            ),
                                                                          ),
                                                                          Text(
                                                                            'Kcal left',
                                                                            textAlign: TextAlign.center,
                                                                            style: TextStyle(

                                                                              fontWeight: FontWeight.bold,
                                                                              fontSize: 12,
                                                                              letterSpacing: 0.0,
                                                                              color: Colors.grey
                                                                                  .withOpacity(0.5),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(4.0),

                                                                  )
                                                                ],
                                                              ),
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 24, right: 24, top: 8, bottom: 8),
                                                      child: Container(
                                                        height: 2,
                                                        decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: const EdgeInsets.only(
                                                          left: 24, right: 24, top: 8, bottom: 16),
                                                      child: Row(
                                                        children: <Widget>[
                                                          Expanded(
                                                            child: Column(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.start,
                                                              children: <Widget>[
                                                                Text(
                                                                  'Carbs',
                                                                  textAlign: TextAlign.center,
                                                                  style: TextStyle(

                                                                    fontWeight: FontWeight.w500,
                                                                    fontSize: 16,
                                                                    letterSpacing: -0.2,
                                                                    color: Colors.black,
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 4),
                                                                  child: Container(
                                                                    height: 4,
                                                                    width: 70,
                                                                    decoration: BoxDecoration(
                                                                      color:
                                                                      Color(0xff87A0E5).withOpacity(0.2),
                                                                      borderRadius: BorderRadius.all(
                                                                          Radius.circular(4.0)),
                                                                    ),
                                                                    child: Row(
                                                                      children: <Widget>[
                                                                        Container(
                                                                          width: ((70 / 1.2)),
                                                                          height: 4,
                                                                          decoration: BoxDecoration(
                                                                            gradient: LinearGradient(colors: [
                                                                              Color(0xff87A0E5),
                                                                              Color(0xff87A0E5)
                                                                                  .withOpacity(0.5),
                                                                            ]),
                                                                            borderRadius: BorderRadius.all(
                                                                                Radius.circular(4.0)),
                                                                          ),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 6),
                                                                  child: Text(
                                                                    '12g left',
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                      fontWeight: FontWeight.w600,
                                                                      fontSize: 12,
                                                                      color:
                                                                      Colors.grey.withOpacity(0.5),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      'Protein',
                                                                      textAlign: TextAlign.center,
                                                                      style: TextStyle(
                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 16,
                                                                        letterSpacing: -0.2,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 4),
                                                                      child: Container(
                                                                        height: 4,
                                                                        width: 70,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xffF56E98)
                                                                              .withOpacity(0.2),
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(4.0)),
                                                                        ),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: (70 / 2),
                                                                              height: 4,
                                                                              decoration: BoxDecoration(
                                                                                gradient:
                                                                                LinearGradient(colors: [
                                                                                  Color(0xffF56E98)
                                                                                      .withOpacity(0.1),
                                                                                  Color(0xffF56E98),
                                                                                ]),
                                                                                borderRadius: BorderRadius.all(
                                                                                    Radius.circular(4.0)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 6),
                                                                      child: Text(
                                                                        '30g left',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12,
                                                                          color: Colors.grey
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Row(
                                                              mainAxisAlignment: MainAxisAlignment.end,
                                                              crossAxisAlignment: CrossAxisAlignment.center,
                                                              children: <Widget>[
                                                                Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: <Widget>[
                                                                    Text(
                                                                      'Fat',
                                                                      style: TextStyle(

                                                                        fontWeight: FontWeight.w500,
                                                                        fontSize: 16,
                                                                        letterSpacing: -0.2,
                                                                        color: Colors.black,
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(
                                                                          right: 0, top: 4),
                                                                      child: Container(
                                                                        height: 4,
                                                                        width: 70,
                                                                        decoration: BoxDecoration(
                                                                          color: Color(0xffF1B440)
                                                                              .withOpacity(0.2),
                                                                          borderRadius: BorderRadius.all(
                                                                              Radius.circular(4.0)),
                                                                        ),
                                                                        child: Row(
                                                                          children: <Widget>[
                                                                            Container(
                                                                              width: (70 / 2.5)
                                                                              ,
                                                                              height: 4,
                                                                              decoration: BoxDecoration(
                                                                                gradient:
                                                                                LinearGradient(colors: [
                                                                                  Color(0xffF1B440)
                                                                                      .withOpacity(0.1),
                                                                                  Color(0xffF1B440),
                                                                                ]),
                                                                                borderRadius: const BorderRadius.all(
                                                                                    Radius.circular(4.0)),
                                                                              ),
                                                                            ),
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(top: 6),
                                                                      child: Text(
                                                                        '10g left',
                                                                        textAlign: TextAlign.center,
                                                                        style: TextStyle(
                                                                          fontWeight: FontWeight.w600,
                                                                          fontSize: 12,
                                                                          color: Colors.grey
                                                                              .withOpacity(0.5),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                          )
                                                        ],
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  HomeMealsView(),
                                  SizedBox(
                                    height: media.width * 0.05,
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: media.width * 1.07,
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 25, horizontal: 20),
                                          decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.circular(25),
                                              boxShadow: const [
                                                BoxShadow(color: Colors.black12, blurRadius: 2)
                                              ]),
                                          child: Row(
                                            children: [

                                              const SizedBox(
                                                width: 10,
                                              ),

                                              Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [

                                                      Text(
                                                        "Real Time Updates",
                                                        style: TextStyle(
                                                            color: TColor.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      const SizedBox(
                                                        height: 10,
                                                      ),

                                                      Column(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: waterArr.map((wObj) {
                                                          var isLast = wObj == waterArr.last;
                                                          return Row(
                                                            crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                            children: [
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.center,
                                                                children: [
                                                                  Container(
                                                                    margin:
                                                                    const EdgeInsets.symmetric(
                                                                        vertical: 4),
                                                                    width: 10,
                                                                    height: 10,
                                                                    decoration: BoxDecoration(
                                                                      color: TColor.secondaryColor1
                                                                          .withOpacity(0.5),
                                                                      borderRadius:
                                                                      BorderRadius.circular(5),
                                                                    ),
                                                                  ),

                                                                ],
                                                              ),
                                                              const SizedBox(
                                                                width: 10,
                                                              ),
                                                              Column(
                                                                mainAxisAlignment:
                                                                MainAxisAlignment.start,
                                                                crossAxisAlignment:
                                                                CrossAxisAlignment.start,
                                                                children: [
                                                                  Text(
                                                                    wObj["title"].toString(),
                                                                    style: TextStyle(
                                                                      color: TColor.gray,
                                                                      fontSize: 10,
                                                                    ),
                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  ),
                                                                  ShaderMask(
                                                                    blendMode: BlendMode.srcIn,
                                                                    shaderCallback: (bounds) {
                                                                      return LinearGradient(
                                                                          colors:
                                                                          TColor.secondaryG,
                                                                          begin: Alignment
                                                                              .centerLeft,
                                                                          end: Alignment
                                                                              .centerRight)
                                                                          .createShader(Rect.fromLTRB(
                                                                          0,
                                                                          0,
                                                                          bounds.width,
                                                                          bounds.height));
                                                                    },
                                                                    child: Text(
                                                                      wObj["subtitle"].toString(),
                                                                      style: TextStyle(
                                                                          color: TColor.white
                                                                              .withOpacity(0.7),
                                                                          fontSize: 12),
                                                                    ),

                                                                  ),
                                                                  SizedBox(
                                                                    height: 5,
                                                                  )
                                                                ],
                                                              )
                                                            ],
                                                          );
                                                        }).toList(),
                                                      )
                                                    ],
                                                  ))
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: media.width * 0.05,
                                      ),
                                      Expanded(
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              SingleChildScrollView(
                                                child: Container(
                                                  width: double.maxFinite,
                                                  height: media.width * 0.50,
                                                  padding: const EdgeInsets.symmetric(
                                                      vertical: 25, horizontal: 20),
                                                  decoration: BoxDecoration(
                                                      color: Colors.white,
                                                      borderRadius: BorderRadius.circular(25),
                                                      boxShadow: const [
                                                        BoxShadow(color: Colors.black12, blurRadius: 2)
                                                      ]),
                                                  child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Text(
                                                          "Sleep",
                                                          style: TextStyle(
                                                              color: TColor.black,
                                                              fontSize: 12,
                                                              fontWeight: FontWeight.w700),
                                                        ),
                                                        ShaderMask(
                                                          blendMode: BlendMode.srcIn,
                                                          shaderCallback: (bounds) {
                                                            return LinearGradient(
                                                                colors: TColor.primaryG,
                                                                begin: Alignment.centerLeft,
                                                                end: Alignment.centerRight)
                                                                .createShader(Rect.fromLTRB(
                                                                0, 0, bounds.width, bounds.height));
                                                          },
                                                          child: Text(
                                                            "8h 20m",
                                                            style: TextStyle(
                                                                color: TColor.white.withOpacity(0.7),
                                                                fontWeight: FontWeight.w700,
                                                                fontSize: 14),
                                                          ),
                                                        ),
                                                        const Spacer(),
                                                        Image.asset("assets/img/sleep_grap.png",
                                                            width: double.maxFinite,
                                                            fit: BoxFit.fitWidth)
                                                      ]),
                                                ),
                                              ),
                                              SizedBox(
                                                height: media.width * 0.05,
                                              ),
                                              Container(
                                                width: double.maxFinite,
                                                height: media.width * 0.50,
                                                padding: const EdgeInsets.symmetric(
                                                    vertical: 25, horizontal: 20),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius: BorderRadius.circular(25),
                                                    boxShadow: const [
                                                      BoxShadow(color: Colors.black12, blurRadius: 2)
                                                    ]),
                                                child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        "Calories",
                                                        style: TextStyle(
                                                            color: TColor.black,
                                                            fontSize: 12,
                                                            fontWeight: FontWeight.w700),
                                                      ),
                                                      ShaderMask(
                                                        blendMode: BlendMode.srcIn,
                                                        shaderCallback: (bounds) {
                                                          return LinearGradient(
                                                              colors: TColor.primaryG,
                                                              begin: Alignment.centerLeft,
                                                              end: Alignment.centerRight)
                                                              .createShader(Rect.fromLTRB(
                                                              0, 0, bounds.width, bounds.height));
                                                        },
                                                        child: Text(
                                                          "760 kCal",
                                                          style: TextStyle(
                                                              color: TColor.white.withOpacity(0.7),
                                                              fontWeight: FontWeight.w700,
                                                              fontSize: 14),
                                                        ),
                                                      ),
                                                      const Spacer(),
                                                      Container(
                                                        alignment: Alignment.center,
                                                        child: SizedBox(
                                                          width: media.width * 0.2,
                                                          height: media.width * 0.2,
                                                          child: Stack(
                                                            alignment: Alignment.center,
                                                            children: [
                                                              Container(
                                                                width: media.width * 0.15,
                                                                height: media.width * 0.15,
                                                                alignment: Alignment.center,
                                                                decoration: BoxDecoration(
                                                                  gradient: LinearGradient(
                                                                      colors: TColor.primaryG),
                                                                  borderRadius: BorderRadius.circular(
                                                                      media.width * 0.075),
                                                                ),
                                                                child: FittedBox(
                                                                  child: Text(
                                                                    "230kCal\nleft",
                                                                    textAlign: TextAlign.center,
                                                                    style: TextStyle(
                                                                        color: TColor.white,
                                                                        fontSize: 11),
                                                                  ),
                                                                ),
                                                              ),

                                                            ],
                                                          ),
                                                        ),
                                                      )
                                                    ]),
                                              ),
                                            ],
                                          ))
                                    ],
                                  ),
                                  SizedBox(
                                    height: media.width * 0.1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );

                      } else {
                        // Data is still loading, you can show a loading indicator
                        return Center(
                          child: CircularProgressIndicator(),

                        );

                      }
                    },
                  ),
                ),

                bottomNavigationBar: Footer( selectTab: 0,)
            );
          } else {
            // Data is still loading, you can show a loading indicator
            return const Center(
              child: CircularProgressIndicator(
              ),
            );
          }
        },

      ),
    );
  }


  String classifyBMI(double bmi) {

    if (bmi < 18.5) {
      return 'Insufficient Weight';
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return 'Normal Weight';
    } else if (bmi >= 25 && bmi <= 26.9) {
      return 'Overweight Grade I';
    } else if (bmi >= 27 && bmi <= 29.9) {
      return 'Overweight Grade II (pre-obesity)';
    } else if (bmi >= 30 && bmi <= 34.9) {
      return 'Type I Obesity';
    } else if (bmi >= 35 && bmi <= 39.9) {
      return 'Type II Obesity';
    } else if (bmi >= 40 && bmi <= 49.9) {
      return 'Type III Obesity (morbid)';
    } else {
      return 'Type VI Obesity (extreme)';
    }
  }


  List<PieChartSectionData> showingSections(double bmi) {
    return List.generate(
      2,
          (i) {
        var color0 = TColor.secondaryColor1;


        switch (i) {
          case 0:
            return PieChartSectionData(
                color: color0,
                value: 33,
                title: '',
                radius: 55,
                titlePositionPercentageOffset: 0.55,
                badgeWidget: Text(
                  bmi.toStringAsFixed(2),
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 12,
                      fontWeight: FontWeight.w700),
                ));
          case 1:
            return PieChartSectionData(
              color: Colors.white,
              value: 75,
              title: '',
              radius: 45,
              titlePositionPercentageOffset: 0.55,
            );

          default:
            throw Error();
        }
      },
    );
  }

  LineTouchData get lineTouchData1 => LineTouchData(
    handleBuiltInTouches: true,
    touchTooltipData: LineTouchTooltipData(
      tooltipBgColor: Colors.blueGrey.withOpacity(0.8),
    ),
  );

  List<LineChartBarData> get lineBarsData1 => [
    lineChartBarData1_1,
    lineChartBarData1_2,
  ];

  LineChartBarData get lineChartBarData1_1 => LineChartBarData(
    isCurved: true,

    barWidth: 4,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(show: false),
    spots: const [
      FlSpot(1, 35),
      FlSpot(2, 70),
      FlSpot(3, 40),
      FlSpot(4, 80),
      FlSpot(5, 25),
      FlSpot(6, 70),
      FlSpot(7, 35),
    ],
  );

  LineChartBarData get lineChartBarData1_2 => LineChartBarData(
    isCurved: true,

    barWidth: 2,
    isStrokeCapRound: true,
    dotData: FlDotData(show: false),
    belowBarData: BarAreaData(
      show: false,
    ),
    spots: const [
      FlSpot(1, 80),
      FlSpot(2, 50),
      FlSpot(3, 90),
      FlSpot(4, 40),
      FlSpot(5, 80),
      FlSpot(6, 35),
      FlSpot(7, 60),
    ],
  );

  SideTitles get rightTitles => SideTitles(

    showTitles: true,
    interval: 20,
    reservedSize: 40,
  );


  SideTitles get bottomTitles => SideTitles(
    showTitles: true,
    reservedSize: 32,
    interval: 1,

  );

}
