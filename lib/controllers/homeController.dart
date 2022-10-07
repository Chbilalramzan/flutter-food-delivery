import 'package:food_delivery/data/repository/product_repository.dart';
import 'package:food_delivery/models/products.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  final ProductRepository productRepository;

  HomeController({required this.productRepository});

  //variables, states
  List<dynamic> _popularProducts = [];
  bool _loading = true;
  bool _loadingRecommended = true;
  List<dynamic> _recommendedProducts = [];

// getters
  List<dynamic> get popularProductsList => _popularProducts;
  bool get loading => _loading;
  List<dynamic> get recommendedProductsList => _recommendedProducts;
  bool get loadingRecommended => _loadingRecommended;

  Future<void> productsList() async {
    Response response = await productRepository.getProductsList();
    if (response.statusCode == 200) {
      _popularProducts = [];
      _popularProducts.addAll(Product.fromJson(response.body).products as List);
      _loading = false;
      update();
    } else {}
  }

  Future<void> getRecommendedProductsList() async {
    Response response = await productRepository.getRecommendedProductsList();
    if (response.statusCode == 200) {
      _recommendedProducts = [];
      _recommendedProducts
          .addAll(Product.fromJson(response.body).products as List);
      _loadingRecommended = false;
      update();
    } else {}
  }
}
