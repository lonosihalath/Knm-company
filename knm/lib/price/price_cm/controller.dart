import 'package:get/state_manager.dart';
import 'package:knm/price/price_cm/model.dart';
import 'package:knm/price/price_cm/service.dart';

class PriceCMController extends GetxController {
  var isLoading = true.obs;
  var statetList = <PriceCM>[].obs;

  @override
  void onInit(){
    fetchData();
    super.onInit();
  }

  void fetchData() async {
    try {
      isLoading(true);
      var pricecm = await RemoteServicePriceCM.fetchCategories();
      if (pricecm != null) {
        statetList.value = pricecm;
      }
    } finally {
      isLoading(false);
    }
  }
}
