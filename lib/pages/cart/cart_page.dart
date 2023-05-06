import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/auth_controller.dart';
import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/coltrollers/recomended_products_controller.dart';
import 'package:food_delivery_app/pages/cart/no_cart.dart';
import 'package:food_delivery_app/utills/app_constants.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../coltrollers/location_controller.dart';
import '../../coltrollers/popular_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utills/colors.dart';
import '../../widgets/app_icon.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Positioned(
          top: Dimensions.Height20 * 3,
          left: Dimensions.Width20,
          right: Dimensions.Width20,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInital());
              },
              child: AppIcon(
                icon: Icons.arrow_back_ios,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                newSize: Dimensions.fontSize26,
              ),
            ),
            SizedBox(
              width: Dimensions.Width20 * 5,
            ),
            GestureDetector(
              onTap: () {
                Get.toNamed(RouteHelper.getInital());
              },
              child: AppIcon(
                icon: Icons.home_outlined,
                iconColor: Colors.white,
                backgroundColor: AppColors.mainColor,
                newSize: Dimensions.fontSize26,
              ),
            ),
            AppIcon(
              icon: Icons.shopping_cart_checkout_outlined,
              iconColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              newSize: Dimensions.fontSize26,
            ),

            // the cart icon
            // GetBuilder<PopularProductController>(builder: (product) {
            //   return Stack(
            //     children: [
            //       const AppIcon(
            //         icon: Icons.shopping_cart_checkout_outlined,
            //       ),
            //       Get.find<PopularProductController>().totalItems >= 1
            //           ? Positioned(
            //               right: 0,
            //               top: 0,
            //               child: AppIcon(
            //                 icon: Icons.circle,
            //                 iconSize: 20,
            //                 iconColor: Colors.transparent,
            //                 backgroundColor: AppColors.mainColor,
            //               ),
            //             )
            //           : Container(),
            //            Positioned(
            //               right:3,
            //               top: 2,
            //               child: BigText(text:  Get.find<PopularProductController>().totalItems.toString() , color: Colors.white, size: 14,)
            //             ),

            //     ],
            //   );
            // }),
          ]),
        ),
        Positioned(
          top: Dimensions.Height20 * 5,
          left: Dimensions.Width15,
          right: Dimensions.Width15,
          bottom: 0,
          child: Container(
            // color: Colors.amber,
            margin: EdgeInsets.only(top: Dimensions.Height5),
            padding: EdgeInsets.only(top: Dimensions.Height5),
            child: MediaQuery.removePadding(
              context: context,
              removeTop: true,
              child: GetBuilder<CartController>(builder: (cartController) {
                if (cartController.getItems.isEmpty) {
                  return SizedBox(
                    // margin: EdgeInsets.only(top: Dimensions.Height15),
                    height: Dimensions.Height30 * 5,
                    width: double.maxFinite,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const NoCartPage(
                            text: "Sorry, You have no Item in your Cart"),
                        SmallText(text: "Please Add your favorite items "),
                        // Container(
                        //   height: 80,
                        //   decoration: BoxDecoration(
                        //     image: DecorationImage(
                        //       image: AssetImage("assets/image/empty_cart_animation.gif")),
                        //   ),
                        // ),
                      ],
                    ),
                  );
                } else {
                  var cartList = cartController.getItems;
                  return ListView.builder(
                      itemCount: cartList.length,
                      itemBuilder: (context, index) {
                        // ignore: sized_box_for_whitespace
                        return Container(
                          height: Dimensions.Height20 * 5,
                          width: double.maxFinite,
                          child: Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  var indexFromPopularList =
                                      Get.find<PopularProductController>()
                                          .popularProductList
                                          .indexOf(cartList[index].product!);
                                  if (indexFromPopularList >= 0) {
                                    Get.toNamed(RouteHelper.getPopularFood(
                                        indexFromPopularList));
                                  } else {
                                    var indexFromRecommendedList =
                                        Get.find<RecomendedProductController>()
                                            .recomendedProductList
                                            .indexOf(cartList[index].product!);
                                    if (indexFromRecommendedList < 0) {
                                      Get.snackbar(
                                        "Sorry",
                                        "Can't review items from History",
                                        backgroundColor: Colors.red[500],
                                        colorText: Colors.white,
                                        overlayBlur: 1,
                                      );
                                    } else {
                                      Get.toNamed(RouteHelper.getRecomendedFood(
                                          indexFromRecommendedList));
                                    }
                                  }
                                },
                                child: Container(
                                  width: Dimensions.Height20 * 5,
                                  height: Dimensions.Height20 * 5,
                                  margin: EdgeInsets.only(
                                      bottom: Dimensions.Width10),
                                  decoration: BoxDecoration(
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(AppConstants
                                              .BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          cartController.getItems[index].img!),
                                    ),
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusSize20),
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              SizedBox(
                                width: Dimensions.Width10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.Height20 * 5,
                                  child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        BigText(
                                          text: cartController
                                              .getItems[index].name!,
                                          color: Colors.black54,
                                        ),
                                        SmallText(text: "Catagory"),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            BigText(
                                                text: cartController
                                                    .getItems[index].price
                                                    .toString(),
                                                color: Colors.redAccent),
                                            Container(
                                              padding: EdgeInsets.only(
                                                  top: Dimensions.Height5 * 2,
                                                  bottom:
                                                      Dimensions.Height5 * 2,
                                                  left: Dimensions.Width15,
                                                  right: Dimensions.Width15),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                            .radiusSize20),
                                              ),
                                              child: Row(
                                                children: [
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          cartList[index]
                                                              .product!,
                                                          -1);
                                                    },
                                                    child: Icon(
                                                      Icons.remove,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: Dimensions.Width10,
                                                  ),
                                                  BigText(
                                                      text: cartList[index]
                                                          .quantity
                                                          .toString()),
                                                  SizedBox(
                                                    width: Dimensions.Width10,
                                                  ),
                                                  GestureDetector(
                                                    onTap: () {
                                                      cartController.addItem(
                                                          cartList[index]
                                                              .product!,
                                                          1);
                                                    },
                                                    child: Icon(
                                                      Icons.add,
                                                      color:
                                                          AppColors.signColor,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ]),
                                ),
                              ),
                            ],
                          ),
                        );
                      });
                }
              }),
            ),
          ),
        ),
      ]),
      bottomNavigationBar:
          GetBuilder<CartController>(builder: (cartController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
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
              child: cartController.getItems.isNotEmpty
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: Dimensions.Width5 / 2,
                        ),
                        BigText(
                            text: "${cartController.totalAmount} Birr Only"),
                        SizedBox(
                          width: Dimensions.Width5 / 2,
                        ),
                        //the add to cart Button(
                        GestureDetector(
                          onTap: () {
                            // productController.addItem(recomendedProduct);
                            if (Get.find<AuthController>().userHaveLoggedIn()) {
                              // print("got token in cart button");
                              // cartController.addToHistory();
                              Future<void> requestPermission() async {
                                await Permission.location.request();
                              }

                              if (Get.find<LocationController>()
                                  .addressList
                                  .isEmpty) {
                                Get.toNamed(RouteHelper.getAddAddressPage());
                              }
                            } else {
                              Get.toNamed(RouteHelper.getSignIn());
                            }
                          },
                          child: Container(
                            padding: EdgeInsets.only(
                                top: Dimensions.Height20,
                                bottom: Dimensions.Height20,
                                left: Dimensions.Width20,
                                right: Dimensions.Width20),
                            decoration: BoxDecoration(
                              color: AppColors.mainColor,
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSize20),
                            ),
                            child: BigText(
                              text: " Check Out!",
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(),
            ),
          ],
        );
      }),
    );
  }
}
