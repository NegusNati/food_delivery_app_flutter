import 'package:get/get.dart';

import '../pages/detail/popular_food_detail.dart';
import '../pages/detail/recomended_food_detail.dart';
import '../pages/home/main_page.dart';

class RouteHelper {
  static const String inital = "/";
  //not the best way working with routes that pass data to pages
  static const String popularFood = "/popular-food";
  static const String recomendedFood = "/recomended-food";

  //best way by far for data passing
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecomendedFood(int pageId) =>
      '$recomendedFood?pageId=$pageId';
  static String getInital() => '$inital';

  static List<GetPage> routes = [
    GetPage(name: inital, page: () => const MainPage()),
    GetPage(
        name: popularFood,
        page: () {
          var pageId = Get.parameters['pageId'];
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
  ];
}
