// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/expandable_text.dart';

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
            const AppIcon(
              icon: Icons.shopping_cart_checkout_outlined,
            ),
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
                    text:
                    recomendedProduct.description!
                       ,
                    size: Dimensions.fontSize16,
                  )),
            ],
          ),
        ),
      ]),
      bottomNavigationBar: Column(
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
                AppIcon(
                  icon: Icons.remove,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  newSize: Dimensions.fontSize26,
                ),
                BigText(
                  text: " \$10 | Add To Cart",
                  color: AppColors.mainBlackColor,
                  size: Dimensions.fontSize26,
                ),
                AppIcon(
                  icon: Icons.add,
                  backgroundColor: AppColors.mainColor,
                  iconColor: Colors.white,
                  newSize: Dimensions.fontSize20,
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
                Container(
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
              ],
            ),
          ),
        ],
      ),
    );
  }
}
