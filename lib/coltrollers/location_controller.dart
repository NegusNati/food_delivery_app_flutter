// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';

import 'package:food_delivery_app/data/api/repository/location_repo.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../models/address_model.dart';

class LocationController extends GetxController implements GetxService {
  LocationRepo locationRepo;

  LocationController({
    required this.locationRepo,
  });
  bool _loading = false;
  late Position _position; //current position(Default)
  late Position _pickedPosition; //newely picked position
  final Placemark _placemark = Placemark();
  final Placemark _pickPlacemark = Placemark();

  final List<AddressModel> _addressList = [];
  List<AddressModel> get addressList => _addressList;
  late List<AddressModel> _allAddressList;
  final List<String> _addressTypeList = ["home", "office", "other"];
  final int _addressTypeIndex = 0;
  late Map<String, dynamic> _getAddress;
  Map get getAddress => _getAddress;

  late GoogleMapController _mapController;
  final bool _updateAddressData = true;
  final bool _changeAddress = true;

  bool get loading => _loading;
  Position get position => _position;
  Position get pickPosition => _pickedPosition;

  void setMapController(GoogleMapController mapController) {
    _mapController = mapController;
  }

  void updatePosition(CameraPosition position, bool fromAddress) async {
    if (_updateAddressData) {
      _loading = true;
      update();
      try {
        if (fromAddress) {
          _position = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        } else {
          _pickedPosition = Position(
              longitude: position.target.longitude,
              latitude: position.target.latitude,
              timestamp: DateTime.now(),
              accuracy: 1,
              altitude: 1,
              heading: 1,
              speed: 1,
              speedAccuracy: 1);
        }
        if (_changeAddress) {
          String address = await getAddressFromGeocode(
              LatLng(position.target.latitude, position.target.longitude));
        }
      } catch (e) {
        print(e);
      }
    }
  }

  Future<String> getAddressFromGeocode(LatLng latlng) async {
    String address = "Unknown Loaction found";
    Response response = await locationRepo.getAddressFromGeocode(latlng);
    if (response.body["status"] == 'OK') {
      address = response.body['results'][0]['formatted_address'].toString();
      print("Printing address:  " + address);
    } else {
      print(response.body['status'].toString());
      print("error getting the google api ");
    }
    return address;
  }
}
