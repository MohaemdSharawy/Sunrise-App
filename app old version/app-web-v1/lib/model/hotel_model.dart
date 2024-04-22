class Hotels {
  late String id;

  late String uid;

  late String hotel_name;

  late String company_id;

  late String group_id;

  late String code;

  late String location;

  late String info;

  late String server_ip;

  late String logo;

  late String image;

  late String interface;

  late String hotel_group;

  late String logo_white;

  late String survey_token;

  late String let_us_know_code;

  late String out_side;

  Hotels();

  Hotels.fromJson(Map<String, dynamic> json) {
    id = (json['id'] != null) ? json['id'] : '';

    uid = (json['uid'] != null) ? json['uid'] : '';

    hotel_name = (json['hotel_name'] != null) ? json['hotel_name'] : '';

    company_id = (json['company_id'] != null) ? json['company_id'] : '';

    group_id = (json['group_id'] != null) ? json['group_id'] : '';

    code = (json['code'] != null) ? json['code'] : '';

    location = (json['location'] != null) ? json['location'] : '';

    info = (json['info'] != null) ? json['info'] : '';

    server_ip = (json['server_ip'] != null) ? json['server_ip'] : '';

    logo = (json['logo'] != null) ? json['logo'] : '';

    image = (json['image'] != null) ? json['image'] : '';

    interface = (json['interface'] != null) ? json['interface'] : '';

    hotel_group = (json['hotel_group'] != null) ? json['hotel_group'] : '';

    logo_white = (json['logo_white'] != null) ? json['logo_white'] : '';

    survey_token = (json['survey_token'] != null) ? json['survey_token'] : '';

    let_us_know_code =
        (json['let_us_know_code'] != null) ? json['let_us_know_code'] : '';

    out_side = json['out_side'];
  }
}

class BackGroundImg {
  late String id;

  late String hid;

  late String home_screen;

  late String login_screen;

  late String weather_screen;

  late String dining_screen;

  late String wellness_screen;

  late String rate_screen;

  BackGroundImg.fromJson(json) {
    id = json['id'];

    hid = json['hid'];

    login_screen = json['login_screen'];

    home_screen = json['home_screen'];

    weather_screen = json['weather_screen'];

    dining_screen = json['dining_screen'];

    wellness_screen = json['wellness_screen'];

    rate_screen = json['rate_screen'];
  }

  get e => null;
}
