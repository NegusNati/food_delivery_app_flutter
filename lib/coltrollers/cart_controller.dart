// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import 'package:food_delivery_app/data/api/repository/cart_repo.dart';

import '../models/cart_model.dart';
import '../models/popular_model.dart';

class CartController extends GetxController {
  final CartRepo cartRepo;
  CartController({
    required this.cartRepo,
  });
  Map<int, CartModel> _items = {};

  void addItem(ProductModal product, int quantity) {
    print("in the Cart id= " +
        product.id!.toString() +
        "  Quantity = " +
        quantity.toString());
    _items.putIfAbsent(product.id!, () {
      _items.forEach((key, value) {
        print("qunatity is " + value.quantity.toString());
      });

      print("object");

      return CartModel(
        id: product.id,
        name: product.name,
        price: product.price,
        img: product.img,
        quantity: quantity,
        isExist: true,
        time: DateTime.now().toString(),
      );
    });
  }
}
