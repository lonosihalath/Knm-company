class Users {
  int? id;
  String? name;
  String? surname;
  String? email;
  String? gender;
  String? birth;
  String? phone;
  String? profile;


  Users({
    required this.name,
    required this.surname,
    required this.email,
    required this.phone,
    required this.gender,
    required this.birth,
    required this.profile,
    required this.id,
  });

  factory Users.fromJson(Map<String, dynamic> json) {
    return Users(
      name: json['name'],
      surname: json['surname'],
      email: json['email'],
      phone: json['phone'],
      gender: json['gender'],
      birth: json['birth'],
      profile: json['profile'],
      id: json['id'],
    );
  }
}
