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

  late String allinc;

  late List allergies;

  late String extra_charge;

  Product.fromJson(json) {
    id = json['id'];

    product_name = (json['product_name'] != null) ? json['product_name'] : ' ';

    description = (json['description'] != null) ? json['description'] : ' ';

    size = (json['size'] != null) ? json['size'] : ' ';

    time = (json['time'] != null) ? json['time'] : ' ';

    price = (json['price'] != null) ? json['price'] : ' ';

    brand_id = (json['brand_id'] != null) ? json['brand_id'] : ' ';

    unit_id = (json['unit_id'] != null) ? json['unit_id'] : ' ';

    barcode = (json['barcode'] != null) ? json['barcode'] : ' ';

    q_limit = (json['q_limit'] != null) ? json['q_limit'] : ' ';

    min_price = (json['min_price'] != null) ? json['min_price'] : ' ';

    hot = (json['hot'] != null) ? json['hot'] : ' ';

    vegan = (json['vegan'] != null) ? json['vegan'] : ' ';

    logo = (json['logo'] != null) ? json['logo'] : ' ';

    rank = (json['rank'] != null) ? json['rank'] : ' ';

    enable_working_days = (json['enable_working_days'] != null)
        ? json['enable_working_days']
        : ' ';

    active = (json['active'] != null) ? json['active'] : ' ';

    category_code =
        (json['category_code'] != null) ? json['category_code'] : ' ';

    product_id = (json['product_id'] != null) ? json['product_id'] : ' ';

    day = (json['day'] != null) ? json['day'] : ' ';

    work = (json['work'] != null) ? json['work'] : ' ';

    from_time = (json['from_time'] != null) ? json['from_time'] : ' ';

    to_time = (json['to_time'] != null) ? json['to_time'] : ' ';

    allinc = (json['allinc'] != null) ? json['allinc'] : ' ';

    allergies = (json['allergies'] != null) ? json['allergies'] : [];

    extra_charge =  json['extra_charge'].toString();

    // if (json['allergies'] == null || json['allergies'].length) {
    //   json['allergies'] = [];
    // } else {
    //   json[]
    // }
  }
}
