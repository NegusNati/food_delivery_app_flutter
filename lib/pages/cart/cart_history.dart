import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/pages/cart/no_cart.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/utills/styles.dart';
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
    var getCartHistoryList =
        Get.find<CartController>().getCartHistoryList().reversed.toList();

    Map<String, int> cartItemsPerOrder = {};

    for (int i = 0; i < getCartHistoryList.length; i++) {
      if (cartItemsPerOrder.containsKey(getCartHistoryList[i].time)) {
        cartItemsPerOrder.update(
            getCartHistoryList[i].time!, (value) => ++value);
      } else {
        cartItemsPerOrder.putIfAbsent(getCartHistoryList[i].time!, () => 1);
      }
    }

    List<int> cartItemsPerOrderToList() {
      return cartItemsPerOrder.entries.map((e) {
        return e.value;
      }).toList();
    }

    List<int> itemsPerOrder = cartItemsPerOrderToList();

//to get the time to compare for one more button
    List<String> cartOrderTimeToList() {
      return cartItemsPerOrder.entries.map((e) {
        return e.key;
      }).toList();
    }

    var listCounter = 0;
    Widget timeWidget(int index) {
      var outputDate = DateTime.now().toString();
      if (index < getCartHistoryList.length) {
        DateTime parseDate = DateFormat("yyyy-mm-dd HH:mm:ss")
            .parse(getCartHistoryList[listCounter].time!);
        var inputDate = DateTime.parse(parseDate.toString());
        var outputFormat = DateFormat("MM/dd/yyyy hh:mm a");
        outputDate = outputFormat.format(inputDate);
      }
      return BigText(text: outputDate);
    }



    //  Container(
    //         color: AppColors.mainColor,
    //         width: double.maxFinite,
    //         height: Dimensions.Height20 * 4.3,
    //         padding: EdgeInsets.only(
    //             top: Dimensions.Height20, right: Dimensions.Width5),
    //         child: Row(
    //           mainAxisAlignment: MainAxisAlignment.spaceAround,
    //           children: [
    //             Text("Cart History", style:robotoMedium.copyWith(fontSize: Dimensions.fontSize20 + 2, color: Colors.white)),
    //             AppIcon(
    //               icon: Icons.shopping_cart_checkout_sharp,
    //               iconColor: Colors.white,
    //               backgroundColor: AppColors.mainColor,
    //               newSize: Dimensions.fontSize26,
    //             ),
    //           ],
    //         ),
    //       )

    return Scaffold(
        appBar: AppBar(
          leading:  Icon(Icons.shopping_cart_checkout_sharp),
        centerTitle: true,
        title: const Text("Cart History"),
        backgroundColor: AppColors.mainColor,
      ),

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
         
          GetBuilder<CartController>(builder: (cartController) {
            return cartController.getCartHistoryList().isNotEmpty
                ? Expanded(
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
                                margin: EdgeInsets.only(
                                    bottom: Dimensions.Height20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    //imidiatly invoked functions
                                   timeWidget(listCounter),
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
                                            children: List.generate(
                                                itemsPerOrder[i], (index) {
                                              if (listCounter <
                                                  getCartHistoryList.length) {
                                                listCounter++;
                                              }
                                              return index <= 2
                                                  ? Container(
                                                      height:
                                                          Dimensions.Height20 *
                                                              4,
                                                      width:
                                                          Dimensions.Width20 *
                                                              4,
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                    .radiusSize20 /
                                                                2),
                                                        image: DecorationImage(
                                                          fit: BoxFit.cover,
                                                          image: NetworkImage(AppConstants
                                                                  .BASE_URL +
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
                                            height: Dimensions.Height20 * 4,
                                            child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  SmallText(
                                                      text: "Total",
                                                      color:
                                                          AppColors.titleColor),
                                                  BigText(
                                                      text:
                                                          "${itemsPerOrder[i]} Items",
                                                      color:
                                                          AppColors.titleColor),
                                                  GestureDetector(
                                                    onTap: () {
                                                      var orderTime =
                                                          cartOrderTimeToList();
                                                      Map<int, CartModel>
                                                          moreOrder = {};
                                                      for (int j = 0;
                                                          j <
                                                              getCartHistoryList
                                                                  .length;
                                                          j++) {
                                                        if (getCartHistoryList[
                                                                    j]
                                                                .time ==
                                                            orderTime[i]) {
                                                          moreOrder.putIfAbsent(
                                                            getCartHistoryList[
                                                                    j]
                                                                .id!,
                                                            () => CartModel.fromJson(
                                                                jsonDecode(jsonEncode(
                                                                    getCartHistoryList[
                                                                        j]))),
                                                          );
                                                        }
                                                      }
                                                      //to set the items to _items
                                                      Get.find<CartController>()
                                                          .setItems = moreOrder;
                                                      Get.find<CartController>()
                                                          .addToCartList();
                                                      Get.toNamed(RouteHelper
                                                          .getCartPage());
                                                    },
                                                    child: Container(
                                                      padding: EdgeInsets.all(
                                                          Dimensions.Width5),
                                                      decoration: BoxDecoration(
                                                        borderRadius: BorderRadius
                                                            .circular(Dimensions
                                                                .radiusSize5),
                                                        border: Border.all(
                                                            width: 1,
                                                            color: AppColors
                                                                .mainColor),
                                                      ),
                                                      child: SmallText(
                                                          text: "One More",
                                                          color: AppColors
                                                              .mainColor),
                                                    ),
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
                  )
                : Center(
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const NoCartPage(
                          text: "You have no History in your Cart",
                          imgPath: "assets/image/empty_box.png",
                        ),
                        SmallText(text: "Purchase some items to see your History "),
                      ],
                    ),
                );
          }),
        ],
      ),
    );
  }
}
