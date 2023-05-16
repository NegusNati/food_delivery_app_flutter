import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../coltrollers/cart_controller.dart';
import '../../models/order_model.dart';
import '../../routes/route_helper.dart';
import '../../utills/app_constants.dart';
import '../../utills/colors.dart';
import '../../utills/dimensions.dart';
import '../../widgets/show_custom_snackbar.dart';

class PaymentPage extends StatefulWidget {
  final OrderModel orderModel;
  const PaymentPage({super.key, required this.orderModel});

  @override
  _PaymentPageState createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  late String selectedUrl;
  double value = 0.0;
  bool _canRedirect = true;
  bool _isLoading = true;
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();
  late WebViewController controllerGlobal;

  @override
  void initState() {
    super.initState();
    selectedUrl =
        '${AppConstants.BASE_URL}/payment-mobile?customer_id=${widget.orderModel.userId}&order_id=${widget.orderModel.id}';
    //selectedUrl="https://mvs.bslmeiyu.com";
    if (Platform.isAndroid) WebView.platform = SurfaceAndroidWebView();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => _exitApp(context),
      // onWillPop: () => Get.toNamed(RouteHelper.getAddAddressPage());
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Payment"),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () => _exitApp(context),
          ),
          backgroundColor: AppColors.mainColor,
        ),
        body: Center(
          child: SizedBox(
            width: Dimensions.screenWidth,
            child: Stack(
              children: [
                WebView(
                  javascriptMode: JavascriptMode.unrestricted,
                  initialUrl: selectedUrl,
                  gestureNavigationEnabled: true,
                  userAgent: 'random',
                  onWebViewCreated: (WebViewController webViewController) {
                    _controller.future
                        .then((value) => controllerGlobal = value);
                    _controller.complete(webViewController);
                    //_controller.future.catchError(onError)
                  },
                  onProgress: (int progress) {
                    print("WebView is loading (progress : $progress%)");
                  },
                  onPageStarted: (String url) {
                    print('Page started loading: $url');
                    setState(() {
                      _isLoading = true;
                    });
                    print("printing urls $url");
                    _redirect(url);
                  },
                  onPageFinished: (String url) {
                    print('Page finished loading: $url');
                    setState(() {
                      _isLoading = false;
                    });
                    _redirect(url);
                  },
                ),
                _isLoading
                    ? Center(
                        child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                                Theme.of(context).primaryColor)),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _redirect(String url) {
    print("redirect");
    if (_canRedirect) {
      bool isSuccess =
          url.contains('success') && url.contains(AppConstants.BASE_URL);
      bool isFailed =
          url.contains('fail') && url.contains(AppConstants.BASE_URL);
      bool isCancel =
          url.contains('cancel') && url.contains(AppConstants.BASE_URL);
      if (isSuccess || isFailed || isCancel) {
        _canRedirect = false;
      }
      if (isSuccess) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(
            widget.orderModel.id.toString(), 'success'));
      } else if (isFailed || isCancel) {
        Get.offNamed(RouteHelper.getOrderSuccessRoute(
            widget.orderModel.id.toString(), 'fail'));
      } else {
        print("Encountered problem");
      }
    }
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      Get.snackbar(
          "Fast Delivery!", "Your order will will be there in just 7 minutes.",
          duration: const Duration(seconds: 6),
          backgroundColor: Colors.lightGreen);

      // Get.find<CartController>().clear();
      // Get.find<CartController>().removeCartSharedPreference();


      // Get.find<CartController>().addToHistory();
      Get.offAllNamed(RouteHelper.getInital());
      return Future.value(false);
    } else {
      print("app exited");
      showCustomSnackBar("So, no order will be delivered, sorry", title: "No payment provided!");
      Get.offAllNamed(RouteHelper.getInital());
      return true;
    }
  }
}
