import "package:flutter/material.dart";
import 'package:food_delivery_app/pages/home/food_slider.dart';
import 'package:get/get.dart';
import '../../coltrollers/popular_product_controller.dart';
import '../../coltrollers/recomended_products_controller.dart';
import '../../utills/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  Future<void> _loadResource() async {
    await Get.find<PopularProductController>().getPopularProductList();
    await Get.find<RecomendedProductController>().getRecomendedrProductList();
  }

  @override
  Widget build(BuildContext context) {
    print("current height is ${MediaQuery.of(context).size.height}");
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
                        text: "Negus",
                        color: AppColors.mainColor,
                        size: 25,
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SmallText(text: "Nati", color: Colors.black54),
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
                      child: Container(
                        width: 45,
                        height: 50,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(14),
                          color: AppColors.mainColor,
                        ),
                        child: const Icon(
                          Icons.search,
                          color: Colors.white,
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
  }
}
