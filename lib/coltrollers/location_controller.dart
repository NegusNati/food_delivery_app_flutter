// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/api/repository/location_repo.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({
    required this.locationRepo,
  });
  bool _loading = false;
  late Position _position; //current position(Default)
  late Position _pickedPosition; //newely picked position
  Placemark _placemark = Placemark();
  Placemark _pickPlacemark = Placemark();

  List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  List<String> _addressTypeList = ["home", "office", "other"];
  int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;
}
