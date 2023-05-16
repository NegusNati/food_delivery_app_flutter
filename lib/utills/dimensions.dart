import 'package:get/get.dart';

double heightImageFactor = 3.747;
double heightTextFactor = 8.177;
double heightContainerFactor = 2.81;
double height20Factor = 44.97;
double height5Factor = 179.88572;
double height15Factor = 59.962;
double height30Factor = 29.9809666;
double height10Factor = 89.9428;
double heightListViewImageFactor = 3.429;
double heightListViewTextFactor = 5.142;
double heightPopularPage350Factor = 2.569;
double heightIcon16Factor = 56.21;
double heightfont26Factor = 34.59;
double heightBottom120Factor = 7.49;
double heightFont16Factor = 56.21;
double heightFont12Factor = 60.21;

class Dimensions {
  static double screenHeight = Get.height;
  static double screenWidth = Get.width;

// based on each mobile screen size we get relative screen size
  static double pageViewImageContainer = screenHeight / heightImageFactor;
  static double pageViewTextContainer = screenHeight / heightTextFactor;
  static double pageViewContainer = screenHeight / heightContainerFactor;

//Dynamic  Hight for sized boxes and other hight params
  static double Height5 = screenHeight / height5Factor;
  static double Height15 = screenHeight / height15Factor;
  static double Height20 = screenHeight / height20Factor;
  static double Height30 = screenHeight / height30Factor;

// Dynamic Width for sized boxes, paddings and other params with specific pixels
  static double Width5 = screenHeight / height5Factor;
  static double Width10 = screenHeight / height10Factor;
  static double Width15 = screenHeight / height15Factor;
  static double Width20 = screenHeight / height20Factor;
  static double Width30 = screenHeight / height30Factor;

//font size
  static double fontSize20 = screenHeight / height20Factor;
  static double fontSize16 = screenHeight / heightFont16Factor;
  static double fontSize12 = screenHeight / heightFont12Factor;
  static double fontSize26 = screenHeight / heightfont26Factor;

  //rddius size
  static double radiusSize20 = screenHeight / height20Factor;
  static double radiusSize30 = screenHeight / height30Factor;
  static double radiusSize5 = screenHeight / height5Factor;

  //icon Size(),
  static double iconSize16 = screenHeight / heightIcon16Factor;

  //list view size
  static double listViewImgSize = screenWidth / heightListViewImageFactor;
  static double listViewTextSize = screenWidth / heightListViewTextFactor;

  //popular food page Detail(
  static double popularPageImageSize =
      screenHeight / heightPopularPage350Factor;

  // bottom hight
  static double bottomHeightBarSize = screenHeight / heightBottom120Factor;

  //splash screen 
  static double splashImg = screenHeight / 3.38;
}
