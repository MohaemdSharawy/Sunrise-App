class Brands {
  late int id;

  late String brand_name;

  Brands.fromJson(json) {
    id = json['id'];

    brand_name = json['brand_name'];
  }
}
