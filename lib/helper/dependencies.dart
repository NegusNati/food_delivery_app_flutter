import 'package:food_delivery_app/coltrollers/location_controller.dart';
import 'package:food_delivery_app/data/api/repository/location_repo.dart';
import 'package:food_delivery_app/data/api/repository/user_repo.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../coltrollers/auth_controller.dart';
import '../coltrollers/cart_controller.dart';
import '../coltrollers/order_controller.dart';
import '../coltrollers/popular_product_controller.dart';
import '../coltrollers/recomended_products_controller.dart';
import '../coltrollers/user_controller.dart';
import '../data/api/api_client.dart';
import '../data/api/repository/auth_repo.dart';
import '../data/api/repository/cart_repo.dart';
import '../data/api/repository/order_repo.dart';
import '../data/api/repository/popular_product_repo.dart';
import '../data/api/repository/recomended_product_repo.dart';
import '../utills/app_constants.dart';

Future<void> init() async {
  //data is here
  final sharedPreferences = await SharedPreferences.getInstance();

//but we need to tell getx about local Data,
  Get.lazyPut(() => sharedPreferences);

  // api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL, sharedPreferences: Get.find()));
  Get.lazyPut(
      () => AuthRepo(apiClient: Get.find(), sharedPreferences: Get.find()));

// repos
  Get.lazyPut(() => PopularPoductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecomendedPoductRepo(apiClient: Get.find()));
  Get.lazyPut(fenix: true, () => CartRepo(sharedPreferences: Get.find()));
  Get.lazyPut(() => UserRepo(apiClient: Get.find()));
  Get.lazyPut(() => LocationRepo(apiClient: Get.find(), sharedPreferences: Get.find()));
  Get.lazyPut(() => OrderRepo(apiClient: Get.find()));

  //Controllers
  Get.lazyPut(() => AuthController(authRepo: Get.find()));
  Get.lazyPut(() => UserController(userRepo: Get.find()));
  Get.lazyPut(() => PopularProductController(popularPoductRepo: Get.find()));
  Get.lazyPut(
      () => RecomendedProductController(recomendedPoductRepo: Get.find()));
  Get.lazyPut(fenix: true, () => CartController(cartRepo: Get.find()));
  Get.lazyPut( () => LocationController(locationRepo: Get.find()));
  Get.lazyPut( () => OrderController(orderRepo: Get.find()));
}
