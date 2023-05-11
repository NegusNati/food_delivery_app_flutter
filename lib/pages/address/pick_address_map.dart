// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:food_delivery_app/routes/route_helper.dart';
import 'package:food_delivery_app/widgets/custom_button.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../coltrollers/location_controller.dart';
import '../../utills/colors.dart';
import '../../utills/dimensions.dart';

class PickAddressMap extends StatefulWidget {
  final bool fromSignup;
  final bool fromAddress;
  final GoogleMapController? googleMapController;
  const PickAddressMap({
    Key? key,
    required this.fromSignup,
    required this.fromAddress,
    this.googleMapController,
  }) : super(key: key);

  @override
  State<PickAddressMap> createState() => _PickAddressMapState();
}

class _PickAddressMapState extends State<PickAddressMap> {
  late LatLng _initalPosition;
  late GoogleMapController _mapController;
  late CameraPosition _cameraPosition;

  @override
  void initState() {
    super.initState();
    if (Get.find<LocationController>().addressList.isEmpty) {
      _initalPosition = const LatLng(8.2150, 37.8025);
      _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
    } else {
      if (Get.find<LocationController>().addressList.isNotEmpty) {
        _initalPosition = LatLng(
            double.parse(Get.find<LocationController>().getAddress['latitude']),
            double.parse(
                Get.find<LocationController>().getAddress['longitude']));
        _cameraPosition = CameraPosition(target: _initalPosition, zoom: 17);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LocationController>(builder: (locationController) {
      return Scaffold(
        body: SafeArea(
          child: Center(
            child: SizedBox(
              width: double.maxFinite,
              child: Stack(
                children: [
                  GoogleMap(
                      initialCameraPosition:
                          CameraPosition(target: _initalPosition, zoom: 17),
                      zoomControlsEnabled: false,
                      onCameraMove: (CameraPosition cameraPosition) {
                        _cameraPosition = cameraPosition;
                      },
                      onCameraIdle: () {
                        Get.find<LocationController>()
                            .updatePosition(_cameraPosition, false);
                      }),
                  Center(
                    child: !locationController.loading
                        ? Image.asset(
                            "assets/image/pick_marker.png",
                            height: 50,
                            width: 50,
                          )
                        : const CircularProgressIndicator(),
                  ),
                  Positioned(
                    top: Dimensions.Height30,
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: Dimensions.Width10),
                      height: 50,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize20 / 2),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.location_on,
                              size: 25, color: AppColors.yellowColor),
                          Expanded(
                              child: Text(
                            locationController.pickPlacemark.name ?? "",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: Dimensions.fontSize16,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          )),
                        ],
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 120,
                    left: Dimensions.Width20,
                    right: Dimensions.Width20,
                    child: locationController.isLoading
                        ? const Center(
                            child: CircularProgressIndicator(),
                          )
                        : CustomButton(
                            buttonText:locationController.inZone? widget.fromAddress?  "Pick Address" : "Pick Location": "Service Not Avaliable in Your Area",
                            onPressed:(locationController.buttonDisabled || locationController.loading)
                                ? null
                                : () {
                                    if (locationController
                                                .pickPosition.latitude !=
                                            0 &&
                                        locationController.pickPlacemark.name !=
                                            null) {
                                      if (widget.fromAddress) {
                                        if (widget.googleMapController !=
                                            null) {
                                          print(
                                              "now we can clicked  on this? ");
                                          widget.googleMapController!.moveCamera(
                                              CameraUpdate.newCameraPosition(
                                                  CameraPosition(
                                                      target: LatLng(
                                                          locationController
                                                              .pickPosition
                                                              .latitude,
                                                          locationController
                                                              .pickPosition
                                                              .longitude))));
                                          locationController.setAddressData();
                                        }
                                        Get.toNamed(
                                            RouteHelper.getAddAddressPage());
                                      }
                                    } else {}
                                  },
                          ),
                  )
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
