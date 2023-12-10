import 'package:fitapp/models/UserWorkoutList.dart';
import 'package:fitapp/models/workout.dart';
import 'package:fitapp/services/workoutService.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';

class WorkoutController extends GetxController {
  var workoutList = <Workout>[].obs;

  var userworkoutlist = <UserWorkoutList>[].obs;

  UserWorkoutList? userlist;

  var isLoading = true.obs;
  final storage = const FlutterSecureStorage();

  @override
  Future<void> onInit() async{
    print("done");
    super.onInit();
  }

  Future<Workout?> getAllWorkouts() async {
    try{
      isLoading(true);
      var response = await WorkoutService().getAllWorkouts();
      if (response.statusCode == 200)
      {
          var workouts = Workout.fromJsonList(response.data);
          if(workouts != null){
              workoutList.assignAll(workouts);
          }
      }
  }
  catch(e)
  {
      throw Exception(e.toString());
  }
  finally{
      isLoading(false);
  }
  }



  Workout getWorkout(int index){
    return workoutList[index];
  }


  Future<Workout?> getuserWorkouts() async {
    try{
      isLoading(true);
      var response = await WorkoutService().getWorkoutlistUser();
      if (response.statusCode == 200)
      {
        /*var workoutListuser = UserWorkoutList.fromJsonList(response.data);
        if(workoutListuser !=null){
          userworkoutlist.assignAll(workoutListuser);
        }*/
        userlist=response.data;
      }
    }
    catch(e)
    {
      throw Exception(e.toString());
    }
    finally{
      isLoading(false);
    }
  }


  Future<void> addWorkoutToUserList(String id) async{
    try{
      var response = await WorkoutService().addWorkoutToList(id);
      if(response.statusCode == 200){
        print("added workout to list ");
        var workoutListuser = UserWorkoutList.fromJsonList(response.data);
        if(workoutListuser !=null){
          userworkoutlist.assignAll(workoutListuser);
        }
      }
    }
    catch(e){
      throw Exception(e.toString());
    }
  }

  Future<void> searchWorkoutWithQuery(Map<String,dynamic> query) async{
    try{

      var response = await WorkoutService().searchWorkoutwithQuery(query);
      if(response.statusCode == 200){
        var workouts = Workout.fromJsonList(response.data);
        if(workouts!=null){
          workoutList.assignAll(workouts);
        }
      }
  }
  catch(e)
  {
    throw Exception(e.toString());
  }
  finally{
      print('done');
  }
  }




}