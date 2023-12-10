class Aliment {
  String id;
  String name;
  double calories;
  double protein;
  double carbs;
  double fat;
  double sugar;
  String? image;
  double servingSize;
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
      id: json['_id'] ?? '',
      name: json['name'] ?? '',
      calories: json['calories'].toDouble(),
      protein: json['protein'].toDouble(),
      carbs: json['carbs'].toDouble(),
      fat: json['fat'].toDouble(),
      sugar: json['sugar'].toDouble(),
      image: json['image'] ?? '',
      servingSize: json['servingSize'].toDouble(),
      servingUnit: json['servingUnit'],
    );
  }

  static List<Aliment> fromJsonList(List<dynamic> json) {
      List<Aliment> aliments = [];
      json.forEach((element) {
        aliments.add(Aliment.fromJson(element));
      });
      return aliments;
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

  static List<dynamic> toJsonList(List<Aliment> aliments) {
    return aliments.map((aliment) => aliment.toJson()).toList();
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Aliment && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
