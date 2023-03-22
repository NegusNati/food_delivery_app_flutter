import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/pages/home/main_page.dart';
import 'package:food_delivery_app/utills/app_constants.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

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
                Navigator.pop(context);
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
                Get.to(() => const MainPage());
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
                return ListView.builder(
                    itemCount: cartController.getItems.length,
                    itemBuilder: (context, index) {
                      // ignore: sized_box_for_whitespace
                      return Container(
                        height: Dimensions.Height20 * 5,
                        width: double.maxFinite,
                        child: Row(
                          children: [
                            Container(
                              width: Dimensions.Height20 * 5,
                              height: Dimensions.Height20 * 5,
                              margin:
                                  EdgeInsets.only(bottom: Dimensions.Width10),
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(AppConstants.BASE_URL +
                                      AppConstants.UPLOAD_URL +
                                      cartController.getItems[index].img!),
                                ),
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSize20),
                                color: Colors.white,
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
                                                bottom: Dimensions.Height5 * 2,
                                                left: Dimensions.Width15,
                                                right: Dimensions.Width15),
                                            decoration: BoxDecoration(
                                              color: Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radiusSize20),
                                            ),
                                            child: Row(
                                              children: [
                                                GestureDetector(
                                                  onTap: () {
                                                    // popularProduct.setQuantity(false);
                                                  },
                                                  child: Icon(
                                                    Icons.remove,
                                                    color: AppColors.signColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                  width: Dimensions.Width10,
                                                ),
                                                BigText(text: "0"),
                                                SizedBox(
                                                  width: Dimensions.Width10,
                                                ),
                                                GestureDetector(
                                                  onTap: () {
                                                    // popularProduct.setQuantity(true);
                                                  },
                                                  child: Icon(
                                                    Icons.add,
                                                    color: AppColors.signColor,
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
              }),
            ),
          ),
        ),
      ]),
    );
  }
}
