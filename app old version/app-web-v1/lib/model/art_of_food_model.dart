class ArtOfFoodModel {
  late String id;
  late String header;
  late String description;

  ArtOfFoodModel.fromJson(json) {
    id = json['id'];
    header = json['header'];
    description = json['description'];
  }
}

class ArtOfFoodRestaurantModel {
  ArtOfFoodRestaurantModel();

  late String id;
  late String restaurant_name;
  late String type;
  late String header;
  late String description;
  late String logo;
  late String white_logo;
  late String image;
  late String pdf_menu;

  ArtOfFoodRestaurantModel.fromJson(json) {
    id = json['id'];
    restaurant_name = json['restaurant_name'];
    type = json['type'];
    header = json['header'];
    description = json['description'];
    logo = (json['logo'] != null) ? json['logo'] : '';
    white_logo = (json['white_logo'] != null) ? json['white_logo'] : '';
    image = (json['image'] != null) ? json['image'] : '';
    pdf_menu = (json['pdf_menu'] != null) ? json['pdf_menu'] : '';
  }
}

class ArtOfFoodHotels {
  late String id;

  late String code;

  late String hotel_logo;

  ArtOfFoodHotels.fromJson(json) {
    id = json['id'];
    code = json['code'];
    hotel_logo = (json['hotel_logo'] != null) ? json['hotel_logo'] : '';
  }
}
