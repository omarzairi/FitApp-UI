class Workout {

  String id;
  String name;
  String image;
  String video;
  String category;
  String description;

  Workout({
    required this.id,
    required this.name,
    required this.image,
    required this.video,
    required this.category,
    required this.description
});

  factory Workout.fromJson(Map<String, dynamic> json) {
    return Workout(
      id: json['_id'] ?? 'defaultId',
      name: json['name'] ?? '',
      image: json['image'] ?? '',
      video: json['video'] ?? '',
      category: json['category'] ?? '',
      description: json['description'] ?? '',
    );
  }

  static List<Workout> fromJsonList(List<dynamic> json){
    List<Workout> workouts = [];
    json.forEach((element) {
      workouts.add(Workout.fromJson(element));
    });
    return workouts;
  }

  static List<dynamic> toJsonList(List<Workout> workouts){
    return workouts.map((workout)=> workout.toJson()).toList();
  }

  Map<String,dynamic> toJson(){
    return{
      "_id":id,
      "name":name,
      "image":image,
      "video":video,
      "category":category,
      "description":description
    };
  }

}