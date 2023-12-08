import 'package:fitapp/common_widgets/coach_row.dart';
import 'package:fitapp/controllers/aliment_controller.dart';
import 'package:fitapp/common_widgets/meal_category_cell.dart';
import 'package:fitapp/common_widgets/meal_row.dart';
import 'package:fitapp/controllers/coach_controller.dart';
import 'package:fitapp/utils/theme_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'alimentDetails.dart';
import 'coach_details.dart';

class CoachesListPage extends StatefulWidget {
  CoachesListPage({super.key});

  @override
  _CoachesListPageState createState() => _CoachesListPageState();
}

class _CoachesListPageState extends State<CoachesListPage> {
  CoachController coachController = Get.put(CoachController());
  TextEditingController txtSearch = TextEditingController();
  final storage = FlutterSecureStorage();

  Future<String?> readToken() async {
    return await storage.read(key: 'userToken');
  }

  Future<void> initData() async {
    await readToken().then((userToken) {
      print('User Token: $userToken');
    });

    // Fetch data using controller
    coachController.getAllCoaches(); // Use getAllCoaches here
  }

  @override
  void initState() {
    super.initState();
    initData();
  }

  String formatNumber(double num) {
    return num % 1 == 0 ? num.toInt().toString() : num.toString();
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
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
      backgroundColor: TColor.lightGray,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                  color: TColor.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 2,
                        offset: Offset(0, 1))
                  ]),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtSearch,
                      onChanged: (query) {
                        // Trigger search when the text changes
                        coachController.searchACoachwithQuery({'nom': query});
                      },
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: TColor.gray.withOpacity(0.5),
                          size: 20,
                        ),
                        hintText: "Search coach name",
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 25,
                    color: TColor.gray.withOpacity(0.3),
                  ),
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
                        Icons.filter_list,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Coaches",
                    style: TextStyle(
                        color: TColor.black,
                        fontSize: 16,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: media.width * 0.05,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Text(
                "Recommendations",
                style: TextStyle(
                    color: TColor.black,
                    fontSize: 16,
                    fontFamily: 'Poppins',
                    fontWeight: FontWeight.w500),
              ),
            ),
            Container(
              constraints: BoxConstraints(
                minHeight: media.height * 0.5,
                maxHeight: media.height * 1.5,
              ),
              child: Obx(
                    () {
                  if (coachController.isLoading.value) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 15.0),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: coachController.coachesList.length,
                      itemBuilder: (context, index) {
                        return CoachRow(
                          coach: coachController.coachesList[index],
                          selected: false, // Set your selected logic here
                          onTap: () {
                            // Handle coach row tap
                            // You may want to navigate to coach details page
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CoachDetailsPage(coach: coachController.coachesList[index]),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                },
              ),

            ),
          ],
        ),
      ),
    );
  }
}
