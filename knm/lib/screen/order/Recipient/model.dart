class Recipient {
  int id;
    String name;
    String surname;
    String tel;
    String address;


  Recipient({
    required this.id,
    required this.name,
    required this.surname,
    required this.tel,
    required this.address,
  });

  factory Recipient.fromJson(Map<String, dynamic> json) {
    return Recipient(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      tel: json['tel'],
      address: json['address'],
    );
  }
}
////////////////////////////////////////////////////////////////
class Sender {
    int id;
    String name;
    String surname;
    String tel;
    String address;


 Sender({
    required this.id,
    required this.name,
    required this.surname,
    required this.tel,
    required this.address,
  });

  factory Sender.fromJson(Map<String, dynamic> json) {
    return Sender(
      id: json['id'],
      name: json['name'],
      surname: json['surname'],
      tel: json['tel'],
      address: json['address'],
    );
  }
}
