class HotelInfo{

  late int id;

  late String content;

  List images = [];

  HotelInfo.fromJson(json){
    id = json['id'];

    content = json['trans_content'];

    json['info_images'].forEach((element) => images.add(element['image']) );

  }

}