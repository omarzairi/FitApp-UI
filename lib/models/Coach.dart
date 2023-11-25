class Coach {
  String? id;
  String nom;
  String prenom;
  String email;
  String password;
  String sex;
  int age;
  String image;

  Coach({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.sex,
    required this.age,
    required this.image,
  });

  factory Coach.fromJson(Map<String, dynamic> json) {
    return Coach(
      id: json['_id'],
      nom: json['nom'],
      prenom: json['prenom'],
      email: json['email'],
      password: json['password'],
      sex: json['sex'],
      age: json['age']?.toInt() ?? 0,
      image: json['image'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "_id": id,
      "nom": nom,
      "prenom": prenom,
      "email": email,
      "password": password,
      "sex": sex,
      "age": age,
      "image": image,
    };
  }
}
