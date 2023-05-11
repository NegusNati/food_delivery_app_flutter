import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/auth_controller.dart';
import 'package:food_delivery_app/coltrollers/cart_controller.dart';
import 'package:food_delivery_app/coltrollers/user_controller.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/custom_loader.dart';
import 'package:get/get.dart';

import '../../coltrollers/location_controller.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    Get.find<LocationController>().getAddressList();
    bool _userLoggedIn = Get.find<AuthController>().userHaveLoggedIn();
    if (_userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.mainColor,
        title: BigText(
            text: "Profile",
            size: Dimensions.Height20 + 4,
            color: Colors.white),
        elevation: 3,
        centerTitle: true,
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        return _userLoggedIn
            ? (userController.isLoading
                ? Container(
                    width: double.maxFinite,
                    margin: EdgeInsets.only(top: Dimensions.Height5),
                    child: Column(children: [
                      AppIcon(
                          icon: Icons.person,
                          backgroundColor: AppColors.mainColor,
                          iconColor: Colors.white,
                          iconSize: Dimensions.Height30 * 6,
                          newSize: Dimensions.Width30 * 5),
                      SizedBox(
                        height: Dimensions.Height15,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              AccountWidget(
                                  appIcon: AppIcon(
                                    icon: Icons.person,
                                    backgroundColor: AppColors.mainColor,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.name)),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                              AccountWidget(
                                  appIcon: const AppIcon(
                                    icon: Icons.phone,
                                    backgroundColor: Colors.greenAccent,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.phone)),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                              AccountWidget(
                                  appIcon: const AppIcon(
                                    icon: Icons.mail_rounded,
                                    backgroundColor: Colors.blue,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(
                                      text: userController.userModel.email)),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                              AccountWidget(
                                  appIcon: const AppIcon(
                                    icon: Icons.location_pin,
                                    backgroundColor: Colors.blueGrey,
                                    iconColor: Colors.white,
                                  ),
                                  bigText: BigText(text: "Wolkite,ETH")),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                              GetBuilder<LocationController>(
                                  builder: (locationcontroller) {
                                if (_userLoggedIn &&
                                    locationcontroller.addressList.isEmpty) {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(
                                          RouteHelper.getAddAddressPage());
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                        ),
                                        bigText: BigText(text: "Location ")),
                                  );
                                } else {
                                  return GestureDetector(
                                    onTap: () {
                                      Get.offNamed(
                                          RouteHelper.getAddAddressPage());
                                    },
                                    child: AccountWidget(
                                        appIcon: AppIcon(
                                          icon: Icons.message_outlined,
                                          backgroundColor: AppColors.mainColor,
                                          iconColor: Colors.white,
                                        ),
                                        bigText:
                                            BigText(text: "Your Address ")),
                                  );
                                }
                              }),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                              GestureDetector(
                                onTap: () {
                                  if (Get.find<AuthController>()
                                      .userHaveLoggedIn()) {
                                    Get.find<AuthController>().clearShareData();
                                    Get.find<CartController>().clear();
                                    Get.find<CartController>()
                                        .clearCartHistory();
                                    Get.find<LocationController>()
                                        .clearAddressList();
                                    Get.offNamed(RouteHelper.getSignIn());
                                  } else {
                                    print("You have logged out");
                                  }
                                },
                                child: AccountWidget(
                                    appIcon: AppIcon(
                                      icon: Icons.logout_rounded,
                                      backgroundColor: AppColors.mainColor,
                                      iconColor: Colors.white,
                                    ),
                                    bigText: BigText(text: "Log Out")),
                              ),
                              SizedBox(
                                height: Dimensions.Height15,
                              ),
                            ],
                          ),
                        ),
                      )
                    ]),
                  )
                : CustomLoader())
            : Container(
                child: Center(
                  child: Text("You must log in"),
                ),
              );
      }),
    );
  }
}
