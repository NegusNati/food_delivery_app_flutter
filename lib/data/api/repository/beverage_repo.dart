import 'package:get/get.dart';

import '../../../utills/app_constants.dart';
import '../api_client.dart';

class BeverageRepo extends GetxService {
  final ApiClient apiClient;

  BeverageRepo({required this.apiClient});

  Future<Response> getPopularProductList() async {
    //TODO: End point 
    // return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
    return await apiClient.getData(AppConstants.DRINKS_URI);
  }
}
