import 'dart:convert';

List<PriceNN> priceNNFromJson(String str) => List<PriceNN>.from(json.decode(str).map((x) => PriceNN.fromJson(x)));
class PriceNN {
  int? id;
  String? price;

  PriceNN({this.id, this.price});

  PriceNN.fromJson(Map<String, dynamic> json) {
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
