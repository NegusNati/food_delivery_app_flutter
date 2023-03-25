import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:get/get.dart';

import '../coltrollers/cart_controller.dart';
import '../data/api/repository/cart_repo.dart';
import '../pages/cart/cart_page.dart';
import '../pages/detail/popular_food_detail.dart';
import '../pages/detail/recomended_food_detail.dart';
import '../pages/home/main_page.dart';

class RouteHelper {
  static const String inital = "/";
  static const String popularFood = "/popular-food";
  static const String recomendedFood = "/recomended-food";
  static const String cartPage = "/cart-page";

  //best way by far for data passing
  static String getInital() => inital;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecomendedFood(int pageId) =>
      '$recomendedFood?pageId=$pageId';
  static String getCartPage() => cartPage;

  static List<GetPage> routes = [
    GetPage(name: inital, page: () => const HomePage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          // Get.lazyPut(() => CartController(cartRepo: CartRepo()));
          return PopularFoodDetail(pageId: int.parse(pageId!));
        },

        //to make cool trasitions of routes
        transition: Transition.zoom),
    GetPage(
        name: recomendedFood,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecomendedFoodDetail(pageId: int.parse(pageId!));
        },
        //to make cool trasitions of routes
        transition: Transition.zoom),
    GetPage(
        name: cartPage,
        page: () {
          return const CartPage();
        },
        //to make cool trasitions of routes
        transition: Transition.fadeIn),
  ];
}
