import 'package:food_delivery/screens/Tabs/tabs.dart';
import 'package:food_delivery/screens/cart/cart_screen.dart';
import 'package:food_delivery/screens/details/food_detail_screen.dart';
import 'package:food_delivery/screens/details/recommended_food_details.dart';
import 'package:food_delivery/screens/home/home_screen.dart';
import 'package:food_delivery/screens/splash/splash_screen.dart';
import 'package:get/get.dart';

class RouteHelper {
  //Routes Name

  static const String splashScreen = '/Splash-Screen';
  static const String initial = '/';
  static const String foodDetailScreen = '/popular-food-detail-screen';
  static const String recommendedFoodDetailScreen =
      '/recommended-food-detail-screen';
  static const String cartScreen = '/cart-screen';

  //if you want to pass parameter from previous to your next route
  static String getSplashScreen() => splashScreen;
  static String getInitial() => initial;
  static String getFoodDetailScreen(int pageId) =>
      '$foodDetailScreen?pageId=$pageId';
  static String getRecommendedFoodDetailScreen(int pageId) =>
      '$recommendedFoodDetailScreen?pageId=$pageId';
  static String getCartScreen() => cartScreen;

// All Pages or Screens
  static List<GetPage> routePages = [
    GetPage(name: splashScreen, page: () => const SplashScreen()),
    GetPage(name: initial, page: () => const TabScreen()),
    GetPage(
        name: foodDetailScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          return FoodDetailScreen(
            pageId: int.parse(pageId!),
          );
        },
        transition: Transition.fadeIn),
    GetPage(
        name: recommendedFoodDetailScreen,
        page: () {
          var pageId = Get.parameters['pageId'];
          return RecommendedFoodDetailScreen(pageId: int.parse(pageId!));
        },
        transition: Transition.fadeIn),
    GetPage(
        name: cartScreen,
        page: () {
          return const CartScreen();
        },
        transition: Transition.fadeIn)
  ];
}
