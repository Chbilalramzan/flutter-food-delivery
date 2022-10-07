import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cartController.dart';
import 'package:food_delivery/controllers/homeController.dart';
import 'package:food_delivery/controllers/productsController.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/app_constants.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';
import 'package:food_delivery/widgets/big_text.dart';
import 'package:food_delivery/widgets/components/food_specifications.dart';
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:food_delivery/widgets/icon_and_text.dart';
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class FoodDetailScreen extends StatelessWidget {
  final int pageId;
  const FoodDetailScreen({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var product = Get.find<HomeController>().popularProductsList[pageId];
    Get.find<ProductsController>()
        .initState(Get.find<CartController>(), product);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: 0,
              right: 0,
              child: Container(
                width: double.maxFinite,
                height: Dimensions.pageViewFoodDetailImage,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(AppConstants.BASE_URL +
                            AppConstants.STORAGE_FOLDER +
                            product.img!))),
              )),
          Positioned(
              top: Dimensions.height45,
              left: Dimensions.width20,
              right: Dimensions.width20,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: const AppIcon(
                      backgroundColor: Colors.white,
                      icon: Icons.arrow_back_ios,
                      iconSize: 20,
                    ),
                  ),
                  GetBuilder<ProductsController>(
                    builder: (productsController) => GestureDetector(
                      onTap: () {
                        if (productsController.totalItems >= 1) {
                          Get.toNamed(RouteHelper.getCartScreen());
                        }
                      },
                      child: Stack(
                        children: [
                          const AppIcon(
                            backgroundColor: Colors.white,
                            icon: Icons.shopping_cart_outlined,
                            iconSize: 20,
                          ),
                          productsController.totalItems >= 1
                              ? Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    width: Dimensions.width20,
                                    height: Dimensions.height20,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(
                                            Dimensions.radius20),
                                        color: AppColors.mainColor),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: BigText(
                                        size: 12,
                                        text: Get.find<ProductsController>()
                                            .totalItems
                                            .toString(),
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                )
                              : Container()
                        ],
                      ),
                    ),
                  ),
                ],
              )),
          Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              top: Dimensions.pageViewFoodDetailImage - 30,
              child: Container(
                  padding: EdgeInsets.only(
                      left: Dimensions.width20,
                      right: Dimensions.width20,
                      top: Dimensions.height20),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                          topRight: Radius.circular(Dimensions.radius20),
                          topLeft: Radius.circular(Dimensions.radius20)),
                      color: Colors.white),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FoodSpecifications(
                        text: product.name!,
                      ),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      BigText(text: "Introduce"),
                      SizedBox(
                        height: Dimensions.height20,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          child: ExpandableText(text: product.description!),
                        ),
                      )
                    ],
                  )))
        ],
      ),
      bottomNavigationBar: GetBuilder<ProductsController>(
        builder: (productController) => Container(
          height: Dimensions.bottomBarHeight120,
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.width20, vertical: Dimensions.height30),
          decoration: BoxDecoration(
              color: AppColors.buttonBackgroundColor,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20 * 2),
                  topRight: Radius.circular(Dimensions.radius20 * 2))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: (() => productController.setQuantity(false)),
                      child: const Icon(
                        Icons.remove,
                        color: AppColors.signColor,
                      ),
                    ),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    BigText(text: productController.inCartItems.toString()),
                    SizedBox(
                      width: Dimensions.width10 / 2,
                    ),
                    InkWell(
                      onTap: () => productController.setQuantity(true),
                      child: const Icon(
                        Icons.add,
                        color: AppColors.signColor,
                      ),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor),
                child: InkWell(
                  onTap: () => productController.addItemInCart(product),
                  child: BigText(
                    text:
                        '\$ ${productController.inCartItems == 0 ? product.price! : product.price! * productController.inCartItems} | add to cart',
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
