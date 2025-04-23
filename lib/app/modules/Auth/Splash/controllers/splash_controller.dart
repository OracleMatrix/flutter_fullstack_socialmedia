import 'package:fullstack_socialmedia/app/data/Constants/constants.dart';
import 'package:fullstack_socialmedia/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  Future checkToken() async {
    final token = await GetStorage().read(Constants.tokenKey);
    if (token != null) {
      Get.offAllNamed(Routes.HOME);
    } else {
      Get.offAllNamed(Routes.AUTH);
    }
  }
}
