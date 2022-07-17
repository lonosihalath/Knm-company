
import 'package:get/state_manager.dart';
import 'package:knm/condition/model.dart';
import 'package:knm/condition/service.dart';

class ConditionController extends GetxController {
  var isLoading = true.obs;
  var statetList = <Condition1>[].obs;

  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServiceCondition.fetchBranch();
      if (products != null) { 
        statetList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
