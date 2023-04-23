import 'dart:convert';

import 'package:food_delivery_app/utills/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

//before added to history
  List<String> cart = [];

  //after added to history
  List<String> cartHistory = [];

  void addToCartList(List<CartModel> cartList) {
    //remove from memory before doing anything
    // sharedPreferences.remove(AppConstants.CART_LIST);
    // sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
    var time = DateTime.now().toString();
    cart = [];

    //convert object to string to save to SharedPreferences(

    cartList.forEach((element) {
      element.time = time;
      return cart.add(jsonEncode(element));
    });
    // for (var element in cartList) {
    //   element.time = time;
    //   continue;
    // }

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

    // print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList() {
    //because sharedPreference save only as a string data
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("Inside getCartList $carts");
    }
    List<CartModel> cartList = [];

    for (var element in carts) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    }
    //we can write like this too ...
    // carts.forEach((element) => CartModel.fromJson(jsonDecode(element)));
    return cartList;
  }

  List<CartModel> getCartHistoryList() {
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      // cartHistory = [];

      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
      // print("Inside getCartList  hostory : $cartHistory");
    }
    List<CartModel> cartListHistory = [];

    for (var element in cartHistory) {
      cartListHistory.add(CartModel.fromJson(jsonDecode(element)));
    }

    return cartListHistory;
  }

  void addToCartHistoryList() {
    //if there is a cart history first save it then proceed
    if (sharedPreferences.containsKey(AppConstants.CART_HISTORY_LIST)) {
      cartHistory =
          sharedPreferences.getStringList(AppConstants.CART_HISTORY_LIST)!;
    }
    for (int i = 0; i < cart.length; i++) {
      print("History list  : ${cart[i]}");
      cartHistory.add(cart[i]);
    }
//remove anything in cartList LS
    removeCart();
    sharedPreferences.setStringList(
        AppConstants.CART_HISTORY_LIST, cartHistory);
    print("the Length of history : ${getCartHistoryList().length}");
    for (int j = 0; j < getCartHistoryList().length; j++) {
      print("the Time order is  : ${getCartHistoryList()[j].time.toString()}");
    }
  }

  void removeCart() {
    cart = [];
    sharedPreferences.remove(AppConstants.CART_LIST);
  }

  void clearCartHistory() {
    removeCart();
    cartHistory = [];
    sharedPreferences.remove(AppConstants.CART_HISTORY_LIST);
  }
}
