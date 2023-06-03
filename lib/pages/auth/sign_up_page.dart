import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import '../../utills/colors.dart';
import '../../utills/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/custom_loader.dart';
import '../../widgets/text_field.dart';
import 'package:get/get.dart';

import '../../coltrollers/auth_controller.dart';
import '../../models/signup_model.dart';
import '../../routes/route_helper.dart';
import '../../widgets/show_custom_snackbar.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    var emailController = TextEditingController();
    var nameController = TextEditingController();
    var phoneController = TextEditingController();
    var passwordController = TextEditingController();
    var signUpImages = ["t.png", "f.png", "g.png"];

    void _registeration(AuthController authController) {
      // var authController = Get.find<AuthController>();
      String email = emailController.text.trim();
      String name = nameController.text.trim();
      String phone = phoneController.text.trim();
      String password = passwordController.text.trim();

      if (email.isEmpty) {
        showCustomSnackBar("Please, Type in your Email.", title: "Email ");
      } else if (!GetUtils.isEmail(email)) {
        showCustomSnackBar("Please, Type in a Valid Email Address",
            title: "Valid Email");
      } else if (name.isEmpty) {
        showCustomSnackBar("Please, Type in your Name.", title: "Name ");
      } else if (phone.isEmpty) {
        showCustomSnackBar("Please, Type in your Phone Number.",
            title: "Phone Number");
      } else if (!GetUtils.isNumericOnly(phone)) {
        showCustomSnackBar("Only Numeric values are accepted.",
            title: "Phone Number");
      } else if (password.isEmpty) {
        showCustomSnackBar("Please, Type in your Password.", title: "Password");
      } else if (password.length < 6) {
        showCustomSnackBar("Password must be above 6 characters",
            title: "Password length");
      } else {
        SignUpBody signUpBody = SignUpBody(
            name: name, email: email, password: password, phone: phone);
        authController.registration(signUpBody).then((status) {
          if (status.isSuccess) {
            print("Success in registration");
             Get.toNamed(RouteHelper.getInital());
           
          } else {
            showCustomSnackBar(status.message);
          }
        });

        print(signUpBody.toString());
      }
    }

    return Scaffold(
        backgroundColor: Colors.white,
        body: GetBuilder<AuthController>(
          builder: (authController) {
            return !authController.isLoading
                ? SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Column(
                      children: [
                        SizedBox( height:Dimensions.Height15),
                        Container(
                          margin: EdgeInsets.only(top: Dimensions.Height30),
                          // width: double.maxFinite,
                          // height: Dimensions.Height30 * 3,
                          child: CircleAvatar(
                            backgroundColor: Colors.white,
                            radius: Dimensions.Height30 * 4,
                            backgroundImage: const AssetImage(
                              "assets/image/forgot.png",
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
                          isObsecure: true,
                        ),
                        SizedBox(
                          height: Dimensions.Height30,
                        ),
                        GestureDetector(
                          onTap: () {
                            _registeration(authController);
                          },
                          child: Container(
                            width: Dimensions.screenWidth / 2,
                            height: Dimensions.screenHeight / 14,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.circular(Dimensions.Height30),
                              color: AppColors.mainColor,
                            ),
                            child: Center(
                                child: BigText(
                              text: "Sign-Up",
                              size: Dimensions.fontSize26,
                              color: Colors.white,
                            )),
                          ),
                        ),
                        SizedBox(
                          height: Dimensions.Height15,
                        ),
                        RichText(
                            text: TextSpan(
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () => Get.back(),
                                text: "Have an account already?",
                                style: TextStyle(
                                    color: Colors.grey[500],
                                    fontSize: Dimensions.fontSize20))),
                        SizedBox(
                          height: Dimensions.Height20,
                        ),
                       
                      ],
                    ),
                  )
                : const CustomLoader();
          },
        ));
  }
}
