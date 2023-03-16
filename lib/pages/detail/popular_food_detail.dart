import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/info_column.dart';

class PopularFoodDetail extends StatelessWidget {
  const PopularFoodDetail({super.key});

  @override
  Widget build(BuildContext context) {
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
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage("assets/image/food0.png"),
                ),
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
                children: const [
                  AppIcon(icon: Icons.arrow_back_ios),
                  AppIcon(
                    icon: Icons.shopping_cart_checkout_outlined,
                    backgroundColor: Colors.transparent,
                  ),
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
                  color: Colors.black26,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InfoColumn(
                        text: "Yes this is", size: Dimensions.fontSize26),
                    SizedBox(
                      height: Dimensions.Height20,
                    ),
                    BigText(text: "Details"),
                  ],
                )),
          ),
        
        ],
      ),

      //our cart button and add item
      bottomNavigationBar: Container(
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
                  Icon(
                    Icons.remove,
                    color: AppColors.signColor,
                  ),
                  SizedBox(
                    width: Dimensions.Width10,
                  ),
                  BigText(text: "0"),
                  SizedBox(
                    width: Dimensions.Width10,
                  ),
                  Icon(
                    Icons.add,
                    color: AppColors.signColor,
                  ),
                ],
              ),
            ),
            //the add to cart Button(
            Container(
             padding: EdgeInsets.only(
                  top: Dimensions.Height20,
                  bottom: Dimensions.Height20,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                color: AppColors.mainColor,
                borderRadius: BorderRadius.circular(Dimensions.radiusSize20),
              ),
              child: BigText(text: " \$10 | Add To Cart", color: Colors.white,),
            ),
          ],
        ),
      ),
    );
  }
}
