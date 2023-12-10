import 'package:fitapp/controllers/workout_controller.dart';
import 'package:fitapp/models/UserWorkoutList.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/theme_colors.dart';

class UserWorkoutListView extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _UserWorkoutListView();
}

class _UserWorkoutListView extends State<UserWorkoutListView> {
  final WorkoutController workoutController = Get.put(WorkoutController());

  @override
  void initState() {
    super.initState();
    if (workoutController.userlist==null) {
      workoutController.getuserWorkouts();
    }
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
          "User Workout List",
          style: TextStyle(
            color: TColor.black,
            fontSize: 20,
            letterSpacing: 1,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
      body: Obx(
            () => workoutController.isLoading.value
            ? Center(child: CircularProgressIndicator())
            : Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  padding: EdgeInsets.only(left: 10),
                  child: Text(
                    'Your Workouts' +
                        '( ${workoutController.userlist?.worklist.length})',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w300,
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                itemCount: workoutController.userlist?.worklist.length,
                itemBuilder: (context, index) {
                  var userWorkoutList =
                  workoutController.userlist?.worklist;
                  return InkWell(
                    onTap: () {
                      // Handle tap on userWorkoutList if needed
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.white,
                        ),
                        padding: EdgeInsets.all(8.0),
                        child: ListTile(
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Workouts: ${userWorkoutList?.length}',
                                style:
                                TextStyle(fontWeight: FontWeight.bold),
                              ),
                              SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
