class CategoryType {
  late String id;

  late String category_name;

  late String code;

  late String logo;

  late String image;

  late String description;

  late String? active_alert;

  CategoryType.fromJson(json) {
    id = json['id'];

    category_name =
        (json['category_name'] != null) ? json['category_name'] : ' ';

    code = (json['code'] != null) ? json['code'] : ' ';

    logo = (json['logo'] != null) ? json['logo'] : ' ';

    image = (json['image'] != null) ? json['image'] : ' ';

    description = (json['description'] != null) ? json['description'] : '';

    active_alert = json['active_alert'];
  }
}
