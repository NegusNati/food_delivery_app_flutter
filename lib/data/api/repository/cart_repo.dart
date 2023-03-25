import 'dart:convert';

import 'package:food_delivery_app/utills/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;

  CartRepo({required this.sharedPreferences});

  List<String> cart = [];

  void addToCartList(List<CartModel> cartList) {
    cart = [];

    //convert object to string to save to sharedPreferences
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });

    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);

    print(sharedPreferences.getStringList(AppConstants.CART_LIST));
  }

  List<CartModel> getCartList() {
    //because sharedPreference save only as a string data
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
    }
    List<CartModel> cartList = [];

    carts.forEach((element) {
      cartList.add(CartModel.fromJson(jsonDecode(element)));
    });
    //we can write like this too ...
    // carts.forEach((element) => CartModel.fromJson(jsonDecode(element)));
    return cartList;
  }
}
