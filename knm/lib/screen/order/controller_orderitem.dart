import 'package:get/get.dart';
import 'package:knm/screen/order/show_order_model.dart';

class OrderItemController extends GetxController {
  Map<int, Orderitemss> _items = {};
  Map<int, Orderitemss> get items {
    return {..._items};
  }

  void addItem(
      int productId, String categoryId, parcelname, widthheigth, weight) {
    if (_items.containsKey(productId)) {
      _items.update(
          productId,
          (existingCartItem) => Orderitemss(
              categoryId: existingCartItem.categoryId,
              parcelname: existingCartItem.parcelname,
              widthheight: existingCartItem.widthheight,
              weight: existingCartItem.weight));

      update();
      print('Ok');
    } else {
      _items.putIfAbsent(
        productId,
        () => Orderitemss(
          categoryId: categoryId,
          parcelname: parcelname,
          widthheight: widthheigth,
          weight: weight,
        ),
      );
    }
    print('Ok');
    update();
  }

   void removeitem(int productId) {
    _items.remove(productId);
    update();
  }

  void clear() {
    _items.clear();
    update();
  }
}
