class Aliment {
  String id;
  String name;
  int calories;
  int protein;
  int carbs;
  int fat;
  int sugar;
  String? image;
  int servingSize;
  String servingUnit;

  Aliment({
    required this.id,
    required this.name,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    this.image,
    required this.servingSize,
    required this.servingUnit,
  });

  factory Aliment.fromJson(Map<String, dynamic> json) {
    return Aliment(
      id: json['_id'],
      name: json['name'],
      calories: json['calories'],
      protein: json['protein'],
      carbs: json['carbs'],
      fat: json['fat'],
      sugar: json['sugar'],
      image: json['image'],
      servingSize: json['servingSize'],
      servingUnit: json['servingUnit'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'sugar': sugar,
      'image': image,
      'servingSize': servingSize,
      'servingUnit': servingUnit,
    };
  }
}