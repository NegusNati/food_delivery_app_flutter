// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:food_delivery_app/pages/cart/cart_page.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';

import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';
import 'package:food_delivery_app/widgets/info_column.dart';

import '../../coltrollers/cart_controller.dart';
import '../../coltrollers/popular_product_controller.dart';
import '../../data/api/repository/cart_repo.dart';
import '../../routes/route_helper.dart';
import '../../utills/app_constants.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({
    Key? key,
    required this.pageId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //to find the controller that get us the data
    // Get.lazyPut(
    //   fenix: true,
    //   () => CartController(cartRepo: CartRepo()));
    // Get.put(CartController(cartRepo: CartRepo(sharedPreferences: null)), permanent: true);

    var product =
        Get.find<PopularProductController>().popularProductList[pageId];
    Get.find<PopularProductController>()
        .initProduct(Get.find<CartController>(), product);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          //the background image
          Positioned(
            left: 0,
            right: 0,
            child: Container(
              width: double.maxFinite,
              height: Dimensions.popularPageImageSize,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(AppConstants.BASE_URL +
                        AppConstants.UPLOAD_URL +
                        product.img!)),
              ),
            ),
          ),
          // the buttons (transparent ) at the top
          Positioned(
            top: Dimensions.Height30,
            left: Dimensions.Width20,
            right: Dimensions.Width20,
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
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
                              right: 3,
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
          ),
          //reusable info coulumn & details
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            top: Dimensions.popularPageImageSize - 30,
            child: Container(
                padding: EdgeInsets.only(
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    top: Dimensions.Height20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(
                      (Dimensions.radiusSize20),
                    ),
                    topRight: Radius.circular(Dimensions.radiusSize20),
                  ),
                  color: Colors.white,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoColumn(
                        text: product.name!, size: Dimensions.fontSize26),
                    SizedBox(
                      height: Dimensions.Height20,
                    ),
                    BigText(
                      text: "Details",
                      size: Dimensions.fontSize26,
                    ),
                    SizedBox(
                      height: Dimensions.Height15,
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        child: ExpandableText(
                          text: product.description!,
                          size: Dimensions.fontSize16,
                        ),
                      ),
                    ),
                  ],
                )),
          ),
        ],
      ),

      //our cart button and add item
      bottomNavigationBar:
          GetBuilder<PopularProductController>(builder: (popularProduct) {
        return Container(
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
                  borderRadius: BorderRadius.circular(Dimensions.radiusSize20),
                ),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(false);
                      },
                      child: Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.Width10,
                    ),
                    BigText(text: popularProduct.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.Width10,
                    ),
                    GestureDetector(
                      onTap: () {
                        popularProduct.setQuantity(true);
                      },
                      child: Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    ),
                  ],
                ),
              ),
              //the add to cart Button(
              GestureDetector(
                onTap: () {
                  popularProduct.addItem(product);
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
                    text: " \$ ${product.price!} | Add To Cart",
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}
