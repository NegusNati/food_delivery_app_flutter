// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:get/get.dart';

import '../../../utills/app_constants.dart';
import '../api_client.dart';

class UserRepo {
  final ApiClient apiClient;
  UserRepo({
    required this.apiClient,
  });
  Future<Response> getUserInfo() async{
   return await apiClient.getData(AppConstants.USER_INFO);
  }
}
