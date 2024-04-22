import 'package:tucana/model/booking_type_model.dart';

class BookingTypeResponse {
  List<BookingType> booking_type = [];

  BookingTypeResponse.fromJson(json) {
    json['types']
        .forEach((data) => booking_type.add(BookingType.fromJson(data)));
  }
}
