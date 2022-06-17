import 'package:flutter/material.dart';

import'package:get/get.dart';
import 'package:knm/screen/order/order_controller.dart';
import 'package:knm/screen/order/show_order_model.dart';

OrderShowController orderShowController = Get.put(OrderShowController());


class OrderName extends StatelessWidget {
  final List<OrdershowModel> ordershowModel;
  final int index;
  const OrderName({ Key? key, required this.ordershowModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(ordershowModel[index].attributes!.orderItem![index].attribute!.parcelName.toString());
  }
}
class OrderId extends StatelessWidget {
  final List<OrdershowModel> ordershowModel;
  final int index;
  const OrderId({ Key? key, required this.ordershowModel, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(ordershowModel[index].id.toString());
  }
}
