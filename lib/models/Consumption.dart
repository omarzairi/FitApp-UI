import 'package:fitapp/models/Aliment.dart';

class Consumption{

  String id;
  List<Aliment> aliments;
  String user;
  String consumptionDate;
  String mealType;
  double total;

  Consumption({
    required this.id,
    required this.aliments,
    required this.user,
    required this.consumptionDate,
    required this.mealType,
    required this.total
});

  factory Consumption.fromJson(Map<String, dynamic> json)
  {
    return Consumption(
        id: json['_id'] ?? '',
        aliments: json['aliments'],
        user: json['user'],
        consumptionDate: json['consumptionDate'],
        mealType: json['mealType'],
        total: json['total']
    );
  }

  Map<String,dynamic> toJson()
  {
    return {
      "_id": id,
      "aliments": aliments,
      "user" :user,
      "consumptionDate" : consumptionDate,
      "mealType" : mealType,
      "total" : total,
    };
  }

}