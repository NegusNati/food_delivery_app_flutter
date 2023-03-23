// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/popular_product_controller.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';

import '../../coltrollers/cart_controller.dart';
import '../../coltrollers/recomended_products_controller.dart';
import '../../routes/route_helper.dart';
import '../../utills/app_constants.dart';
import '../../widgets/app_icon.dart';

class RecomendedFoodDetail extends StatelessWidget {
  int pageId;
  RecomendedFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var recomendedProduct =
        Get.find<RecomendedProductController>().recomendedProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), recomendedProduct);
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(slivers: [
        SliverAppBar(
          automaticallyImplyLeading: false,
          toolbarHeight: 70,
          title:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getInital());
                },
                child: const AppIcon(icon: Icons.arrow_back_ios)),
            // the cart icon
            GetBuilder<PopularProductController>(builder: (product) {
              return GestureDetector(
                onTap: () {
                  Get.toNamed(RouteHelper.getCartPage());
                },
                child: Stack(
                  children: [
                    const AppIcon(
                      icon: Icons.shopping_cart_checkout_outlined,
                    ),
                    Get.find<PopularProductController>().totalItems >= 1
                        ? Positioned(
                            right: 0,
                            top: 0,
                            child: AppIcon(
                              icon: Icons.circle,
                              iconSize: 20,
                              iconColor: Colors.transparent,
                              backgroundColor: AppColors.mainColor,
                            ),
                          )
                        : Container(),
                    Positioned(
                        right: 5,
                        top: 2,
                        child: BigText(
                          text: Get.find<PopularProductController>()
                              .totalItems
                              .toString(),
                          color: Colors.white,
                          size: 14,
                        )),
                  ],
                ),
              );
            }),
          ]),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(30),
            child: Container(
              height: Dimensions.Height20 * 2,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radiusSize20),
                  topRight: Radius.circular(Dimensions.radiusSize20),
                ),
              ),
              padding: EdgeInsets.only(
                  bottom: Dimensions.Height5, top: Dimensions.Height5),
              width: double.maxFinite,
              child: Center(
                child: BigText(
                  text: recomendedProduct.name!,
                  size: Dimensions.fontSize26,
                ),
              ),
            ),
          ),
          pinned: true,
          backgroundColor: AppColors.yellowColor,
          expandedHeight: 350,
          flexibleSpace: FlexibleSpaceBar(
            background: Image.network(
                AppConstants.BASE_URL +
                    AppConstants.UPLOAD_URL +
                    recomendedProduct.img!,
                fit: BoxFit.cover,
                width: double.maxFinite),
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              Container(
                  margin: EdgeInsets.only(
                      left: Dimensions.Width20,
                      right: Dimensions.Width20,
                      bottom: Dimensions.Height20,
                      top: Dimensions.Height5),
                  child: ExpandableText(
                    text: recomendedProduct.description!,
                    size: Dimensions.fontSize16,
                  )),
            ],
          ),
        ),
      ]),
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (productController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              padding: EdgeInsets.only(
                left: Dimensions.Width20 * 3,
                right: Dimensions.Width20 * 3,
                bottom: Dimensions.Height20 / 2,
                top: Dimensions.Height20 / 2,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      productController.setQuantity(false);
                    },
                    child: AppIcon(
                      icon: Icons.remove,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      newSize: Dimensions.fontSize26,
                    ),
                  ),
                  BigText(
                    text: productController.inCartItems.toString(),
                    color: AppColors.mainBlackColor,
                    size: Dimensions.fontSize26,
                  ),
                  GestureDetector(
                    onTap: () {
                      productController.setQuantity(true);
                    },
                    child: AppIcon(
                      icon: Icons.add,
                      backgroundColor: AppColors.mainColor,
                      iconColor: Colors.white,
                      newSize: Dimensions.fontSize20,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              height: Dimensions.bottomHeightBarSize,
              padding: EdgeInsets.only(
                  top: Dimensions.Height30,
                  bottom: Dimensions.Height30,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radiusSize20 * 2),
                  topRight: Radius.circular(Dimensions.radiusSize20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  //the add and remove button
                  Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.Height20,
                          bottom: Dimensions.Height20,
                          left: Dimensions.Width20,
                          right: Dimensions.Width20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize20),
                      ),
                      child: Icon(
                        Icons.favorite_sharp,
                        color: AppColors.mainColor,
                      )),
                  //the add to cart Button(
                  GestureDetector(
                    onTap: () {
                      productController.addItem(recomendedProduct);
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.Height20,
                          bottom: Dimensions.Height20,
                          left: Dimensions.Width20,
                          right: Dimensions.Width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize20),
                      ),
                      child: BigText(
                        text: " \$ ${recomendedProduct.price!} | Add To Cart",
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
