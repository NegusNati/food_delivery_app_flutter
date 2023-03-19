import "package:dots_indicator/dots_indicator.dart";
import "package:flutter/material.dart";
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
import "../detail/popular_food_detail.dart";

class FoodSlider extends StatefulWidget {
  const FoodSlider({super.key});

  @override
  State<FoodSlider> createState() => _FoodSliderState();
}

class _FoodSliderState extends State<FoodSlider> {
  PageController pageController = PageController(viewportFraction: 0.8);
  var _currPageValue = 0.0;
  final double _scaleFactor = 0.8;
  final double _sliderHeight = Dimensions.pageViewImageContainer;
  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue = pageController.page!; //null cheker
        // print("the Value is $_currPageValue");
      });
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
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

        SizedBox(
          height: Dimensions.Height30,
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
            width: 700,
            margin: const EdgeInsets.only(left: 10, right: 10, top: 5),
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
            margin: const EdgeInsets.only(left: 40, right: 40, bottom: 10),
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
                  left: 15,
                  right: 15,
                  bottom: Dimensions.Height5),
              child: InfoColumn(text: popularProduct.name!),
            ),
          ),
        ),
      ]),
    );
  }
}
