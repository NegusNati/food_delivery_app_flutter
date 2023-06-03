import 'package:flutter/material.dart';
import 'package:food_delivery_app/pages/address/pick_address_map.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart';
import '../../coltrollers/auth_controller.dart';
import '../../coltrollers/location_controller.dart';
import '../../coltrollers/user_controller.dart';
import '../../models/address_model.dart';
import '../../routes/route_helper.dart';
import '../../utills/colors.dart';
import '../../utills/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/show_custom_snackbar.dart';
import '../../widgets/text_field.dart';

class AddAddressPage extends StatefulWidget {
  const AddAddressPage({super.key});

  @override
  State<AddAddressPage> createState() => _AddAddressPageState();
}

class _AddAddressPageState extends State<AddAddressPage> {
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _contactPersonName = TextEditingController();
  final TextEditingController _contactPersonNumber = TextEditingController();
  final TextEditingController _locController = TextEditingController();

  late bool _isLogged;
  CameraPosition _cameraPosition =
      const CameraPosition(target: LatLng(8.2150, 37.8025), zoom: 17);
  late LatLng _initialPosition = const LatLng(8.2150, 37.8025);

  @override
  void initState() {
    super.initState();

    _isLogged = Get.find<AuthController>().userHaveLoggedIn();
    if (_isLogged && Get.find<UserController>().userModel == null) {
      Get.find<UserController>().getUserInfo();
    }
    if (Get.find<LocationController>().addressList.isNotEmpty) {
      if (Get.find<LocationController>().getUserAddressFromLocalStorage() ==
          "") {
        Get.find<LocationController>()
            .saveUserAddress(Get.find<LocationController>().addressList.last);
      }
      Get.find<LocationController>().getUserAddress();
      _cameraPosition = CameraPosition(
          target: LatLng(
              double.parse(
                  Get.find<LocationController>().getAddress['latitude']),
              double.parse(
                  Get.find<LocationController>().getAddress['longitude'])));
      _initialPosition = LatLng(
          double.parse(Get.find<LocationController>().getAddress['latitude']),
          double.parse(Get.find<LocationController>().getAddress['longitude']));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Add Your Address"),
        backgroundColor: AppColors.mainColor,
         automaticallyImplyLeading: false,
         actions: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios_sharp),
            onPressed: () {
              // Get.find<OrderController>().getOrderList();
              Get.toNamed(RouteHelper.getInital());
              // Get.back();
              // Get.to(OrderPage());
              // Navigator.pop(context);
            
              
            },
          )
        ],
      ),
      body: GetBuilder<UserController>(builder: (userController) {
        if (_contactPersonName.text.isEmpty) {
          _contactPersonName.text = userController.userModel.name ?? '';
          _contactPersonNumber.text = userController.userModel.phone ?? '';

          if (Get.find<LocationController>().addressList.isNotEmpty) {
            _addressController.text =
                Get.find<LocationController>().getUserAddress().address;
          }
        }
        return GetBuilder<LocationController>(builder: (locationController) {
          _addressController.text = '${locationController.placemark.name ?? ''}'
              '${locationController.placemark.locality ?? ''}'
              '${locationController.placemark.subLocality ?? ''}'
              '${locationController.placemark.country ?? ''}';

          print(_addressController.toString());

          return SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Container(
                margin: const EdgeInsets.only(left: 5, right: 5, top: 5),
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
                      onTap: (latlang) {
                        Get.toNamed(RouteHelper.pickAddressMapPage(),
                            arguments: PickAddressMap(
                              fromSignup: false,
                              fromAddress: true,
                              googleMapController:
                                  locationController.mapController,
                            ));
                      },
                      zoomControlsEnabled: false,
                      compassEnabled: false,
                      indoorViewEnabled: true,
                      mapToolbarEnabled: false,
                      myLocationEnabled: true,
                      myLocationButtonEnabled: true,
                      onCameraIdle: () {
                        locationController.updatePosition(
                            _cameraPosition, true);
                      },
                      onCameraMove: ((CameraPosition position) {
                        _cameraPosition = position;
                      }),
                      onMapCreated: (GoogleMapController controller) {
                        locationController.setMapController(controller);
                      },
                    ),
                  ],
                ),
              ),
              SizedBox(height: Dimensions.Height15),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.Height15),
                child: SizedBox(
                  height: Dimensions.Height30 * 1.7,
                  child: ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemCount: locationController.addressTypeList.length,
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            locationController.setAddressTypeIndex(index);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: Dimensions.Width20,
                                vertical: Dimensions.Height15),
                            margin: EdgeInsets.only(right: Dimensions.Width10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(
                                  Dimensions.radiusSize20 / 4),
                              color: Theme.of(context).cardColor,
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey[200]!,
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                )
                              ],
                            ),
                            child: Icon(
                              index == 0
                                  ? Icons.work
                                  : index == 1
                                      ? Icons.home_filled
                                      : Icons.location_on,
                              color:
                                  locationController.addressTypeIndex == index
                                      ? AppColors.mainColor
                                      : Theme.of(context).disabledColor,
                            ),
                          ),
                        );
                      }),
                ),
              ),
              SizedBox(height: Dimensions.Height15),
              Padding(
                padding: EdgeInsets.only(left: Dimensions.Width20),
                child: BigText(text: "Delivery Address"),
              ),
              SizedBox(height: Dimensions.Height15),
              TextFieldWidget(
                textController: _addressController,
                hintText: "Your Address",
                icon: Icons.map,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.Height15),
              TextFieldWidget(
                textController: _contactPersonName,
                hintText: "Name",
                icon: Icons.person,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.Height15),
              TextFieldWidget(
                textController: _contactPersonNumber,
                hintText: "Phone Number",
                icon: Icons.phone,
                color: AppColors.mainColor,
              ),
              SizedBox(height: Dimensions.Height15),
              TextFieldWidget(
                textController: _locController,
                hintText: "Building/Block:123,Office/Dorm:123",
                icon: Icons.location_on_sharp,
                color: AppColors.mainColor,
              ),
            ]),
          );
        });
      }),
      bottomNavigationBar:
          GetBuilder<LocationController>(builder: (locationController) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: Dimensions.Height15 * 9,
              padding: EdgeInsets.only(
                  top: Dimensions.Height15,
                  bottom: Dimensions.Height15,
                  left: Dimensions.Width20,
                  right: Dimensions.Width20),
              decoration: BoxDecoration(
                color: AppColors.buttonBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radiusSize20 * 2),
                  topRight: Radius.circular(Dimensions.radiusSize20 * 2),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  //the add and remove button

                  //the add to cart Button(
                  GestureDetector(
                    onTap: () {
                      String loc = _locController.text.trim();

                      if (loc.isEmpty) {
                        showCustomSnackBar("Your Building & Office/Dorm number",
                            title: "Location");
                      } else if (loc.length < 6) {
                        showCustomSnackBar(
                            "Few characters short, insert your location",
                            title: "Loaction length");
                      } else {
                        AddressModel addressModel = AddressModel(
                          addressType: locationController.addressTypeList[
                              locationController.addressTypeIndex],
                          contactPersonName: _contactPersonName.text,
                          contactPersonNumber: _contactPersonNumber.text,
                          address: _addressController.text,
                          loc: _locController.text.toString(),
                          latitude:
                              locationController.position.latitude.toString(),
                          longitude:
                              locationController.position.longitude.toString(),
                        );
                        locationController
                            .addAddress(addressModel)
                            .then((response) {
                          if (response.isSuccess) {
                            // Get.toNamed(RouteHelper.getInital());

                            Get.snackbar(
                                "Address", "Address saved Successfully");
                          } else {
                            Get.snackbar("Address", "Couldn't save Address");
                          }
                        });
                      }
                      // Get.back();
                    },
                    child: Container(
                      padding: EdgeInsets.only(
                          top: Dimensions.Height20,
                          bottom: Dimensions.Height20,
                          left: Dimensions.Width20,
                          right: Dimensions.Width20),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius:
                            BorderRadius.circular(Dimensions.radiusSize20),
                      ),
                      child: BigText(
                        text: " Save Address ",
                        color: Colors.white,
                        size: 26,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        );
      }),
    );
  }
}
