class ProductCustomOption {
  late String id;

  late String product_id;

  late String custom_option_id;

  late String max;

  late String price;

  late String custom_option_name;

  late String type;

  late List answers;

  ProductCustomOption.fromJson(json) {
    id = json['id'];

    product_id = (json['product_id'] != null) ? json['product_id'] : '';

    custom_option_id =
        (json['custom_option_id'] != null) ? json['custom_option_id'] : '';

    custom_option_name =
        (json['custom_option_name'] != null) ? json['custom_option_name'] : '';

    max = (json['max'] != null) ? json['max'] : '';

    type = (json['type'] != null) ? json['type'] : '';

    price = (json['price'] != null) ? json['price'] : '';

    answers = (json['answers'] != null) ? json['answers'] : '';
  }
}
