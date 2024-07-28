class UserModel {
  late int id;

  late String name;

  late String email;

  late int checked_in;

  UserModel();
  UserModel.fromJson(json) {
    id = json['id'];

    name = json['name'];

    email = json['email'];

    checked_in = json['checked_in'];
  }
}
