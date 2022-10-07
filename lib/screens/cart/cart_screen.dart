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
import 'package:food_delivery/widgets/small_text.dart';
import 'package:get/get.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Positioned(
              left: Dimensions.width20,
              right: Dimensions.width20,
              top: Dimensions.height45,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Get.back(),
                    child: AppIcon(
                      icon: Icons.arrow_back_ios,
                      iconColor: AppColors.textColor,
                      iconSize: Dimensions.iconSize20,
                      backgroundColor: Colors.white,
                    ),
                  ),
                  BigText(
                    text: 'My Cart',
                    size: 20,
                  ),
                  const SizedBox(
                    width: 20,
                  )
                ],
              )),
          Positioned(
            bottom: 0,
            right: 0,
            left: 0,
            top: Dimensions.screenHeight * 0.115,
            child: Container(
              padding: EdgeInsets.only(
                  left: Dimensions.width20,
                  right: Dimensions.width20,
                  top: Dimensions.height20),
              decoration: BoxDecoration(
                color: AppColors.greyBackgroundColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius40),
                  topRight: Radius.circular(Dimensions.radius40),
                ),
              ),
              child: MediaQuery.removePadding(
                  context: context,
                  removeTop: true,
                  child: GetBuilder<CartController>(builder: (cartController) {
                    var _cartList = cartController.getCartItem;
                    return ListView.builder(
                      itemCount: cartController.getCartItem.length,
                      itemBuilder: (_, index) => GestureDetector(
                        onTap: () {
                          var popularProductIndex = Get.find<HomeController>()
                              .popularProductsList
                              .indexOf(_cartList[index].product!);
                          if (popularProductIndex >= 0) {
                            Get.toNamed(RouteHelper.getFoodDetailScreen(
                                popularProductIndex));
                          } else {
                            var recommendedProductIndex =
                                Get.find<HomeController>()
                                    .recommendedProductsList
                                    .indexOf(_cartList[index].product!);
                            Get.toNamed(
                                RouteHelper.getRecommendedFoodDetailScreen(
                                    recommendedProductIndex));
                          }
                        },
                        child: Container(
                          padding: EdgeInsets.all(Dimensions.height10),
                          margin: EdgeInsets.only(bottom: Dimensions.height10),
                          height: Dimensions.height20 * 5,
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.all(
                              Radius.circular(Dimensions.radius20),
                            ),
                          ),
                          child: Row(
                            children: [
                              Container(
                                width: Dimensions.height20 * 5,
                                height: Dimensions.height20 * 5,
                                decoration: BoxDecoration(
                                    color: AppColors.mainColor,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius15),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                            AppConstants.BASE_URL +
                                                AppConstants.STORAGE_FOLDER +
                                                cartController
                                                    .getCartItem[index].img!))),
                              ),
                              SizedBox(
                                width: Dimensions.width10,
                              ),
                              Expanded(
                                child: SizedBox(
                                  height: Dimensions.height20 * 5,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      BigText(
                                        size: 16,
                                        text: cartController
                                            .getCartItem[index].name!,
                                        color: AppColors.titleColor,
                                      ),
                                      Row(
                                        children: [
                                          Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              BigText(
                                                text: "total = ",
                                                size: 18,
                                              ),
                                              SmallText(
                                                  size: 16,
                                                  color: AppColors.mainColor,
                                                  text:
                                                      '\$ ${cartController.getCartItem[index].price! * cartController.getCartItem[index].quantity!}'),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radius20),
                                    color: Colors.white),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    InkWell(
                                      onTap: (() => {
                                            cartController.addItemToCart(
                                                cartController
                                                    .getCartItem[index]
                                                    .product!,
                                                -1)
                                          }),
                                      child: AppIcon(
                                          icon: Icons.remove,
                                          size: Dimensions.height20,
                                          backgroundColor: Colors.redAccent,
                                          iconSize: Dimensions.iconSize16,
                                          iconColor: Colors.white),
                                    ),
                                    SizedBox(
                                      width: Dimensions.width10 / 5,
                                    ),
                                    BigText(
                                        size: 16,
                                        text: cartController
                                            .getCartItem[index].quantity!
                                            .toString()),
                                    SizedBox(
                                      width: Dimensions.width10 / 5,
                                    ),
                                    InkWell(
                                      onTap: () => {
                                        cartController.addItemToCart(
                                            cartController
                                                .getCartItem[index].product!,
                                            1)
                                      },
                                      child: AppIcon(
                                        size: Dimensions.height20,
                                        icon: Icons.add,
                                        backgroundColor: AppColors.mainColor,
                                        iconSize: Dimensions.iconSize16,
                                        iconColor: Colors.white,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  })),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: GetBuilder<CartController>(
              builder: (cartController) => Container(
                height: Dimensions.bottomBarHeight120,
                padding: EdgeInsets.symmetric(
                    horizontal: Dimensions.width20,
                    vertical: Dimensions.height30),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(Dimensions.radius20 * 2),
                        topRight: Radius.circular(Dimensions.radius20 * 2))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SmallText(
                            text: '\$ ',
                            size: 16,
                          ),
                          BigText(
                            text: '${cartController.totalPrice}',
                            size: 32,
                          )
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.width20,
                          vertical: Dimensions.height20),
                      decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(Dimensions.radius20),
                          color: AppColors.mainColor),
                      child: InkWell(
                        onTap: () => {},
                        child: Row(
                          children: [
                            const AppIcon(
                              backgroundColor: Colors.transparent,
                              icon: Icons.shopping_cart_outlined,
                              iconSize: 20,
                              iconColor: Colors.white,
                            ),
                            BigText(
                              text: ' | Check Out',
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
