import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../../utills/app_constants.dart';

class PopularPoductRepo extends GetxService {
  final ApiClient apiClient;

  PopularPoductRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    //TODO: End point 
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
  }
}
