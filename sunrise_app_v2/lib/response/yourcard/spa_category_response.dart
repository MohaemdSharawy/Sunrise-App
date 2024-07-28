import 'package:sunrise_app_v2/models/yourcard/spa_category_model.dart';

class SpaCategoriesResponse {
  List<SpaCategories> spa_categories = [];

  SpaCategoriesResponse.fromJson(json) {
    if (json != null) {
      json['categories']
          .forEach((data) => spa_categories.add(SpaCategories.fromJson(data)));
    }
  }
}
