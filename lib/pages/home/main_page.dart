import "package:flutter/material.dart";
import 'package:food_delivery_app/coltrollers/beverage_controller.dart';
import 'package:food_delivery_app/pages/home/food_slider.dart';
import 'package:get/get.dart';
import '../../coltrollers/auth_controller.dart';
import '../../coltrollers/popular_product_controller.dart';
import '../../coltrollers/recomended_products_controller.dart';
import '../../coltrollers/user_controller.dart';
import '../../utills/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';
import '../../routes/route_helper.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<BeverageController>().getPopularProductList();
    await Get.find<RecomendedProductController>().getRecomendedrProductList();
  }

  @override
  Widget build(BuildContext context) {
    bool _userLoggedIn = Get.find<AuthController>().userHaveLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return GetBuilder<UserController>(builder: (userController) {
      return RefreshIndicator(
          onRefresh: _loadResource,
          child: Column(
            children: [
              Container(
                child: Container(
                  margin: const EdgeInsets.only(top: 40, bottom: 10),
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(children: [
                        BigText(
                          text: "Hello!",
                          color: AppColors.mainColor,
                          size: 25,
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SmallText(text: "There", color: Colors.black54),
                              Icon(
                                Icons.arrow_drop_down_rounded,
                                color: AppColors.titleColor,
                                size: 24.0,
                                semanticLabel:
                                    'Text to announce in accessibility modes',
                              ),
                            ]),
                      ]),
                      Center(
                        child: GestureDetector(
                          onTap: () {
                            Get.toNamed(RouteHelper.getCartPage());
                          },
                          child: Container(
                            width: 45,
                            height: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              color: AppColors.mainColor,
                            ),
                            child: const Icon(
                              Icons.shopping_cart_checkout_outlined,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: FoodSlider(),
                ),
              ),
            ],
          ));
    });
  }
}
