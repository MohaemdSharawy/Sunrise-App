class Tables {
  late String id;

  late String table_name;

  late String capcity;

  late String rank;

  late String active;

  Tables.fromJson(json) {
    id = json['id'];

    table_name = json['table_name'] ?? ' ';

    capcity = json['capcity'] ?? ' ';

    rank = json['rank'] ?? ' ';

    active = json['active'] ?? ' ';
  }
}
