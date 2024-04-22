class Categories {
  late String id;

  late String category_name;

  late String code;

  Categories.fromJson(json) {
    id = json['id'];

    category_name =
        (json['category_name'] != null) ? json['category_name'] : ' ';

    code = (json['code'] != null) ? json['code'] : ' ';
  }
}
