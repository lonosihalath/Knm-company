import 'dart:convert';

List<Condition1> conditionFromJson(String str) => List<Condition1>.from(json.decode(str).map((x) => Condition1.fromJson(x)));

class Condition1 {
  int? id;
  String? note;

  Condition1({this.id, this.note,});

  Condition1.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    note = json['note'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['note'] = this.note;
    return data;
  }
}
