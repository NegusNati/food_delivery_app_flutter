import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:food_delivery_app/widgets/big_text.dart';
import 'package:food_delivery_app/widgets/text_field.dart';
import 'package:get/get.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

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
                radius: Dimensions.Height30 * 4,
                backgroundImage: const AssetImage(
                  "assets/image/logo part 1.png",
                ),
              ),
            ),
            TextFieldWidget(
              textController: emailController,
              hintText: " Email",
              icon: Icons.email_rounded,
              color: Colors.yellow[300],
            ),
            TextFieldWidget(
              textController: nameController,
              hintText: " Name",
              icon: Icons.person,
              color: Colors.yellow[300],
            ),
            SizedBox(
              height: Dimensions.Height20,
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
            Container(
              width: Dimensions.screenWidth / 2,
              height: Dimensions.screenHeight / 14,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.Height30),
                color: AppColors.mainColor,
              ),
              child: Center(
                  child: BigText(
                text: "Sign-Up",
                size: Dimensions.fontSize26,
                color: Colors.white,
              )),
            ),
            SizedBox(
              height: Dimensions.Height15,
            ),
            RichText(
                text: TextSpan(
                    recognizer: TapGestureRecognizer()..onTap = () => Get.back(),
                    text: "Have an account already?",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.fontSize20))),
            SizedBox(
              height: Dimensions.Height20,
            ),
            RichText(
                text: TextSpan(
                    text: "Sign up using other methods",
                    style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: Dimensions.fontSize16))),
            Wrap(
              children: List.generate(3, (index) => Padding(
                padding: const EdgeInsets.all(10.0),
                child: CircleAvatar(
                  radius: Dimensions.radiusSize30 - 5,
                  backgroundImage: AssetImage("assets/image/${signUpImages[index]}"),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}
