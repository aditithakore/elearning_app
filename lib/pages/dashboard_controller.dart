import 'package:elearning_app/services/userService.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isLoading = false;
  @override
  void onInit() async {
    isLoading = true;
    await Get.find<UserService>().fetchUser();
    isLoading = false;
    super.onInit();
  }
}
