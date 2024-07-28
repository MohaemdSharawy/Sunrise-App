class Destinations {
  late int id;

  late String name;

  late String country;

  late String image;

  Destinations();

  Destinations.fromJson(json) {
    id = json['id'];

    name = json['name'];

    country = json['country'];

    image = json['image'];
  }
}
