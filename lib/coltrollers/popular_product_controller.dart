import 'package:get/get.dart';

import '../data/api/repository/popular_product_repo.dart';
import '../models/popular_model.dart';

class PopularProductController extends GetxController {
  final PopularPoductRepo popularPoductRepo;
  PopularProductController({required this.popularPoductRepo});

  List<dynamic> _popularProductList = [];
  List<dynamic> get popularProductList => _popularProductList;
  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  Future<void> getPopularProductList() async {
    Response response = await popularPoductRepo.getPopularProductList();
    // if (response.statusCode == 200) {
    //   _popularProductList = [];
    //   // create a model to accept the data from json
    //   // _popularProductList.addAll();
    //   update(); //is like setState for Getx
    // } else {}

    if (response.statusCode == 200) {
      print("got products");
      _popularProductList = [];
      _popularProductList.addAll(Product.fromJson(response.body).products);
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
