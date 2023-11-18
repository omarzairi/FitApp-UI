class ConsumptionFact{
  String id;
  double totalCalories;
  double totalProtein;
  double totalCarbs;
  double totalFat;
  double totalSugar;
  double totalServingSize;

  ConsumptionFact({
    required this.id,
    required this.totalCalories,
    required this.totalProtein,
    required this.totalCarbs,
    required this.totalFat,
    required this.totalSugar,
    required this.totalServingSize,

});

  factory ConsumptionFact.fromJson(Map<String,dynamic> json)
  {
    return ConsumptionFact(
      id:json['_id'] ?? '',
        totalCalories : json['totalCalories'].toDouble(),
        totalProtein : json['totalProtein'].toDouble(),
        totalCarbs : json['totalCarbs'].toDouble(),
      totalFat: json['totalFat'].toDouble(),
        totalSugar: json['totalSugar'].toDouble(),
        totalServingSize : json['totalServingSize'].toDouble()
    );
  }

  Map<String, dynamic> toJson()
  {
    return {
      "_id":id,
      "totalCalories" : totalCalories,
      "totalProtein" :totalProtein,
      "totalCarbs" : totalCarbs,
      "totalFat" : totalFat,
      "totalSugar" : totalSugar,
      "totalServingSize" : totalServingSize
    };
  }

}