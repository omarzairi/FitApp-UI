import 'package:fitapp/models/Aliment.dart';
class AlimentQuantity {
  Aliment aliment;
  int quantity;

  AlimentQuantity({
    required this.aliment,
    required this.quantity,
  });

  factory AlimentQuantity.fromJson(Map<String, dynamic> json) {
    return AlimentQuantity(
      aliment: Aliment.fromJson(json['aliment']),
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'aliment': aliment.toJson(),
      'quantity': quantity,
    };
  }
}
class Consumption {
  String id;
  List<AlimentQuantity> aliments;
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
    required this.total,
  });

  factory Consumption.fromJson(Map<String, dynamic> json) {
    var list = json['aliments'] as List;
    List<AlimentQuantity> alimentList = list.map((i) => AlimentQuantity.fromJson(i)).toList();

    return Consumption(
      id: json['_id'] ?? '',
      aliments: alimentList,
      user: json['user'],
      consumptionDate: json['consumptionDate'],
      mealType: json['mealType'],
      total: json['total'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'aliments': aliments.map((alimentQuantity) => alimentQuantity.toJson()).toList(),
      'user': user,
      'consumptionDate': consumptionDate,
      'mealType': mealType,
      'total': total,
    };
  }

    //fromJsonList
  static List<Consumption> fromJsonList(List<dynamic> json) {
    List<Consumption> consumptions = [];
    json.forEach((element) {
      consumptions.add(Consumption.fromJson(element));
    });
    return consumptions;
  }
}