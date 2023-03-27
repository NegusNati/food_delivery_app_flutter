import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../utills/app_constants.dart';
import '../../widgets/small_text.dart';

class CartHistory extends StatelessWidget {
  const CartHistory({super.key});

  @override
  Widget build(BuildContext context) {
    var getCartHistoryList = Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) {
        return e.value;
      }).toList();
    }

    List<int> itemsPerOrder = cartOrderTimeToList();

    var listCounter = 0;

    return Scaffold(
      body: Column(
        children: [
          Container(
            color: AppColors.mainColor,
            width: double.maxFinite,
            height: Dimensions.Height20 * 5,
            padding: EdgeInsets.only(top: Dimensions.Height20*2, right: Dimensions.Width5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                BigText(text: "Cart History", color: Colors.white),
                AppIcon(
                    icon: Icons.shopping_cart_checkout_sharp,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    newSize : Dimensions.fontSize26,
                     ),
              ],
            ),
          ),
          Expanded(
            child: Container(
              margin: EdgeInsets.only(
                  top: Dimensions.Height20,
                  right: Dimensions.Width15,
                  left: Dimensions.Width15),
              child: MediaQuery.removePadding(
                // to remove ListView's padding property
                removeTop: true,
                context: context,
                child: ListView(
                  children: [
                    for (int i = 0; i < itemsPerOrder.length; i++)
                      Container(
                        height: Dimensions.Height30 * 4,
                        margin: EdgeInsets.only(bottom: Dimensions.Height20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            //imidiatly invoked functions
                            (() {
                              DateTime parseDate =
                                  DateFormat("yyyy-mm-dd HH:mm:ss").parse(
                                      getCartHistoryList[listCounter].time!);
                              var inputDate =
                                  DateTime.parse(parseDate.toString());
                              var outputFormat =
                                  DateFormat("MM/dd/yyyy hh:mm a");
                              var outputDate = outputFormat.format(inputDate);
                              return BigText(text: outputDate);
                            }()),
                            SizedBox(
                              height: Dimensions.Height5,
                            ),
                            Row(
                                //Wrap lets you draw something again and again.
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Wrap(
                                    spacing: 5,
                                    direction: Axis.horizontal,
                                    children: List.generate(itemsPerOrder[i],
                                        (index) {
                                      if (listCounter <
                                          getCartHistoryList.length) {
                                        listCounter++;
                                      }
                                      return index <= 2
                                          ? Container(
                                              height: Dimensions.Height20*4,
                                              width:  Dimensions.Width20*4,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(
                                                        Dimensions
                                                                .radiusSize20 /
                                                            2),
                                                image: DecorationImage(
                                                  fit: BoxFit.cover,
                                                  image: NetworkImage(
                                                      AppConstants.BASE_URL +
                                                          AppConstants
                                                              .UPLOAD_URL +
                                                          getCartHistoryList[
                                                                  listCounter -
                                                                      1]
                                                              .img!),
                                                ),
                                              ),
                                            )
                                          : Container();
                                    }),
                                  ),
                                  SizedBox(
                                    height:  Dimensions.Height20*4,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SmallText(
                                              text: "Total",
                                              color: AppColors.titleColor),
                                          BigText(
                                              text: "${itemsPerOrder[i]} Items",
                                              color: AppColors.titleColor),
                                          Container(
                                            padding: EdgeInsets.all(
                                                Dimensions.Width5),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      Dimensions.radiusSize5),
                                              border: Border.all(
                                                  width: 1,
                                                  color: AppColors.mainColor),
                                            ),
                                            child: SmallText(
                                                text: "One More",
                                                color: AppColors.mainColor),
                                          ),
                                        ]),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
