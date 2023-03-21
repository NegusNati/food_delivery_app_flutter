import 'package:get/get.dart';

import '../coltrollers/cart_controller.dart';
import '../coltrollers/popular_product_controller.dart';
import '../coltrollers/recomended_products_controller.dart';
import '../data/api/api_client.dart';
import '../data/api/repository/cart_repo.dart';
import '../data/api/repository/popular_product_repo.dart';
import '../data/api/repository/recomended_product_repo.dart';
import '../utills/app_constants.dart';

Future<void> init() async {

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl:AppConstants.BASE_URL));

// repos
  Get.lazyPut(() => PopularPoductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecomendedPoductRepo(apiClient: Get.find()));
  Get.lazyPut(
   fenix: true,
     () => CartRepo());

  //Controllers
    Get.lazyPut(() => PopularProductController(popularPoductRepo: Get.find()));
    Get.lazyPut(() => RecomendedProductController(recomendedPoductRepo: Get.find()));
    Get.lazyPut(
       fenix: true,
      () => CartController(cartRepo: Get.find()));

    
}
