import 'package:food_delivery/controllers/cartController.dart';
import 'package:food_delivery/controllers/homeController.dart';
import 'package:food_delivery/controllers/productsController.dart';
import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/data/repository/product_repository.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

Future<void> init() async {
  // final sharedPreferences = await SharedPreferences.getInstance();

  // Get.lazyPut(() => sharedPreferences);

  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repositories
  Get.lazyPut(() => ProductRepository(apiClient: Get.find()));
  Get.lazyPut(() => CartRepository());

  //controllers

  Get.lazyPut(() => HomeController(productRepository: Get.find()));
  Get.put(ProductsController());
  Get.put(CartController());
}
