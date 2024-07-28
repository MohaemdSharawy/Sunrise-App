class Product {
  late String id;

  late String product_name;

  late String description;

  late String size;

  late String time;

  late String price;

  late String brand_id;

  late String unit_id;

  late String barcode;

  late String q_limit;

  late String min_price;

  late String hot;

  late String vegan;

  late String allinc;

  late String logo;

  late String rank;

  late String enable_working_days;

  late String active;

  late String category_code;

  late String product_id;

  late String day;

  late String work;

  late String from_time;

  late String to_time;

  late List allergies;

  Product.fromJson(json) {
    id = json['id'];

    product_name = json['product_name'] ?? '';

    description = json['description'] ?? '';

    size = json['size'] ?? '';

    time = json['time'] ?? '';

    price = json['price'] ?? '';

    brand_id = json['brand_id'] ?? '';

    unit_id = json['unit_id'] ?? '';

    barcode = json['barcode'] ?? '';

    q_limit = json['q_limit'] ?? '';

    min_price = json['min_price'] ?? '';

    hot = json['hot'] ?? '';

    vegan = json['vegan'] ?? '';

    allinc = json['allinc'] ?? '';

    logo = json['logo'] ?? '';

    rank = json['rank'] ?? '';

    enable_working_days = json['enable_working_days'] ?? '';

    active = json['active'] ?? '';

    category_code = json['category_code'] ?? '';

    product_id = json['product_id'] ?? '';

    day = json['day'] ?? '';

    work = json['work'] ?? '';

    from_time = json['from_time'] ?? '';

    to_time = json['to_time'] ?? '';
    allergies = json['allergies'] ?? '';
  }
}
