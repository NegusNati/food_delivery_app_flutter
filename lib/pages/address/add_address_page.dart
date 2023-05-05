import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../coltrollers/auth_controller.dart';
import '../../coltrollers/location_controller.dart';
import '../../coltrollers/user_controller.dart';
import '../../utills/colors.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  TextEditingController _addressController = TextEditingController();
  TextEditingController _contactPersonName = TextEditingController();
  TextEditingController _contactPersonNumber = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(8.2150, 37.8025), zoom: 17);
  late LatLng _initialPosition = LatLng(8.2150, 37.8025);

  @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userHaveLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longtiude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longtiude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        backgroundColor: AppColors.mainColor,
      ),
      body: GetBuilder<LocationController>(builder: (locationController) {
        return Column(children: [
          Container(
            margin: EdgeInsets.only(left: 5, right: 5, top: 5),
            height: 140,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              border: Border.all(
                width: 2,
                color: Theme.of(context).primaryColor,
              ),
            ),
            child: Stack(
              children: [
                GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: _initialPosition, zoom: 17),
                  zoomControlsEnabled: false,
                  compassEnabled: false,
                  indoorViewEnabled: true,
                  mapToolbarEnabled: false,
                  onCameraIdle: () {
                    locationController.updatePosition(_cameraPosition, true);
                  },
                  onCameraMove: ((position) {
                    _cameraPosition = position;
                  }),
                  onMapCreated: (GoogleMapController controller) {
                    locationController.setMapController(controller);
                  },
                ),
              ],
            ),
          ),
        ]);
      }),
    );
  }
}
