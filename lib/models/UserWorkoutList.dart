import 'package:fitapp/models/workout.dart';

class UserWorkoutList{
  String? id;
  String user;
  List<Workout> worklist;


  UserWorkoutList({
    required this.id,
    required this.user,
    required this.worklist
});
  
  factory UserWorkoutList.fromJson(Map<String, dynamic> json){
    return UserWorkoutList(
      id: json['_id'],
      user: json['user'],
        worklist: List<Workout>.from(json['worklist'].map((x)=>Workout.fromJson(x)))
    );
  }

  static List<UserWorkoutList> fromJsonList(List<dynamic> jsonList){
    return jsonList.map((json) => UserWorkoutList.fromJson(json)).toList() ;
  }

  static List<dynamic> toJsonList(List<UserWorkoutList> userWorkoutList){
    return userWorkoutList.map((workout) => workout.toJson()).toList();
  }

  Map<String,dynamic> toJson()
  {
    return{
      '_id':id,
      'user':user,
      'worklist':Workout.toJsonList(worklist)
    };
  }
  
}