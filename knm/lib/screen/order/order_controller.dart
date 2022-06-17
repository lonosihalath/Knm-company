import 'package:get/state_manager.dart';
import 'package:knm/screen/order/order_service.dart';
import 'package:knm/screen/order/show_order_model.dart';


class OrderShowController extends GetxController {
  var isLoading = true.obs;
  var statetList = <OrdershowModel>[].obs;

  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServiceOrder.fetchData();
      if (products != null) {
        statetList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
