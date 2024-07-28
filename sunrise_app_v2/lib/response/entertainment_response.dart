import 'package:sunrise_app_v2/models/entertainment_model.dart';

class EntertainmentResponse {
  List<EntertainmentModel> entertainments = [];
  EntertainmentResponse.fromJson(json) {
    json['entertainments'].forEach(
        (data) => entertainments.add(EntertainmentModel.fromJson(data)));
  }
}
