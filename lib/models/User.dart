class User{
  String? id;
  String nom;
  String prenom;
  String email;
  String password;
  String sex;
  int age;
  double taille;
  double poids;
  DateTime? date;


  User({this.id,required this.nom, required this.prenom,required this.email,required this.password,
  required this.sex,required this.age,required this.taille,required this.poids, this.date});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'] ?? '',
      nom: json['nom'] ?? '',
      prenom: json['prenom'] ?? '',
      email: json['email'] ?? '',
      password: json['password']?? '',
      sex:json['sex']?? '',
      age: json['age']?.toInt() ?? 0,
      taille: json['taille']?.toDouble() ?? 0.0,
      poids: json['poids']?.toDouble() ?? 0.0,
      date: json['date'] != null ? DateTime.parse(json['date']) : null,



    );


  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "password":password,
      "sex": sex,
      "age": age,
      "taille": taille,
      "poids": poids,
      "date": date,
    };
  }
}


