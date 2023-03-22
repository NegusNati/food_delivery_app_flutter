import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/popular_product_controller.dart';
import 'package:food_delivery_app/models/popular_model.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:get/get.dart';
import '/helper/dependencies.dart' as dependencies;
import 'coltrollers/cart_controller.dart';
import 'coltrollers/recomended_products_controller.dart';
import 'pages/home/main_page.dart';

Future<void> main() async {
  // to ensure the dependencies are first initalized
  WidgetsFlutterBinding.ensureInitialized();
  // initalize the dependencies
  await dependencies.init();
  //run the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    Get.find<PopularProductController>().getPopularProductList();
    Get.find<RecomendedProductController>().getRecomendedrProductList();

    ProductModal product = ProductModal();
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);
    // Get.find<PopularProductController>()
    //     .initProduct(Get.find<CartController>(), );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
      initialRoute: RouteHelper.inital,
      getPages: RouteHelper.routes,
    );
  }
}
