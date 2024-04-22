import 'dart:convert';

import 'package:tucana/model/spa_model.dart';

class SpaResponse {
  List<Spa> spa = [];

  SpaResponse.fromJson(json) {
    // print(json);
    if (json != null) {
      json['spas'].forEach((data) => spa.add(Spa.fromJson(data)));
    }
  }
}

class SingleSpaResponse {
  List<Spa> spa = [];

  SingleSpaResponse.fromJson(json) {
    spa.add(Spa.fromJson(json['activity']));
  }
}

class SpaCategoriesResponse {
  List<SpaCategories> spa_categories = [];

  SpaCategoriesResponse.fromJson(json) {
    if (json != null) {
      json['categories']
          .forEach((data) => spa_categories.add(SpaCategories.fromJson(data)));
    }
  }
}

class SpaCategoryResponse {
  List<SpaCategories> spa_categories = [];

  SpaCategoryResponse.fromJson(json) {
    spa_categories.add(SpaCategories.fromJson(json['activity']));
  }
}

class SpaProductResponse {
  List<SpaProduct> spa_product = [];

  SpaProductResponse.fromJson(json) {
    if (json != null) {
      json['products']
          .forEach((data) => spa_product.add(SpaProduct.fromJson(data)));
    }
  }
}

class SingleSpaProductResponse {
  List<SpaProduct> spa_product = [];

  SingleSpaProductResponse.fromJson(json) {
    spa_product.add(SpaProduct.fromJson(json['product']));
  }
}

class GymResponse {
  List<Spa> gym = [];
  GymResponse.fromJson(json) {
    if (json != null) {
      json['gym'].forEach((data) => gym.add(Spa.fromJson(data)));
    }
  }
}
