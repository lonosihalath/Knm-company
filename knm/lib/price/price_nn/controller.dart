import 'package:get/state_manager.dart';
import 'package:knm/price/price_nn/model.dart';
import 'package:knm/price/price_nn/service.dart';

class PriceNNController extends GetxController {
  var isLoading = true.obs;
  var statetList = <PriceNN>[].obs;

  @override
  void onInit(){
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var pricenn = await RemoteServicePriceNN.fetchCategories();
      if (pricenn != null) {
        statetList.value = pricenn;
      }
    } finally {
      isLoading(false);
    }
  }
}
