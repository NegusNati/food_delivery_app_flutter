import 'package:get/get.dart';

import '../coltrollers/popular_product_controller.dart';
import '../data/api/api_client.dart';
import '../data/api/repository/popular_product_repo.dart';
import '../utills/app_constants.dart';

Future<void> init() async {

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));

// repos
  Get.lazyPut(() => PopularPoductRepo(apiClient: Get.find()));

  //Controllers
    Get.lazyPut(() => PopularProductController(popularPoductRepo: Get.find()));
}
