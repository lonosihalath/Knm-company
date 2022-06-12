
import 'package:get/state_manager.dart';
import 'package:knm/brand/brand_services.dart';
import 'package:knm/brand/model.dart';

class BranchController extends GetxController {
  var isLoading = true.obs;
  var statetList = <Brand>[].obs;

  @override
  void onInit(){
    fetchProducts();
    super.onInit();
  }

  void fetchProducts() async {
    try {
      isLoading(true);
      var products = await RemoteServiceBranch.fetchBranch();
      if (products != null) {
        statetList.value = products;
      }
    } finally {
      isLoading(false);
    }
  }
}
