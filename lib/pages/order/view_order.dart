// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/utills/styles.dart';
import 'package:get/get.dart';

import '../../coltrollers/order_controller.dart';
import '../../models/order_model.dart';
import '../../widgets/custom_loader.dart';

class ViewOrder extends StatelessWidget {
  final bool isCurrent;
  const ViewOrder({
    Key? key,
    required this.isCurrent,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GetBuilder<OrderController>(builder: (orderController) {
      late List<OrderModel> orderList;

      if (orderController.isLoading == false) {
        if (orderController.currentOrderList.isNotEmpty) {
          orderList = isCurrent
              ? orderController.currentOrderList.reversed.toList()
              : orderController.historyOrderList.reversed.toList();
        }
        return Container(
          margin: EdgeInsets.only(top: Dimensions.Height5),
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: ListView.builder(
                itemCount: orderList.length,
                itemBuilder: ((context, index) {
                  return InkWell(
                    onTap: () {},
                    child: Column(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                right: Dimensions.Width5,
                                left: Dimensions.Width5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Text(
                                      "Order ID:",
                                      style: robotoRegular.copyWith(
                                        fontSize: Dimensions.fontSize16,
                                      ),
                                    ),
                                    SizedBox(
                                      width: Dimensions.Width5,
                                    ),
                                    Text("#${orderList[index].id.toString()}")
                                  ],
                                ),
                                Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Container(
                                        decoration: BoxDecoration(
                                          color: AppColors.mainColor,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSize5),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.Height5),
                                            child: Text(
                                              '${orderList[index].orderStatus}',
                                              style: robotoMedium.copyWith(
                                                fontSize: Dimensions.fontSize16,
                                                color:
                                                    Theme.of(context).cardColor,
                                              ),
                                            ))),
                                    SizedBox(
                                      height: Dimensions.Height5,
                                    ),
                                    InkWell(
                                      onTap: () => null,
                                      child: Container(
                                        // padding: EdgeInsets.symmetric(
                                        //     horizontal: Dimensions.Width10,
                                        //     vertical: Dimensions.Height5),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(
                                              Dimensions.radiusSize5),
                                          border: Border.all(
                                              width: 1,
                                              color: Theme.of(context)
                                                  .primaryColor),
                                        ),
                                        child: Container(
                                            margin: EdgeInsets.all(
                                                Dimensions.Height5),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.folder_open_outlined,
                                                  color: Theme.of(context)
                                                      .primaryColor,
                                                  size: Dimensions.Width20,
                                                ),
                                                SizedBox(
                                                  width: Dimensions.Width5 / 2,
                                                ),
                                                Text(
                                                  "Track Order",
                                                  style: robotoMedium.copyWith(
                                                    color: Theme.of(context)
                                                        .primaryColor,
                                                    fontSize:
                                                        Dimensions.fontSize16,
                                                  ),
                                                ),
                                              ],
                                            )),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            )),
                        SizedBox(
                          height: Dimensions.Height5 * 2,
                        ),
                      ],
                    ),
                  );
                })),
          ),
        );
      } else {
        return const CustomLoader();
      }
    }));
  }
}
