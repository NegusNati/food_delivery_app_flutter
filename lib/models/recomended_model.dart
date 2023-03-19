class Recomended {
  int? _totalSize;
  int? _typeId;
  int? _offset;
  late List<RecomendedProducts> _recomended;
  List<RecomendedProducts> get recomended => _recomended;

  Recomended(
      {required totalSize,
      required typeId,
      required offset,
      required recomended}) {
    _totalSize = totalSize;
    _typeId = typeId;
    _offset = offset;
    _recomended = recomended;
  }

  Recomended.fromJson(Map<String, dynamic> json) {
    _totalSize = json['total_size'];
    _typeId = json['type_id'];
    _offset = json['offset'];
    if (json['products'] != null) {
      _recomended = <RecomendedProducts>[];
      json['products'].forEach((v) {
        _recomended.add(RecomendedProducts.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total_size'] = _totalSize;
    data['type_id'] = _typeId;
    data['offset'] = _offset;
    if (_recomended != null) {
      data['products'] = _recomended.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RecomendedProducts {
  int? id;
  String? name;
  String? description;
  int? price;
  int? stars;
  String? img;
  String? location;
  String? createdAt;
  String? updatedAt;
  int? typeId;

  RecomendedProducts(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.stars,
      this.img,
      this.location,
      this.createdAt,
      this.updatedAt,
      this.typeId});

  RecomendedProducts.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    price = json['price'];
    stars = json['stars'];
    img = json['img'];
    location = json['location'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    typeId = json['type_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['price'] = price;
    data['stars'] = stars;
    data['img'] = img;
    data['location'] = location;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['type_id'] = typeId;
    return data;
  }
}
