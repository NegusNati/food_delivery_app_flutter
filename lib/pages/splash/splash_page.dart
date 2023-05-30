import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:get/get.dart';

import '../../coltrollers/beverage_controller.dart';
import '../../coltrollers/cart_controller.dart';
import '../../coltrollers/popular_product_controller.dart';
import '../../coltrollers/recomended_products_controller.dart';
import '../../models/popular_model.dart';
import '../../routes/route_helper.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;

  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<BeverageController>().getPopularProductList();
    await Get.find<RecomendedProductController>().getRecomendedrProductList();
  }

  @override
  void initState() {
    super.initState();
    _loadResource();

    controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 3))
          ..forward();
    // controller = controller.forward();
    animation = CurvedAnimation(parent: controller, curve: Curves.bounceOut);

    Timer(const Duration(seconds: 4),
        () => Get.offNamed(RouteHelper.getInital()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
              scale: animation,
              child: Center(
                  child: Image.asset(
                "assets/image/logo part 1.png",
                width: Dimensions.splashImg,
              ))),
          Center(
              child: Image.asset(
            "assets/image/logo part 2.png",
            width: Dimensions.splashImg,
          )),
        ],
      ),
    );
  }
}
