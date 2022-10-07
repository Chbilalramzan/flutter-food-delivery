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
import 'package:food_delivery/widgets/expandable_text.dart';
import 'package:get/get.dart';

class RecommendedFoodDetailScreen extends StatefulWidget {
  final int pageId;
  const RecommendedFoodDetailScreen({Key? key, required this.pageId})
      : super(key: key);

  @override
  State<RecommendedFoodDetailScreen> createState() =>
      _RecommendedFoodDetailScreenState();
}

class _RecommendedFoodDetailScreenState
    extends State<RecommendedFoodDetailScreen> {
  @override
  Widget build(BuildContext context) {
    var recommendedProduct =
        Get.find<HomeController>().recommendedProductsList[widget.pageId];
    Get.find<ProductsController>()
        .initState(Get.find<CartController>(), recommendedProduct);
    return Scaffold(
        backgroundColor: Colors.white,
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              automaticallyImplyLeading: false,
              toolbarHeight: 45,
              title: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                      onTap: () => Get.back(),
                      child: const AppIcon(
                        icon: Icons.arrow_back_ios,
                        backgroundColor: Colors.white,
                      )),
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
                            icon: Icons.shopping_cart_outlined,
                            backgroundColor: Colors.white,
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
                  // const AppIcon(icon: Icons.shopping_cart_outlined)
                ],
              ),
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(Dimensions.radius20),
                          topRight: Radius.circular(Dimensions.radius20))),
                  child: Center(
                      child: BigText(
                    text: recommendedProduct.name!,
                    size: Dimensions.font26,
                  )),
                ),
              ),
              pinned: true,
              backgroundColor: AppColors.yellowColor,
              expandedHeight: 300,
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network(
                  AppConstants.BASE_URL +
                      AppConstants.STORAGE_FOLDER +
                      recommendedProduct.img!,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        right: Dimensions.width20, left: Dimensions.width20),
                    child:
                        ExpandableText(text: recommendedProduct.description!),
                  ),
                ],
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<ProductsController>(
          builder: (productsController) => Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding: EdgeInsets.only(
                    left: Dimensions.width20 * 2.5,
                    right: Dimensions.width20 * 2.5,
                    top: Dimensions.height10,
                    bottom: Dimensions.height10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => productsController.setQuantity(false),
                      child: AppIcon(
                        backgroundColor: AppColors.mainColor,
                        icon: Icons.remove,
                        iconColor: Colors.white,
                        iconSize: Dimensions.iconSize24,
                      ),
                    ),
                    BigText(
                      text:
                          '\$ ${recommendedProduct.price!} * ${productsController.inCartItems}',
                      color: AppColors.mainBlackColor,
                      size: Dimensions.font26,
                    ),
                    InkWell(
                      onTap: () => productsController.setQuantity(true),
                      child: AppIcon(
                          backgroundColor: AppColors.mainColor,
                          icon: Icons.add,
                          iconColor: Colors.white,
                          iconSize: Dimensions.iconSize24),
                    ),
                  ],
                ),
              ),
              Container(
                height: Dimensions.bottomBarHeight120,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height30),
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
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: Colors.white),
                        child: const Icon(
                          Icons.favorite,
                          color: AppColors.mainColor,
                        )),
                    GestureDetector(
                      onTap: () =>
                          productsController.addItemInCart(recommendedProduct),
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: Dimensions.width20,
                            vertical: Dimensions.height20),
                        decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(Dimensions.radius20),
                            color: AppColors.mainColor),
                        child: BigText(
                          text:
                              '\$ ${productsController.inCartItems == 0 ? recommendedProduct.price! : recommendedProduct.price! * productsController.inCartItems} | add to cart',
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
