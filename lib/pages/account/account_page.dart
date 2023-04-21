import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/account_widget.dart';
import 'package:food_delivery_app/widgets/app_icon.dart';
import 'package:food_delivery_app/widgets/big_text.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
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
      body: Container(
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
                      bigText: BigText(text: "Negus Nati")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.phone,
                        backgroundColor: Colors.greenAccent,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "0911465116")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                  AccountWidget(
                      appIcon: const AppIcon(
                        icon: Icons.mail_rounded,
                        backgroundColor: Colors.blue,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "negus@nati.com")),
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
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "Negus Nati")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "Negus Nati")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "Negus Nati")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                  AccountWidget(
                      appIcon: AppIcon(
                        icon: Icons.person,
                        backgroundColor: AppColors.mainColor,
                        iconColor: Colors.white,
                      ),
                      bigText: BigText(text: "Negus Nati")),
                  SizedBox(
                    height: Dimensions.Height15,
                  ),
                ],
              ),
            ),
          )
        ]),
      ),
    );
  }
}
