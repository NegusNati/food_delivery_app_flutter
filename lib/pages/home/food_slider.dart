import "package:dots_indicator/dots_indicator.dart";
import "package:flutter/material.dart";
import "package:food_delivery_app/coltrollers/beverage_controller.dart";
import "package:food_delivery_app/coltrollers/popular_product_controller.dart";
import "package:food_delivery_app/utills/app_constants.dart";
import "package:food_delivery_app/utills/dimensions.dart";
import "package:food_delivery_app/widgets/icon_widget.dart";
import "package:food_delivery_app/widgets/info_column.dart";
import "package:get/get.dart";
import "../../coltrollers/recomended_products_controller.dart";
import "../../models/popular_model.dart";
import "../../routes/route_helper.dart";
import '../../utills/colors.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';

class FoodSlider extends StatefulWidget {
  const FoodSlider({super.key});

  @override
  State<FoodSlider> createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  PageController pageController = PageController(viewportFraction: 0.8);
  PageController pageControllerBeverage = PageController(viewportFraction: 0.8);
  var _currPageValue = 0.0;
  var _currPageValueBeverage = 0.0;
  final double _scaleFactor = 0.8;
  final double _scaleFactorBeverage = 0.8;
  final double _sliderHeight = Dimensions.pageViewImageContainer;
  final double _sliderHeightBeverage = Dimensions.pageViewImageContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!; //null cheker
 //null cheker
        // print("the Value is $_currPageValue");
      });
    });

      pageControllerBeverage.addListener(() {
      setState(() {
 //null cheker
        _currPageValueBeverage = pageControllerBeverage.page!; //null cheker
        // print("the Value is $_currPageValue");
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
    pageControllerBeverage.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print("tHs ${MediaQuery.of(context).size.height}");
    // print("tHs ${MediaQuery.of(context).size.width}");
    return Column(
      children: [
        //the Slider
        //we user GetBuilder to redraw ui every time a change is made to the sate
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  color: Colors.white,
                  height: Dimensions.pageViewContainer,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItem(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                  backgroundColor: Colors.white,
                  strokeWidth: 8,
                );
        }),
        //the slide indicator
        GetBuilder<PopularProductController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 2
                : popularProducts.popularProductList.length,
            position: _currPageValue,
            decorator: DotsDecorator(
              size: const Size.square(9.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(18.0, 9.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSize5)),
            ),
          );
        }),

      

//  for beverages
        GetBuilder<BeverageController>(builder: (popularProducts) {
          return popularProducts.isLoaded
              ? Container(
                  color: Colors.white,
                  height: Dimensions.pageViewContainer / 1.9,
                  child: PageView.builder(
                    controller: pageControllerBeverage,
                    itemCount: popularProducts.popularProductList.length,
                    itemBuilder: (context, position) {
                      return _buildPageItemBverages(position,
                          popularProducts.popularProductList[position]);
                    },
                  ),
                )
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                  backgroundColor: Colors.white,
                  strokeWidth: 4,
                );
        }),

        GetBuilder<BeverageController>(builder: (popularProducts) {
          return DotsIndicator(
            dotsCount: popularProducts.popularProductList.isEmpty
                ? 2
                : popularProducts.popularProductList.length,
            position: _currPageValueBeverage,
            decorator: DotsDecorator(
              size: const Size.square(5.0),
              activeColor: AppColors.mainColor,
              activeSize: const Size(10.0, 7.0),
              activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radiusSize5)),
            ),
          );
        }),

        SizedBox(
          height: Dimensions.Height15,
        ),

        //popular Text
        Container(
          margin: EdgeInsets.only(left: Dimensions.Width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Recommended"),
              SizedBox(
                width: Dimensions.Width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(
                  text: ".",
                  color: Colors.black26,
                ),
              ),
              SizedBox(
                width: Dimensions.Width10,
              ),
              Container(
                margin: const EdgeInsets.only(bottom: 2),
                child: SmallText(text: "Food Pairing"),
              )
            ],
          ),
        ),
//our list of Recommended food
        GetBuilder<RecomendedProductController>(builder: (recomendedProduct) {
          return recomendedProduct.isLoaded
              ? ListView.builder(
                  // addAutomaticKeepAlives: true,

                  shrinkWrap: true, //use it with AlwaysScrollableScrollPhysics
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: recomendedProduct.recomendedProductList.length,
                  itemBuilder: (context, index) {
                    //index is the number of items you want in the list
                    return GestureDetector(
                      onTap: () {
                        Get.toNamed(RouteHelper.getRecomendedFood(index));
                      },
                      child: Container(
                        margin: EdgeInsets.only(
                            top: Dimensions.Height5,
                            left: Dimensions.Width10,
                            right: Dimensions.Width10,
                            bottom: Dimensions.Height5),
                        child: Row(children: [
                          //image section
                          Container(
                            width: Dimensions.listViewImgSize,
                            height: Dimensions.listViewImgSize,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                    Dimensions.radiusSize20),
                                color: Colors.white24,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  // image: AssetImage("assets/image/food0.png"),
                                  image: NetworkImage(AppConstants.BASE_URL +
                                          AppConstants.UPLOAD_URL +
                                          recomendedProduct
                                              .recomendedProductList[index]
                                              .img! //bang operator (tell compiler it can't be null)
                                      ),
                                )),
                          ),
                          //text Section
                          Expanded(
                            child: Container(
                              margin: EdgeInsets.only(left: Dimensions.Width10),
                              // padding: EdgeInsets.only(top: Dimensions.Height15, bottom: Dimensions.Height15),
                              height: Dimensions.listViewTextSize,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(
                                    Dimensions.radiusSize20,
                                  ),
                                  bottomRight: Radius.circular(
                                    Dimensions.radiusSize20,
                                  ),
                                ),
                                color: Colors.white24,
                              ),

                              child: Padding(
                                padding: EdgeInsets.only(
                                  left: Dimensions.Width10,
                                  right: Dimensions.Width10,
                                  top: Dimensions.Height5,
                                ),
                                child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      BigText(
                                          text: recomendedProduct
                                              .recomendedProductList[index]
                                              .name!,
                                          overFlow: TextOverflow.ellipsis),
                                      SmallText(text: "This is the small text"),
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            IconWidget(
                                                icon: Icons.circle_sharp,
                                                text: "Normal",
                                                iconColor:
                                                    AppColors.iconColor1),
                                            IconWidget(
                                                icon: Icons.location_on,
                                                text: "1.7km",
                                                iconColor: AppColors.mainColor),
                                            IconWidget(
                                                icon: Icons.access_time_rounded,
                                                text: "32min",
                                                iconColor:
                                                    AppColors.iconColor2),
                                          ])
                                    ]),
                              ),
                            ),
                          ),
                        ]),
                      ),
                    );
                  })
              : CircularProgressIndicator(
                  color: AppColors.mainColor,
                  backgroundColor: Colors.white,
                  strokeWidth: 8,
                );
        })
      ],
    );
  }

  Widget _buildPageItem(int position, ProductModal popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (position == _currPageValue.floor()) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);
      var currTrans = _sliderHeight * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() + 1) {
      var currScale =
          _scaleFactor + (_currPageValue - position + 1) * (1 - _scaleFactor);
      var currTrans = _sliderHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValue.floor() - 1) {
      var currScale = 1 - (_currPageValue - position) * (1 - _scaleFactor);

      var currTrans = _sliderHeight * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _sliderHeight * (1 - _scaleFactor) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getPopularFood(position));
          },
          child: Container(
            height: Dimensions.pageViewImageContainer,
            width: Dimensions.Width30 * 23,
            margin: EdgeInsets.only(
                left: Dimensions.Width10,
                right: Dimensions.Width10,
                top: Dimensions.Height5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
                color: position.isEven
                    ? const Color(0xff69c5df)
                    : Colors.green[400],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // image: AssetImage("assets/image/food0.png"),
                  image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct
                              .img! //bang operator (tell compiler it can't be null)
                      ),
                )),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Container(
            height: Dimensions.pageViewTextContainer,
            margin: EdgeInsets.only(
                left: Dimensions.Width20 * 2,
                right: Dimensions.Width20 * 2,
                bottom: Dimensions.Height20 / 2),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
              color: Colors.white,
              boxShadow: const [
                BoxShadow(
                  color: Color(0xffe8e8e8),
                  blurRadius: 5.0,
                  offset: Offset(0, 5),
                  // spreadRadius: 0.3,
                ),
                BoxShadow(
                  color: Colors.white,
                  // blurRadius: 5.0,
                  offset: Offset(-5, 0),
                  // spreadRadius: 0.3,
                ),
                BoxShadow(
                  color: Colors.white,
                  // blurRadius: 5.0,
                  offset: Offset(5, 0),
                  // spreadRadius: 0.3,
                ),
              ],
            ),
            child: Container(
              padding: EdgeInsets.only(
                  top: Dimensions.Height15,
                  left: Dimensions.Width10,
                  right: Dimensions.Width10,
                  bottom: Dimensions.Height5),
              child: InfoColumn(text: popularProduct.name!),
            ),
          ),
        ),
      ]),
    );
  }






  //for the beverages

   Widget _buildPageItemBverages(int position, ProductModal popularProduct) {
    Matrix4 matrix = Matrix4.identity();
    if (position == _currPageValueBeverage.floor()) {
      var currScale = 1 - (_currPageValueBeverage - position) * (1 - _scaleFactorBeverage);
      var currTrans = _sliderHeightBeverage * (1 - currScale) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValueBeverage.floor() + 1) {
      var currScale =
          _scaleFactorBeverage + (_currPageValueBeverage - position + 1) * (1 - _scaleFactorBeverage);
      var currTrans = _sliderHeightBeverage * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else if (position == _currPageValueBeverage.floor() - 1) {
      var currScale = 1 - (_currPageValueBeverage - position) * (1 - _scaleFactorBeverage);

      var currTrans = _sliderHeightBeverage * (1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);
    } else {
      var currScale = 0.8;
      var currTrans = _sliderHeightBeverage * (1 - _scaleFactorBeverage) / 2;

      matrix = Matrix4.diagonal3Values(1, currScale, 1)
        ..setTranslationRaw(0, currTrans, 0);

    }

    return Transform(
      transform: matrix,
      child: Stack(children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(RouteHelper.getBeverages(position));
          },
          child: Container(
            height: Dimensions.pageViewImageContainer / 1.7,
            width: Dimensions.Width30 * 4,
            margin: EdgeInsets.only(
                left: Dimensions.Width5,
                right: Dimensions.Width5,
                top: Dimensions.Height5),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
                color: position.isEven
                    ? const Color(0xff69c5df)
                    : Colors.green[400],
                image: DecorationImage(
                  fit: BoxFit.cover,
                  // image: AssetImage("assets/image/food0.png"),
                  image: NetworkImage(AppConstants.BASE_URL +
                          AppConstants.UPLOAD_URL +
                          popularProduct
                              .img! //bang operator (tell compiler it can't be null)
                      ),
                )),
          ),
        ),
        Positioned(
          right: 1,
          top: 1,


          child: Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: Dimensions.pageViewTextContainer/ 1,
              margin: EdgeInsets.only(
                top:Dimensions.Width15 ,
                  left: Dimensions.Width10/2 ,
                  right: Dimensions.Width10/2 ,
                  ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radiusSize30),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                    color: Color(0xffe8e8e8),
                    blurRadius: 5.0,
                    offset: Offset(0, 5),
                    // spreadRadius: 0.3,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    // blurRadius: 5.0,
                    offset: Offset(-5, 0),
                    // spreadRadius: 0.3,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    // blurRadius: 5.0,
                    offset: Offset(5, 0),
                    // spreadRadius: 0.3,
                  ),
                ],
              ),
              child: Container(
                padding: EdgeInsets.only(
                    top: Dimensions.Height15 / 2,
                    left: Dimensions.Width5,
                    right: Dimensions.Width5,
                    bottom: Dimensions.Height5 /3),
                child: InfoColumn(text: popularProduct.name!),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
