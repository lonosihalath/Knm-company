// To parse this JSON data, do
//
//     final brand = brandFromJson(jsonString);

import 'dart:convert';

List<Brand> postFromJson(String str) => List<Brand>.from(json.decode(str).map((x) => Brand.fromJson(x)));


class Brand {
    Brand({
        required this.id,
        required this.name,
        required this.division,
        required this.district,
        required this.state,
        required this.tel,
        this.createdAt,
        this.updatedAt,
    });

    int id;
    String name;
    String division;
    String district;
    String state;
    String tel;
    dynamic createdAt;
    dynamic updatedAt;

    factory Brand.fromJson(Map<String, dynamic> json) => Brand(
        id: json["id"],
        name: json["name"],
        division: json["division"],
        district: json["district"],
        state: json["state"],
        tel: json["tel"],
        createdAt: json["created_at"],
        updatedAt: json["updated_at"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "division": division,
        "district": district,
        "state": state,
        "tel": tel,
        "created_at": createdAt,
        "updated_at": updatedAt,
    };
}
