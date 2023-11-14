class Objectif{
  String id;
  String user;
  double poidsObj;
  DateTime? date;
  int? duree;
  String actPhysique;
  double poidsParSemaine;
  double? calories;

  Objectif({required this.id,required this.user,required this.poidsObj, this.date, this.duree,required this.actPhysique,required this.poidsParSemaine, this.calories});

  factory Objectif.fromJson(Map<String, dynamic> json) {
    return Objectif(
      id: json['_id'] ?? '',
      user: json['user'] ?? '',
      poidsObj: json['poidsObj'].toDouble(),
      date: json['date'] != null ? DateTime.parse(json['date']) : null,
      duree: json['duree']?.toInt(),
      actPhysique: json['actPhysique'] ?? '',
      poidsParSemaine: json['poidsParSemaine'].toDouble(),
      calories: json['calories']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "user": user,
      "poidsObj": poidsObj,
      "date": date,
      "duree": duree,
      "actPhysique": actPhysique,
      "poidsParSemaine": poidsParSemaine,
      "calories": calories,
    };
  }

  
}
