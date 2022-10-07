import 'package:food_delivery/data/api/api_client.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:get/get.dart';

class ProductRepository extends GetxService {
  final ApiClient apiClient;

  ProductRepository({required this.apiClient});

  Future<Response> getProductsList() async {
    return await apiClient.getResponse(AppConstants.POPULAR_PRODUCT_URI);
  }

  Future<Response> getRecommendedProductsList() async {
    return await apiClient.getResponse(AppConstants.RECOMMENDED_PRODUCT_URI);
  }
}
