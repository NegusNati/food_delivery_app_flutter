import 'package:flutter/material.dart';
import 'package:food_delivery_app/models/cart_model.dart';
import 'package:get/get.dart';

import '../data/api/repository/popular_product_repo.dart';
import '../models/popular_model.dart';
import '../utills/colors.dart';
import 'cart_controller.dart';

class PopularProductController extends GetxController {
  final PopularPoductRepo popularPoductRepo;
  PopularProductController({required this.popularPoductRepo});

  late CartController _cart;

  List<ProductModal> _popularProductList = [];
  List<ProductModal> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;
  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;

  Future<void> getPopularProductList() async {
    Response response = await popularPoductRepo.getPopularProductList();
    // if (response.statusCode == 200) {
    //   _popularProductList = [];
    //   // create a model to accept the data from json
    //   // _popularProductList.addAll();
    //   update(); //is like setState for Getx
    // } else {}

    if (response.statusCode == 200) {
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
      //  Map rawData = jsonDecode(response.body);
      // _popularProductList.addAll(Product.fromJson(rawData).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("could ont get products, : from controller");
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
      print("Incremented by : $_quantity");
    } else {
      _quantity = checkQuantity(_quantity - 1);

      print("Decremented  by : $_quantity");
    }
    update(); //to build the UI everytime there is an update in quantity
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      Get.snackbar(
        "Sorry",
        "You can't reduce more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        overlayBlur: 1,
      );
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 30) {
      Get.snackbar(
        "Sorry",
        "You can't Add more",
        backgroundColor: AppColors.mainColor,
        colorText: Colors.white,
        overlayBlur: 1,
      );
      return 30;
    } else {
      return quantity;
    }
  }

  void initProduct(CartController cart, ProductModal? product) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existInCart(product!);

    print("Does it ? =>" + exist.toString());
    if (exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("Qunatity in cart is  =>" + _inCartItems.toString());
  }

  void addItem(ProductModal product) {
    // if (_quantity > 0) { moved to cart controller
    _cart.addItem(product, _quantity);
    _quantity = 0;
    _inCartItems = _cart.getQuantity(product);
    _cart.items.forEach((key, value) {
      print("The Id is ${value.id}The Quantity is ${value.quantity}");
    });
    // } else {
    //   Get.snackbar(
    //     "Sorry",
    //     "You need to add more items!",
    //     backgroundColor: AppColors.mainColor,
    //     colorText: Colors.white,
    //     overlayBlur: 1,
    //   );
    // }
    update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}
