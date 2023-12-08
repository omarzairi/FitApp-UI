import 'Aliment.dart';

class PersonalizedMeal {
  String id;
  String user;
  String name;
  List<Aliment> aliments;

  PersonalizedMeal({
    required this.id,
    required this.user,
    required this.name,
    required this.aliments,
  });

  factory PersonalizedMeal.fromJson(Map<String, dynamic> json) {
    return PersonalizedMeal(
      id: json['_id'],
      user: json['user'],
      name: json['name'],
      aliments: List<Aliment>.from(json['aliments'].map((x) => Aliment.fromJson(x))),
    );
  }

  static List<PersonalizedMeal> fromJsonList(List<dynamic> jsonList) {
    return jsonList.map((json) => PersonalizedMeal.fromJson(json)).toList();
  }
  //toJSON
static List<dynamic> toJsonList(List<PersonalizedMeal> personalizedMealList) {
    return personalizedMealList.map((personalizedMeal) => personalizedMeal.toJson()).toList();
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'user': user,
      'name': name,
      'aliments': Aliment.toJsonList(aliments),
    };
  }
}