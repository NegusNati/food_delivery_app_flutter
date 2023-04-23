import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/auth_controller.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:get/get.dart';

class CustomLoader extends StatelessWidget {
  const CustomLoader({super.key});

  @override
  Widget build(BuildContext context) {
    // print("in Loading Progress bar: ${Get.find<AuthController>().isLoading}");
    return Center(
      child: Container(
        height: Dimensions.Height30 * 4,
        width: Dimensions.Width30 * 4,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.Height30 * 4 / 2),
          color: AppColors.mainColor,
        ),
        alignment: Alignment.center,
        child: const CircularProgressIndicator(color: Colors.white),
      ),
    );
  }
}
