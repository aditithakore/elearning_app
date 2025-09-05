import 'package:elearning_app/models/userProfile.dart';
import 'package:elearning_app/services/userService.dart';
import 'package:get/get.dart';

class DashboardController extends GetxController {
  var isLoading = false.obs; // Make isLoading observable
  var userProfile = UserProfile().obs; // Add observable UserProfile

  @override
  void onInit() async {
    super.onInit();
    isLoading.value = true;
    await fetchUserProfile();
    isLoading.value = false;
    print(userProfile.value.sId);
  }

  Future<void> fetchUserProfile() async {
    print("this is called");

    // final controller= Get.put(()=>UserService());
    userProfile.value =await UserService().fetchUser();
  }
}
