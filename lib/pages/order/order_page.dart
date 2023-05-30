import 'package:flutter/material.dart';
import 'package:food_delivery_app/coltrollers/auth_controller.dart';
import 'package:food_delivery_app/coltrollers/order_controller.dart';
import 'package:food_delivery_app/pages/order/view_order.dart';
import 'package:food_delivery_app/utills/colors.dart';
import 'package:food_delivery_app/utills/dimensions.dart';
import 'package:get/get.dart';

import '../account/please_login.dart';

class OrderPage extends StatefulWidget {
  const OrderPage({super.key});

  @override
  State<OrderPage> createState() => _OrderPageState();
}

class _OrderPageState extends State<OrderPage> with TickerProviderStateMixin {
  late TabController _tabController;
  late bool _isLoggedIn;
  Future<void> _loadResource() async {
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    }
  }

  @override
  void initState() {
    super.initState();
    _isLoggedIn = Get.find<AuthController>().userHaveLoggedIn();
    if (_isLoggedIn) {
      _tabController = TabController(length: 2, vsync: this);
      Get.find<OrderController>().getOrderList();
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: _loadResource,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text("My Orders"),
          backgroundColor: AppColors.mainColor,
        ),
        body: _isLoggedIn
            ? Column(
                children: [
                  SizedBox(
                    width: Dimensions.screenWidth,
                    child: TabBar(
                      indicatorColor: Theme.of(context).primaryColor,
                      labelColor: Theme.of(context).primaryColor,
                      unselectedLabelColor: Theme.of(context).disabledColor,
                      indicatorWeight: 3,
                      tabs: const [
                        Tab(
                          text: "Current",
                        ),
                        Tab(
                          text: "History",
                        ),
                      ],
                      controller: _tabController,
                    ),
                  ),
                  Expanded(
                    child:
                        TabBarView(controller: _tabController, children: const [
                      ViewOrder(isCurrent: true),
                      ViewOrder(isCurrent: false),
                    ]),
                  )
                ],
              )
            : const PleaseLogin(),
      ),
    );
  }
}
