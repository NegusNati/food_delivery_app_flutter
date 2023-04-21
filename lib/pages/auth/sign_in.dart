import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/auth/sign_up_page.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/small_text.dart';
import 'package:get/get.dart';

import '../../utills/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/text_field.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: Dimensions.Height30),
              // width: double.maxFinite,
              // height: Dimensions.Height30 * 3,
              child: CircleAvatar(
                backgroundColor: Colors.white,
                radius: Dimensions.Height30 * 3,
                backgroundImage: const AssetImage(
                  "assets/image/logo part 1.png",
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: Dimensions.Width10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Hello",
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: Dimensions.fontSize20 * 2.3,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                  SmallText(
                    text: "Sign into your account",
                    color: Colors.grey[500],
                    size: Dimensions.fontSize20,
                  ),
                ],
              ),
            ),
            TextFieldWidget(
              textController: phoneController,
              hintText: " Phone",
              icon: Icons.phone,
              color: Colors.yellow[300],
            ),
            TextFieldWidget(
              textController: passwordController,
              hintText: " Password",
              icon: Icons.password_rounded,
              color: Colors.yellow[300],
            ),
            SizedBox(
              height: Dimensions.Height30,
            ),
            Padding(
              padding: EdgeInsets.only(right: Dimensions.Width20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  RichText(
                      text: TextSpan(
                          text: "Sign into your account",
                          style: TextStyle(
                              color: Colors.grey[500],
                              fontSize: Dimensions.fontSize20))),
                ],
              ),
            ),
            SizedBox(
              height: Dimensions.Height30 * 2,
            ),
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.Height30),
                color: AppColors.mainColor,
              ),
              child: Center(
                  child: BigText(
                text: "Sign In",
                size: Dimensions.fontSize26,
                color: Colors.white,
              )),
            ),
            SizedBox(
              height: Dimensions.Height15,
            ),
            SizedBox(
              height: Dimensions.Height20,
            ),
            RichText(
                text: TextSpan(
                    text: "Don't have an account?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.fontSize16),
                    children: [
                  TextSpan(
                      recognizer: TapGestureRecognizer()
                        ..onTap = () => Get.to(() => const SignUpPage(), transition: Transition.fade),
                      text: " Create",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: Dimensions.fontSize16,
                          fontWeight: FontWeight.bold))
                ])),
          ],
        ),
      ),
    );
  }
}
