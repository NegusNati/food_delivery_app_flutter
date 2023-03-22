import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/dimensions.dart';

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
            SizedBox(width: Dimensions.Width20 * 5,),
            AppIcon(
              icon: Icons.home_outlined,
              iconColor: Colors.white,
              backgroundColor: AppColors.mainColor,
              newSize: Dimensions.fontSize26,
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
      ]),
    );
  }
}
