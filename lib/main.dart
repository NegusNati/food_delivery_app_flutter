import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/popular_product_controller.dart';
import 'package:food_delivery_app/models/popular_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:get/get.dart';
import '/helper/dependencies.dart' as dependencies;
import 'coltrollers/beverage_controller.dart';
import 'coltrollers/cart_controller.dart';
import 'coltrollers/recomended_products_controller.dart';
import 'package:flutter_config/flutter_config.dart';

// Future<dynamic> myBackgroundMessageHandler(RemoteMessage message) async{
//   print("onBackground: ${message.notification?.title}/${message.notification?.body}/""${message.notification?.titleLocKey}");
// }
// final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {
  // to ensure the dependencies are first initalized
  WidgetsFlutterBinding.ensureInitialized();
  // initalize the dependencies
  await dependencies.init();
  await FlutterConfig.loadEnvVariables();

  //  try{
  //   if(GetPlatform.isMobile){
  //     final RemoteMessage? remoteMessage = await FirebaseMessaging.instance.getInitialMessage();
  //     await NotificationHelper.initalize(flutterLocalNotificationsPlugin);
  //     FirebaseMessaging.onBackgroundMessage(myBackgroundMessageHandler);
  //   }

  //  }catch(e)          {
  //   print(e.toString());
  //  }

  //run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ProductModal product = ProductModal();
      Get.find<BeverageController>()
        .initProduct(Get.find<CartController>(), product);
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
        

    Get.find<CartController>().getCartData();
    // Get.find<PopularProductController>()
    //     .initProduct(Get.find<CartController>(), );
    return GetBuilder<BeverageController>(
      builder: (_) {
        return GetBuilder<RecomendedProductController>(builder: (_) {
          return GetBuilder<PopularProductController>(builder: (_) {
            return GetMaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: ThemeData(
                primaryColor: AppColors.mainColor,
                primarySwatch: Colors.blue,
              ),
              // home:const SignInPage(),
              initialRoute: RouteHelper.getSplashPage(),
              getPages: RouteHelper.routes,
            );
          });
        });
      },
    );
  }
}
