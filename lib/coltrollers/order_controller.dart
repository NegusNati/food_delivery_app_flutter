import 'package:food_delivery_app/data/api/repository/order_repo.dart';
import 'package:get/get.dart';

import '../models/place_order_model.dart';

class OrderController extends GetxController implements GetxService {
  OrderRepo orderRepo;
  OrderController({required this.orderRepo});

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> placeOrder(PlaceOrderBody placeOrder, Function callback) async {
    _isLoading = true;
    Response response = await orderRepo.placeOrder(placeOrder);
  print("response obj : " + response.statusCode.toString());
    if (response.statusCode == 200) {
      print(" in status 200, from server");
      _isLoading = false;
      String message = response.body['message'];
      String orderId = response.body['order_id'].toString();
      callback(true, message, orderId);
    } else {
      callback(false, response.statusText, "-1");
    }
  }
}
