class Coach {
  String? id;
  String nom;
  String prenom;
  String email;
  String password;
  String sex;
  int age;
  String image;
  String description;
  int yearsOfExperience;
  String speciality;
  int price;
  int phoneNumber;

  Coach({
    this.id,
    required this.nom,
    required this.prenom,
    required this.email,
    required this.password,
    required this.sex,
    required this.age,
    required this.image,
    required this.description,
    required this.yearsOfExperience,
    required this.speciality,
    required this.price,
    required this.phoneNumber,
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
      description: json['description'] ?? '',
      yearsOfExperience: json['yearsOfExperience']?.toInt() ?? 0,
      speciality: json['speciality'] ?? '',
      price: json['price']?.toInt() ?? 0,
      phoneNumber: json['phoneNumber']?.toInt() ?? 0,
    );
  }

  static List<Coach> fromJsonList(List<dynamic> json) {
    List<Coach> coaches = [];
    json.forEach((element) {
      coaches.add(Coach.fromJson(element));
    });
    return coaches;
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
      "description": description,
      "yearsOfExperience": yearsOfExperience,
      "speciality": speciality,
      "price": price,
      "phoneNumber": phoneNumber,
    };
  }
}
