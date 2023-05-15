import 'package:food_delivery_app/models/order_model.dart';
import 'package:food_delivery_app/pages/address/add_address_page.dart';
import 'package:food_delivery_app/pages/auth/sign_in.dart';
import 'package:food_delivery_app/pages/home/home_page.dart';
import 'package:food_delivery_app/pages/payment/payment_page.dart';
import 'package:food_delivery_app/pages/splash/splash_page.dart';
import 'package:get/get.dart';

import '../models/user_model.dart';
import '../pages/address/pick_address_map.dart';
import '../pages/cart/cart_page.dart';
import '../pages/detail/popular_food_detail.dart';
import '../pages/detail/recomended_food_detail.dart';
import '../pages/order/order_success_page.dart';

class RouteHelper {
  static const String inital = "/";
  static const String popularFood = "/popular-food";
  static const String recomendedFood = "/recomended-food";
  static const String cartPage = "/cart-page";
  static const String splashPage = "/splash-page";
  static const String signIn = "/sign-in";
  static const String addAddress = "/add-address";
  static const String pickAddressMap = "/pick-address-map";
  static const String payment = "/payment";
  static const String orderSuccess = "/order-successful";

  //best way by far for data passing
  static String getInital() => inital;
  static String getPopularFood(int pageId) => '$popularFood?pageId=$pageId';
  static String getRecomendedFood(int pageId) =>
      '$recomendedFood?pageId=$pageId';
  static String getCartPage() => cartPage;
  static String getSplashPage() => splashPage;
  static String getSignIn() => signIn;
  static String getAddAddressPage() => addAddress;
  static String pickAddressMapPage() => pickAddressMap;
  static String getPaymentPage(String id, int userId) =>
      '$payment?id=$id&userId=$userId';
  static String getOrderSuccessRoute(String orderId, String status) =>
      '$orderSuccess?id=$orderId&status=$status';

  static List<GetPage> routes = [
    GetPage(
        name: inital,
        page: () => const HomePage(),
        transition: Transition.fade),
    GetPage(
        name: signIn,
        page: () => const SignInPage(),
        transition: Transition.fade),
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
          //passsing parameters
          var pageId = Get.parameters['pageId'];
          return RecomendedFoodDetail(pageId: int.parse(pageId!));
        },
        //to make cool trasitions of routes
        transition: Transition.zoom),
    GetPage(
        name: cartPage,
        page: () {
          return  CartPage();
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
    GetPage(
      name: addAddress,
      page: () {
        return const AddAddressPage();
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: pickAddressMap,
      page: () {
        //passing a widget
        PickAddressMap pickAddressMap = Get.arguments;
        return pickAddressMap;
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: payment,
      page: () {
        return PaymentPage(
            orderModel: OrderModel(
                id: int.parse(Get.parameters['id']!),
                userId: int.parse(Get.parameters['userId']!)));
      },
      transition: Transition.fadeIn,
    ),
    GetPage(
      name: orderSuccess,
      page: () {
        return OrderSuccessPage(
          orderId: Get.parameters['id']!,
          status: Get.parameters['status'].toString().contains("success")? 1: 0,
        );
      },
      transition: Transition.fadeIn,
    ),
  ];
}
