import 'dart:convert';

List<OrdershowModel> postFromJson(String str) => List<OrdershowModel>.from(
    json.decode(str)['data'].map((x) => OrdershowModel.fromJson(x)));

class OrdershowModel {
  int? id;
  String? type;
  Attributes? attributes;

  OrdershowModel({this.id, this.type, this.attributes});

  OrdershowModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attributes = json['attributes'] != null
        ? new Attributes.fromJson(json['attributes'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.attributes != null) {
      data['attributes'] = this.attributes!.toJson();
    }
    return data;
  }
}

class Attributes {
  String? userId;
  String? invoiceId;
  int? recipientId;
  int? senderId;
  String? originalBranch;
  String? destinationBranch;
  String? orderDate;
  String? orderMonth;
  String? orderYear;
  String? status;
  List<OrderItem>? orderItem;

  Attributes(
      {this.userId,
      this.invoiceId,
      this.recipientId,
      this.senderId,
      this.originalBranch,
      this.destinationBranch,
      this.orderDate,
      this.orderMonth,
      this.orderYear,
      this.status,
      this.orderItem});

  Attributes.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    invoiceId = json['invoice_id'];
    recipientId = json['recipient_id'];
    senderId = json['sender_id'];
    originalBranch = json['original_branch'];
    destinationBranch = json['destination_branch'];
    orderDate = json['order_date'];
    orderMonth = json['order_month'];
    orderYear = json['order_year'];
    status = json['status'];
    if (json['order_item'] != null) {
      orderItem = <OrderItem>[];
      json['order_item'].forEach((v) {
        orderItem!.add(new OrderItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['user_id'] = this.userId;
    data['invoice_id'] = this.invoiceId;
    data['recipient_id'] = this.recipientId;
    data['sender_id'] = this.senderId;
    data['original_branch'] = this.originalBranch;
    data['destination_branch'] = this.destinationBranch;
    data['order_date'] = this.orderDate;
    data['order_month'] = this.orderMonth;
    data['order_year'] = this.orderYear;
    data['status'] = this.status;
    if (this.orderItem != null) {
      data['order_item'] = this.orderItem!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class OrderItem {
  int? id;
  String? type;
  Attribute? attribute;

  OrderItem({this.id, this.type, this.attribute});

  OrderItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    attribute = json['attribute'] != null
        ? new Attribute.fromJson(json['attribute'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    if (this.attribute != null) {
      data['attribute'] = this.attribute!.toJson();
    }
    return data;
  }
}

class Attribute {
  String? parcelName;
  String? widthHeigth;
  String? weight;
  String? orderId;
  String? categoryId;

  Attribute(
      {this.parcelName,
      this.widthHeigth,
      this.weight,
      this.orderId,
      this.categoryId});

  Attribute.fromJson(Map<String, dynamic> json) {
    parcelName = json['parcel_name'];
    widthHeigth = json['width_heigth'];
    weight = json['weight'];
    orderId = json['order_id'];
    categoryId = json['category_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['parcel_name'] = this.parcelName;
    data['width_heigth'] = this.widthHeigth;
    data['weight'] = this.weight;
    data['order_id'] = this.orderId;
    data['category_id'] = this.categoryId;
    return data;
  }
}

////////////////////////////////////////////
class Orderitemss {
  String? categoryId;
  String? parcelname;
  String? weight;
  String? widthheight;
 

  Orderitemss({
    required this.categoryId,
    required this.parcelname,
    required this.weight,
    required this.widthheight,
  });
}
