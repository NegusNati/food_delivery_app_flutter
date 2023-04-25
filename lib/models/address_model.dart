// ignore_for_file: public_member_api_docs, sort_constructors_first
class AddressModel {
  late int? _id;
  late String _addressType;
  late String? _contactPersonName;
  late String? _contactPersonNumber;

  late String _address;
  late String _latitude;
  late String _longtiude;
  AddressModel({
    id,
    required addressType,
    contactPersonName,
    contactPersonNumber,
    required address,
    required latitude,
    required longtiude,
  }) {
    _id = id;
    _addressType = addressType;
    _contactPersonName = contactPersonName;
    _contactPersonNumber = contactPersonNumber;
    _address = address;
    _latitude = latitude;
    _longtiude = longtiude;
  }

  String get address => _address;
  String get addressType => _addressType;
  String? get contactPersonName => _contactPersonName;
  String? get contactPersonNumber => _contactPersonNumber;

  AddressModel.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _addressType = json['address_type'] ?? "";
    _contactPersonName = json['contact_person_name'] ?? "";
    _contactPersonNumber = json['contact_person_number'] ?? "";
    _address = json['address'];
    _latitude = json['latitude'];
    _longtiude = json['longtiude'];
  }
}
