import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/account/account_page.dart';
import 'package:food_delivery_app/pages/order/order_page.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:persistent_bottom_nav_bar/persistent_tab_view.dart';

import '../../coltrollers/auth_controller.dart';
import '../../coltrollers/user_controller.dart';
import '../../utills/colors.dart';
import '../cart/cart_history.dart';
import 'main_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  late PersistentTabController _controller;

  // List pages = [
  //   const MainPage(),
  //   Container(
  //     child: const Center(child: Text("Next Page")),
  //   ),
  //   Container(
  //     child: const Center(child: Text("Next 2 Page")),
  //   ),
  //   Container(
  //     child: const Center(child: Text("Next 3 Page")),
  //   ),
  // ];

  void onTapNav(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();

    _controller = PersistentTabController(initialIndex: 0);
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Scaffold(
  //     body: pages[_selectedIndex],
  //     bottomNavigationBar: BottomNavigationBar(
  //       selectedItemColor: AppColors.mainColor,
  //       unselectedItemColor: Color.fromARGB(255, 20, 19, 19),
  //       showUnselectedLabels: false,
  //       showSelectedLabels: true,
  //       currentIndex : _selectedIndex,
  //       onTap: onTapNav,
  //       items: const [
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.home,
  //             ),
  //             label: "Home"),
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.archive,
  //             ),
  //             label: "History"),
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.shopping_cart,
  //             ),
  //             label: "Cart"),
  //         BottomNavigationBarItem(
  //             icon: Icon(
  //               Icons.person,
  //             ),
  //             label: "Profile"),
  //       ],
  //     ),
  //   );
  // }

  List<Widget> _buildScreens() {
    return [
      const MainPage(),
      const OrderPage(),
      const CartHistory(),
      const AccountPage()
    ];
  }

  List<PersistentBottomNavBarItem> _navBarsItems() {
    return [
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.home),
        title: ("Home"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.archivebox_fill),
        title: ("History"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.cart_fill),
        title: ("Cart"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
      PersistentBottomNavBarItem(
        icon: const Icon(CupertinoIcons.person),
        title: ("Profile"),
        activeColorPrimary: AppColors.mainColor,
        inactiveColorPrimary: CupertinoColors.systemGrey,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
      bool userLoggedIn = Get.find<AuthController>().userHaveLoggedIn();
    if (userLoggedIn) {
      Get.find<UserController>().getUserInfo();
    }
    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      confineInSafeArea: true,
      backgroundColor: Colors.white, // Default is Colors.white.
      handleAndroidBackButtonPress: true, // Default is true.
      resizeToAvoidBottomInset:
          true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
      stateManagement: true, // Default is true.
      hideNavigationBarWhenKeyboardShows:
          true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
      decoration: NavBarDecoration(
        borderRadius: BorderRadius.circular(10.0),
        colorBehindNavBar: Colors.white,
      ),
      popAllScreensOnTapOfSelectedTab: true,
      popActionScreens: PopActionScreensType.all,
      itemAnimationProperties: const ItemAnimationProperties(
        // Navigation Bar's items animation properties.
        duration: Duration(milliseconds: 200),
        curve: Curves.ease,
      ),
      screenTransitionAnimation: const ScreenTransitionAnimation(
        // Screen transition animation on change of selected tab.
        animateTabTransition: true,
        curve: Curves.ease,
        duration: Duration(milliseconds: 200),
      ),
      navBarStyle:
          NavBarStyle.style1, // Choose the nav bar style with this property.
    );
  }
}
