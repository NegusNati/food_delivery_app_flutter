// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:food_delivery_app/pages/cart/no_cart.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

import '../../utills/app_constants.dart';
import '../../widgets/custom_button.dart';
import '../../widgets/small_text.dart';

class OrderSuccessPage extends StatelessWidget {
  final String orderId;
  final int status;
  const OrderSuccessPage({
    Key? key,
    required this.orderId,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (status == 0) {
      Future.delayed(Duration(seconds: 1), () {
        // Get.dialog(Payment)
      });
    }
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: Dimensions.screenWidth,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                  status == 1
                      ? "assets/image/checked.png"
                      : "assets/image/warning.png",
                  width: 1000,
                  height: 100),
              SizedBox(height: Dimensions.Height30),
              Text(
                status == 1
                    ? "You placed the order successfully"
                    : "your order failed",
                style: TextStyle(fontSize: Dimensions.fontSize26),
              ),
              SizedBox(height: Dimensions.Height30),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.Height20,
                    vertical: Dimensions.Height20),
                child: Text(
                  status == 1 ? "Successful Order" : "Failed Order",
                  style: TextStyle(
                      fontSize: Dimensions.fontSize26,
                      color: Theme.of(context).disabledColor),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: Dimensions.Height30),
              Padding(
                padding: EdgeInsets.all(
                  Dimensions.Height20,
                ),
                child: CustomButton(
                  buttonText: "Back to Home",
                  onPressed: () => Get.offAllNamed(RouteHelper.getInital()),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
