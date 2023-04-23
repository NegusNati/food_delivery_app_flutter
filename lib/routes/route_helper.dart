import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../pages/cart/cart_page.dart';
import '../pages/detail/popular_food_detail.dart';
import '../pages/detail/recomended_food_detail.dart';

class RouteHelper {
  static const String inital = "/";
  static const String popularFood = "/popular-food";
  static const String recomendedFood = "/recomended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";
  static const String signIn = "/sign-in";

  //best way by far for data passing
  static String getInital() => inital;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecomendedFood(int pageId) =>
      '$recomendedFood?pageId=$pageId';
  static String getCartPage() => cartPage;
  static String getSplashPage() => splashPage;
  static String getSignIn() => signIn;

  static List<GetPage> routes = [
    GetPage(name: inital, page: () => const HomePage()),
     GetPage(name: signIn, page: () => const SignInPage(), transition: Transition.fade),
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
    GetPage(
        name: splashPage,
        page: () {
          return const SplashScreen();
        },
        transition: Transition.fadeIn,
        ),
  ];
}
