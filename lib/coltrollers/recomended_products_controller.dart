import 'package:get/get.dart';

import '../data/api/repository/recomended_product_repo.dart';
import '../models/popular_model.dart';

class RecomendedProductController extends GetxController {
  final RecomendedPoductRepo recomendedPoductRepo;
  RecomendedProductController({required this.recomendedPoductRepo});

  List<ProductModal> _recomendedProductList = [];
  List<ProductModal> get recomendedProductList => _recomendedProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getRecomendedrProductList() async {
    Response response = await recomendedPoductRepo.getRecomendedProductList();
    // if (response.statusCode == 200) {
    //   _popularProductList = [];
    //   // create a model to accept the data from json
    //   // _popularProductList.addAll();
    //   update(); //is like setState for Getx
    // } else {}

    if (response.statusCode == 200) {
      print("got products");
      _recomendedProductList = [];
      _recomendedProductList.addAll(Product.fromJson(response.body).products);
      //  Map rawData = jsonDecode(response.body);
      // _popularProductList.addAll(Product.fromJson(rawData).products);
      //print(_popularProductList);
      _isLoaded = true;
      update();
    } else {
      print("No products");
    }
  }
}
