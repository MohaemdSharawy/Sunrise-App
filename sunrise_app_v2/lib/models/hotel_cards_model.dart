class HotelCard{

  late int id;

  late String name;

  late String image;

  late String icon;

  late String link;

  HotelCard.fromJson(json){
    
    id = json['id'];

    image = json['image'];

    name = json['card']['type_name'];

    icon = json['card']['type_icon'];
    
    link =  json['card']['type_route'] ?? '';

  }

}