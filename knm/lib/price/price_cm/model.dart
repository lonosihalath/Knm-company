import 'dart:convert';

List<PriceCM> priceCMFromJson(String str) => List<PriceCM>.from(json.decode(str).map((x) => PriceCM.fromJson(x)));

class PriceCM {
  int? id;
  String? price;

  PriceCM({this.id, this.price});

  PriceCM.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    price = json['price'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['price'] = this.price;
    return data;
  }
}
