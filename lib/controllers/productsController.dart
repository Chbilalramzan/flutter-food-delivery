import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/cartController.dart';
import 'package:food_delivery/data/repository/product_repository.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/products.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class ProductsController extends GetxController {
  ProductsController();
  //variables, states
  int _quantity = 0;
  int _inCartItems = 0;
  late CartController _cartController;

// getters
  int get quantity => _quantity;
  int get inCartItems => _inCartItems + _quantity;

  void initState(CartController cartController, ProductModel productModel) {
    _quantity = 0;
    _inCartItems = 0;
    _cartController = cartController;
    var exist = false;
    exist = _cartController.existInCart(productModel);

    if (exist) {
      _inCartItems = _cartController.getQuantity(productModel);
    }
  }

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }

  int checkQuantity(int quantity) {
    if ((_inCartItems + quantity) < 0) {
      snackBar('Item Count', 'You cannot reduce more !');
      if (_inCartItems > 0) {
        _quantity = -_inCartItems;
        return _quantity;
      }
      return 0;
    } else if ((_inCartItems + quantity) > 20) {
      snackBar('Item Count', 'You cannot add more !');
      return 20;
    } else {
      return quantity;
    }
  }

  addItemInCart(ProductModel productModel) {
    _cartController.addItemToCart(productModel, quantity);
    _quantity = 0;
    _inCartItems = _cartController.getQuantity(productModel);
    update();
  }

  int get totalItems {
    return _cartController.totalItems;
  }

  List<CartModel> get getCartItem {
    return _cartController.getCartItem;
  }

  snackBar(title, message) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
  }
}
