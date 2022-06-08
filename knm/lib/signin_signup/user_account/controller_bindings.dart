
import 'package:get/instance_manager.dart';
import 'package:knm/signin_signup/user_account/controller.dart';

class ControllerBindings extends Bindings {
  @override
  void dependencies() {
    Get.put<Controller>(Controller());
  }
}
