import 'package:food_delivery_app/data/api/api_client.dart';
import 'package:get/get.dart';

import '../../../utills/app_constants.dart';

class RecomendedPoductRepo extends GetxService {
  final ApiClient apiClient;

 RecomendedPoductRepo({required this.apiClient});

  Future<Response> getRecomendedProductList() async {
    //TODO: End point 
    return await apiClient.getData(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
