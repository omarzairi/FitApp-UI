import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:fitapp/controllers/workout_controller.dart';
import '../../utils/theme_colors.dart';
import 'workoutDetails.dart';

class WorkoutListView extends StatefulWidget {
  @override
  _WorkoutListViewState createState() => _WorkoutListViewState();
}

class _WorkoutListViewState extends State<WorkoutListView> {
  final WorkoutController workoutController = Get.put(WorkoutController());
  TextEditingController txtSearch = TextEditingController();

  @override
  void initState() {
    super.initState();
    if (workoutController.workoutList.isEmpty) {
      workoutController.getAllWorkouts();
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
          "Workouts",
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
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              decoration: BoxDecoration(
                color: TColor.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: const [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 2,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: txtSearch,
                      onChanged: (value) {
                        // Trigger search here
                        workoutController.searchWorkoutWithQuery({
                          'name': value,
                        });
                      },
                      decoration: InputDecoration(
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: TColor.gray.withOpacity(0.5),
                          size: 20,
                        ),
                        hintText: "Search Workouts",
                      ),
                    ),
                  ),
                  Container(
                    margin:
                    const EdgeInsets.symmetric(horizontal: 8),
                    width: 1,
                    height: 25,
                    color: TColor.gray.withOpacity(0.3),
                  ),
                  InkWell(
                    onTap: () {
                      // Handle filter button tap
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
                        Icons.filter_list,
                        color: TColor.black,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: 40,
              margin: EdgeInsets.symmetric(vertical: 10),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    buildCategoryButton("abdominals"),
                    buildCategoryButton("biceps"),
                    buildCategoryButton("triceps"),
                    buildCategoryButton("chest"),
                    buildCategoryButton("lats"),
                    buildCategoryButton("quadriceps"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: workoutController.workoutList.length,
                itemBuilder: (context, index) {
                  if (index >= workoutController.workoutList.length) {
                    return null;
                  }
                  var workout = workoutController.workoutList[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(0.0),
                        color: Colors.white,
                      ),
                      padding: EdgeInsets.all(8.0),
                      child: ListTile(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  WorkoutDetail(index: index),
                            ),
                          );
                        },
                        contentPadding: EdgeInsets.all(16.0),
                        leading: Container(
                          width: 72.0,
                          height: 72.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: workout.image != "none"
                                  ? NetworkImage(workout.image!)
                                  : NetworkImage(
                                'https://www.healthkart.com/connect/wp-content/uploads/2023/05/Sit-Ups-Exercises-Variations-and-More-_900.jpg',
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          workout.name,
                          style: TextStyle(fontSize: 18.0),
                        ),
                        subtitle: Text(
                          workout.category,
                          style: TextStyle(fontSize: 16.0),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.add_box),
                          onPressed: () {
                            print("the id is here wtf : ${workout.id}");
                            workoutController.addWorkoutToUserList(
                                workoutController.workoutList[index].id);
                            print(
                                'Button tapped for item at index $index');
                          },
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

  String capitalizeFirstLetter(String text) {
    if (text == null || text.isEmpty) {
      return text;
    }
    return text[0].toUpperCase() + text.substring(1);
  }

  Widget buildCategoryButton(String category) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5),
      child: ElevatedButton(
        onPressed: () {
          workoutController.searchWorkoutWithQuery({
            'category': category,
          });
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: TColor.secondaryColor1,
          onPrimary: TColor.white,
        ),
        child: Text(capitalizeFirstLetter(category)),
      ),
    );
  }
}
