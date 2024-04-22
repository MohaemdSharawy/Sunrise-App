import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tucana/controller/categories_controller.dart';
import 'package:tucana/controller/product_controller.dart';

class MealScreen extends StatefulWidget {
  String restaurant_code;
  String meal_id;
  String type_id;
  String day_name;
  MealScreen({
    required this.restaurant_code,
    required this.meal_id,
    required this.type_id,
    required this.day_name,
    super.key,
  });

  @override
  State<MealScreen> createState() => _MealScreenState();
}

class _MealScreenState extends State<MealScreen> {
  final categoriesController = Get.put(CategoriesController());
  final productController = Get.put(ProductController());
  int selectedTile = -1;

  _getData() async {
    await categoriesController.mealCategory(
      restaurant_code: widget.restaurant_code,
      type_id: widget.type_id,
      meal_id: widget.meal_id,
      day: widget.day_name,
    );
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      categoriesController.meal_category_loaded.value = false;
      _getData();
      print(widget.day_name);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (categoriesController.meal_category_loaded.value == true)
          ? mainBody()
          : Center(
              child: CircularProgressIndicator(),
            );
    });
  }

  Widget mainBody() {
    return ListView.builder(
      key: Key(selectedTile.toString()),
      // physics: NeverScrollableScrollPhysics(),
      itemCount: categoriesController.meal_category.length,
      itemBuilder: (context, index) {
        return Container(
          padding: EdgeInsets.only(left: 15, right: 15),
          child: Card(
            color: Colors.grey.withOpacity(0.5),
            child: ExpansionTile(
              initiallyExpanded:
                  index == categoriesController.selectedTile_meal,
              onExpansionChanged: (newState) async {
                if (newState)
                  setState(() {
                    selectedTile = categoriesController.selectedTile_meal;
                    productController.meal_product(
                      category_id: categoriesController.meal_category[index].id,
                      meal_id: widget.meal_id,
                      day: widget.day_name,
                    );
                  });
                else
                  setState(() {
                    // productController.categoryScreenHight.value =
                    //     widget.categories.length * 85.0;
                    categoriesController.selectedTile_meal = -1;
                  });
              },
              title: Align(
                alignment: Alignment.center,
                child: Text(
                  categoriesController.meal_category[index].category_name,
                  style: TextStyle(
                      fontSize: 15,
                      fontFamily: 'Sans-bold',
                      color: Colors.white),
                ),
              ),
              children: [buildProductList()],
            ),
          ),
        );
      },
    );
  }

  Widget buildProductList() {
    return Obx(
      () {
        return (productController.isLoaded.value == true)
            ? ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: productController.product.length,
                itemBuilder: (context, index) {
                  // getProduct(index);

                  return Container(
                    padding: EdgeInsets.only(bottom: 15),
                    color: Colors.transparent.withOpacity(
                      0.2,
                    ),
                    // height: 180,
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,
                            '/dinning-product-details/${productController.product[index].id}');
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            children: [
                              (productController.product[index].logo != '')
                                  ? Stack(
                                      children: [
                                        (productController
                                                    .product[index].logo !=
                                                '')
                                            ? Container(
                                                width: 120,
                                                margin: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          60.0),
                                                  child: Image.network(
                                                    'https://yourcart.sunrise-resorts.com/assets/uploads/products/${productController.product[index].logo}',
                                                    height: 110,
                                                    width: 110,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              )
                                            : Container(
                                                width: 120,
                                                margin: EdgeInsets.only(
                                                    left: 20, bottom: 20),
                                                child: Image.asset(
                                                  'assets/no-image-icon-4.png',
                                                  height: 150,
                                                  width: 100,
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                        Positioned(
                                          right: 0,
                                          top: 5,
                                          // right: 10,
                                          child: Column(
                                            children: [
                                              (productController
                                                          .product[index].hot ==
                                                      "1")
                                                  ? Container(
                                                      color: Colors.red,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .local_fire_department_rounded),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                              (productController.product[index]
                                                          .vegan ==
                                                      "1")
                                                  ? Container(
                                                      color: Colors.green,
                                                      child: Row(
                                                        children: [
                                                          Icon(Icons
                                                              .grass_outlined),
                                                        ],
                                                      ),
                                                    )
                                                  : Container(),
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  : Center(
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 15),
                                        child: Container(
                                          margin: EdgeInsets.only(
                                              left: 20, bottom: 20, top: 10),
                                          child: Image.asset(
                                            "assets/no-image-icon-4.png",
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fill,
                                          ),
                                        ),
                                      ),
                                    ),
                              SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                        productController
                                            .product[index].product_name,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                            fontFamily: 'Sans-bold'),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 200,
                                      child: Text(
                                          productController
                                              .product[index].description,
                                          maxLines: 6,
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 10),
                                          overflow: TextOverflow.ellipsis),
                                    ),
                                    (productController.product[index].allinc ==
                                            "1")
                                        ? Card(
                                            shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              color: Color.fromARGB(
                                                  255, 190, 146, 109),
                                              child: Text(
                                                'All Inclusive',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                         (productController
                                                .product[index].extra_charge ==
                                            "1")
                                        ? Card(
                                            shape: BeveledRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10.0),
                                            ),
                                            child: Container(
                                              padding: EdgeInsets.all(4),
                                              color: Color.fromARGB(
                                                  255, 190, 146, 109),
                                              child: Text(
                                                'Extra Charge',
                                                style: TextStyle(
                                                    color: Colors.white),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Wrap(
                                        children: [
                                          for (int i = 0;
                                              i <
                                                  productController
                                                      .product[index]
                                                      .allergies
                                                      .length;
                                              i++)
                                            ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60.0),
                                              child: Image.network(
                                                'https://yourcart.sunrise-resorts.com/assets/uploads/allergies/${productController.product[index].allergies[i]['allergies_logo']}',
                                                height: 30,
                                                width: 30,
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${productController.restaurant[0].currency}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Sans-bold'),
                                        ),

                                        SizedBox(
                                          width: 5,
                                        ),

                                        Text(
                                          '${productController.product[index].price}',
                                          style: TextStyle(
                                              fontSize: 14,
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: 'Sans-bold'),
                                        ),
                                        SizedBox(
                                          width: 35,
                                        ),
                                        // (GetStorage().read('room_num') != '')
                                      ],
                                    ),
                                    SizedBox(
                                      height: 5,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              )
            : Center(
                child: CircularProgressIndicator(),
              );
      },
    );
  }
}
