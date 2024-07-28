import 'package:sunrise_app_v2/models/hotel_model.dart';

class Offers{

  late int id;

  late String name;

  late String link;

  late String  image;

  late int price;

  late Hotels hotel;

  Offers.fromJson(json){
    id =  json['id'];

    name = json['name'];

    link = json['link'];

    image =  json['image'];

    price = json['price'];

    hotel = Hotels.fromJson( json['hotel']);

  }

}