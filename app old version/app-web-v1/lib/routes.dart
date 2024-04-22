import 'dart:html';

import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:tucana/screens/art_of_food.dart';
import 'package:tucana/screens/art_of_food_view.dart';
import 'package:tucana/screens/category_screen.dart';
import 'package:tucana/screens/cruises.dart';
import 'package:tucana/screens/dining_screen.dart';
import 'package:tucana/screens/history_scrren.dart';
import 'package:tucana/screens/home_screen.dart';
import 'package:tucana/screens/login_confrimation.dart';
import 'package:tucana/screens/login_screen.dart';
import 'package:tucana/screens/main_screen.dart';
import 'package:tucana/screens/my_order.dart';
import 'package:tucana/screens/pages/dining/bar_screen.dart';
import 'package:tucana/screens/pages/dining/book_restaurnat_list.dart';
import 'package:tucana/screens/pages/dining/booking_screen.dart';
import 'package:tucana/screens/pages/dining/RestaurantCategoryByType.dart';
import 'package:tucana/screens/pages/dining/new_booking.dart';
import 'package:tucana/screens/pages/dining/product_details.dart';
import 'package:tucana/screens/pages/dining/restaurant_info.dart';
import 'package:tucana/screens/pages/dining/restaurant_screen.dart';
import 'package:tucana/screens/pages/dining/survey_scrren.dart';
import 'package:tucana/screens/pages/hotels/city_guid.dart';
import 'package:tucana/screens/pages/hotels/entertainment.dart';
import 'package:tucana/screens/pages/hotels/hotel_info.dart';
import 'package:tucana/screens/pages/hotels/hotel_map.dart';
import 'package:tucana/screens/pages/hotels/tv_guide.dart';
import 'package:tucana/screens/pages/letusKnow.dart';
import 'package:tucana/screens/pages/wellness/gem_screen.dart';
import 'package:tucana/screens/pages/wellness/spa_booking_screen.dart';
import 'package:tucana/screens/pages/wellness/spa_categories_screen.dart';
import 'package:tucana/screens/pages/wellness/spa_procut_details_screend.dart';
import 'package:tucana/screens/pages/wellness/spa_product.dart';
import 'package:tucana/screens/pages/wellness/spa_screen.dart';
import 'package:tucana/screens/posh_club.dart';
import 'package:tucana/screens/posh_club_general.dart';
import 'package:tucana/screens/product_screen.dart';
import 'package:tucana/screens/rating_screen.dart';
import 'package:tucana/screens/splash_screen.dart';
import 'package:tucana/screens/start_screen.dart';
import 'package:tucana/screens/ticket_history.dart';
import 'package:tucana/screens/ticket_screen.dart';
import 'package:tucana/screens/video.dart';
import 'package:tucana/screens/weather_screen.dart';
import 'package:tucana/screens/welcome_screen.dart';
import 'package:tucana/screens/wellness_screen.dart';

class Flurorouter {
  static final FluroRouter router = FluroRouter();

  static Handler video = Handler(
    handlerFunc: (context, params) => VideoPlayerWidget(
      video: params['video']![0],
    ),
  );

  static Handler login_confirmation = Handler(
    handlerFunc: (context, params) => LoginConfirmation(
      confirmation: params['confirmation']![0],
      h_id: params['h_id']![0],
    ),
  );

  static Handler startScreen = Handler(
    handlerFunc: ((context, parameters) => StartScreen()),
  );

  static Handler resorts = Handler(
    handlerFunc: ((context, parameters) => WelcomeScreen()),
  );
  static Handler cruises = Handler(
    handlerFunc: ((context, parameters) => CruisesScreen()),
  );
  static Handler splash_screen = Handler(
    handlerFunc: ((context, parameters) => SplashScreen()),
  );
  static Handler login_screen = Handler(
    handlerFunc: (context, params) => LoginScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler home_screen = Handler(
    handlerFunc: (context, params) => MainScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler posh_club = Handler(
    handlerFunc: (context, params) => PoshClubScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler main_dinning = Handler(
    handlerFunc: (context, params) => DiningScreen(
      hotel_id: params['h_id']![0],
    ),
  );
  static Handler dinning = Handler(
    handlerFunc: (context, params) => RestaurantScreen(
      hotel_id: params['h_id']![0],
    ),
  );

  static Handler category = Handler(
    handlerFunc: (context, params) => CategoriesScreen(
      // h_id: params['h_id']![0],
      restaurant_code: params['rest_code']![0],
    ),
  );

  static Handler product = Handler(
    handlerFunc: (context, params) => ProductScreen(
      // restaurant_id: params['rest_code']![0],
      // h_id: params['h_id']![0],
      category_id: params['category_id']![0],
    ),
  );

  static Handler rating = Handler(
    handlerFunc: (context, params) => RatingScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler weather = Handler(
    handlerFunc: (context, params) => WeatherScreen(
      h_id: params['h_id']![0],
      city: params['city']![0],
    ),
  );
  static Handler wellness = Handler(
    handlerFunc: (context, params) => WellnessScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler spa = Handler(
    handlerFunc: (context, params) => SpaScreen(
      h_code: params['h_code']![0],
    ),
  );
  static Handler spa_category = Handler(
    handlerFunc: (context, params) => SpaCategories(
      category_code: params['category_code']![0],
    ),
  );
  static Handler spa_product = Handler(
    handlerFunc: (context, params) => SpaProductScreen(
      category_id: params['category_id']![0],
    ),
  );

  static Handler spa_product_details = Handler(
    handlerFunc: (context, params) => SpaProductDetails(
      product_id: params['product_id']![0],
    ),
  );

  static Handler product_details = Handler(
    handlerFunc: (context, params) => DiningProductDetails(
      product_id: params['product_id']![0],
    ),
  );
  static Handler bars = Handler(
    handlerFunc: (context, params) => BarScreen(
      hotel_id: params['h_id']![0],
    ),
  );

  // static Handler restaurant_booking = Handler(
  //   handlerFunc: (context, params) => BookingScreen(
  //     restaurant_code: params['res_code']![0],
  //   ),
  // );
  static Handler restaurant_booking = Handler(
    handlerFunc: (context, params) => BookingScreenNew(
      res_code: params['res_code']![0],
    ),
  );

  static Handler activity_booking = Handler(
    handlerFunc: (context, params) => BookingSpaScreen(
      product_id: params['product_id']![0],
    ),
  );

  static Handler my_order = Handler(
    handlerFunc: (context, params) => MyOrderScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler rate = Handler(
    handlerFunc: (context, params) => RatingScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler hotel_info = Handler(
    handlerFunc: (context, params) => HotelInfoScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler hotel_map = Handler(
    handlerFunc: (context, params) => HotelMapScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler city_guide = Handler(
    handlerFunc: (context, params) => CityGuideScreen(
      h_id: params['h_id']![0],
    ),
  );
  static Handler tv_guide = Handler(
    handlerFunc: (context, params) => TvGuideScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler entertainment = Handler(
    handlerFunc: (context, params) => EntertainmentScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler restaurant_info = Handler(
    handlerFunc: (context, params) => RestaurantInfoScreen(
      restaurant_code: params['rest_code']![0],
    ),
  );

  static Handler gym = Handler(
    handlerFunc: (context, params) => GemScreen(
      h_code: params['h_code']![0],
    ),
  );

  static Handler restaurantCategoryByType = Handler(
    handlerFunc: (context, params) => RestaurantCategoryByType(
      restaurant_code: params['restaurant_code']![0],
      type_id: params['type_id']![0],
    ),
  );

  static Handler ticket = Handler(
    handlerFunc: (context, params) => TicketScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler ticketHistory = Handler(
    handlerFunc: (context, params) => TicketHistory(
      h_id: params['h_id']![0],
    ),
  );

  static Handler history = Handler(
    handlerFunc: (context, params) => HistoryScreen(
      h_id: params['h_id']![0],
    ),
  );

  static Handler rate_restaurant = Handler(
    handlerFunc: (context, params) => SurveyScreen(
      rest_code: params['rest_code']![0],
    ),
  );

  static Handler let_us_know = Handler(
    handlerFunc: (context, params) => LetUsKnowScreen(
      hotel_id: params['hotel_id']![0],
    ),
  );

  static Handler book_restaurant_list = Handler(
    handlerFunc: (context, params) => BookingRestaurantList(
      hotel_id: params['hotel_id']![0],
    ),
  );

  static Handler posh_club_general = Handler(
    handlerFunc: (context, params) => PoshClubGeneral(),
  );

  static Handler art_of_food = Handler(
    handlerFunc: (context, params) => ArtOfFood(),
  );

  static Handler art_of_food_view = Handler(
    handlerFunc: (context, params) => ArtOfFoodView(
      art_id: params['art_id']![0],
    ),
  );
  // // lets create for two parameters tooo...
  // static Handler _mainHandler2 = Handler(
  //     handlerFunc: (BuildContext context, Map<String, dynamic> params) =>
  //         LandingPage(page: params['name'][0],extra: params['extra'][0],));

  // ok its all set now .....
  // now lets have a handler for passing parameter tooo....

  static void setupRouter() {
    router.define(
      '/',
      handler: splash_screen,
    );
    router.define(
      '/video/:video',
      handler: video,
    );
    router.define(
      '/login_confirmation/:h_id/:confirmation',
      handler: login_confirmation,
    );
    router.define(
      '/hotels',
      handler: startScreen,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/resorts',
      handler: resorts,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/cruises',
      handler: cruises,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/login/:h_id',
      handler: login_screen,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/home/:h_id',
      handler: home_screen,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/posh_club/:h_id',
      handler: posh_club,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/dining/:h_id',
      handler: main_dinning,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/restaurant/:h_id',
      handler: dinning,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/categories/:rest_code/',
      handler: category,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/categories/:rest_code',
      handler: category,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/category-products/:category_id',
      handler: product,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/category-products/:category_id',
      handler: product,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/rate/:h_id',
      handler: rating,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/weather/:h_id/:city',
      handler: weather,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/wellness/:h_id',
      handler: wellness,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/spa/:h_code',
      handler: spa,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/activities/:category_code',
      handler: spa_category,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/activities/:category_code/',
      handler: spa_category,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/activity-products/:category_id',
      handler: spa_product,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/activity-product-details/:product_id',
      handler: spa_product_details,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/dinning-product-details/:product_id',
      handler: product_details,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/bars/:h_id',
      handler: bars,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/book-restaurant/:res_code',
      handler: restaurant_booking,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/book-activity/:product_id',
      handler: activity_booking,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/my-orders/:h_id',
      handler: my_order,
      transitionType: TransitionType.fadeIn,
    );

    // router.define(
    //   '/weather/:h_id/:city_name',
    //   handler: rate,
    //   transitionType: TransitionType.fadeIn,
    // );
    router.define(
      '/rate/:h_id',
      handler: rate,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/hotel_info/:h_id',
      handler: hotel_info,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/hotel_map/:h_id',
      handler: hotel_map,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/city_guide/:h_id',
      handler: city_guide,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/tv_guide/:h_id',
      handler: tv_guide,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/entertainment/:h_id',
      handler: entertainment,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/restaurant_info/:rest_code',
      handler: restaurant_info,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/gym/:h_code',
      handler: gym,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/restaurant_category_by_type/:restaurant_code/:type_id',
      handler: restaurantCategoryByType,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/ticket/:h_id',
      handler: ticket,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/history/:h_id',
      handler: history,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/restaurant_survey/:rest_code',
      handler: rate_restaurant,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/let_us_know/:hotel_id',
      handler: let_us_know,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/book_restaurant_list/:hotel_id',
      handler: book_restaurant_list,
      transitionType: TransitionType.fadeIn,
    );

    router.define(
      '/g_posh_club',
      handler: posh_club_general,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/art_of_food',
      handler: art_of_food,
      transitionType: TransitionType.fadeIn,
    );
    router.define(
      '/art_of_food/view/:art_id',
      handler: art_of_food_view,
      transitionType: TransitionType.fadeIn,
    );

    // router.define(
    //   '/main/:name/:extra',
    //   handler: _mainHandler2,
    //   transitionType: TransitionType.fadeIn,
    // );
  }
}
