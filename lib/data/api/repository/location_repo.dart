// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:shared_preferences/shared_preferences.dart';

import '../api_client.dart';

class LocationRepo {

final ApiClient apiClient;
final SharedPreferences sharedPreferences;
 
  LocationRepo({
    required this.apiClient,
    required this.sharedPreferences,
  });

}
