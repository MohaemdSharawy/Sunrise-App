class SpaCategories {
  late String id;

  late String category_name;

  late String code;

  late String printer_id;

  late String rank;

  late String logo;

  late String image;

  late String description;

  late String active;

  SpaCategories.fromJson(json) {
    id = json['id'];

    category_name =
        (json['category_name'] != null) ? json['category_name'] : '';

    code = (json['code'] != null) ? json['code'] : '';

    printer_id = (json['printer_id'] != null) ? json['printer_id'] : '';

    rank = (json['rank'] != null) ? json['rank'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';

    image = (json['image'] != null) ? json['image'] : '';

    description = (json['description'] != null) ? json['description'] : '';

    active = (json['active'] != null) ? json['active'] : '';
  }
}
