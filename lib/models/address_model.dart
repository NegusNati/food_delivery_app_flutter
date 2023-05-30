// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;
  late String? _loc;
  late String _address;
  late String _latitude;
  late String _longitude;
  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    loc,
    required address,
    required latitude,
    required longitude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _loc = loc;
    _address = address;
    _latitude = latitude;
    _longitude = longitude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;
  String? get loc => _loc;
  String? get latitude => _latitude;
  String? get longitude => _longitude;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? "";
    _contactPersonName = json['contact_person_name'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _loc = json['loc'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    data['id'] = _id;
    data['address_type'] = _addressType;
    data['contact_person_name'] = _contactPersonName;
    data['contact_person_number'] = _contactPersonNumber;
    data['loc'] = _loc;
    data['address'] = _address;
    data['longitude'] = _longitude;
    data['latitude'] = _latitude;

    return data;
  }
}
