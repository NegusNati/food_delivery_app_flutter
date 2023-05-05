import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:get/get.dart'

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
 CameraPosition _camersPosition = const CameraPosition(
    target: LatLng(8.2150, 37.8025), zoom: 17
  );
  late LatLng _initialPosition;

  void @override
  void initState() {
    super.initState();
    _isLogged = Get.find<AuthController>().userHaveLoggedIn();
    if(_isLogged && Get.find<UserController>().userModel==null){
      Get.find<UserController>().getUserInfo();
    }
    if( Get.find<LocationController>().addressList.isNotEmpty){
      _camersPosition = CameraPosition(target: LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),  double.parse(Get.find<LocationController>().getAddress['longtiude'])
      ));
      _initialPosition = LatLng(
        double.parse(Get.find<LocationController>().getAddress['latitude']),  double.parse(Get.find<LocationController>().getAddress['longtiude'])
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Address"),
        backgroundColor: Colors.green,

      ),
      body: Column(
        children: [
          
        
        ]
      )
    );
  }
}
