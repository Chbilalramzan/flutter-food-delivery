import 'package:flutter/material.dart';
import 'package:food_delivery/data/repository/cart_repository.dart';
import 'package:food_delivery/models/cart.dart';
import 'package:food_delivery/models/products.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  // final CartRepository cartRepository;

  // CartController({required this.cartRepository});

  Map<int, CartModel> _items = {};
  Map<int, CartModel> get items => _items;

  addItemToCart(ProductModel product, int quantity) {
    var totalQuantity = 0;
    if (_items.containsKey(product.id)) {
      _items.update(product.id!, (value) {
        totalQuantity = value.quantity! + quantity;
        return CartModel(
            id: value.id!,
            name: value.name!,
            price: value.price!,
            img: value.img!,
            quantity: value.quantity! + quantity,
            isExitCart: true,
            time: DateTime.now().toString(),
            product: product);
      });
      if (totalQuantity <= 0) {
        _items.remove(product.id!);
      }
    } else {
      if (quantity > 0) {
        _items.putIfAbsent(product.id!, () {
          return CartModel(
              id: product.id!,
              name: product.name!,
              price: product.price!,
              img: product.img!,
              quantity: quantity,
              isExitCart: true,
              time: DateTime.now().toString(),
              product: product);
        });
      } else {
        snackBar('Cart', 'You should add at least 1 item in the cart !');
      }
    }
    update();
  }

  bool existInCart(ProductModel productModel) {
    if (_items.containsKey(productModel.id)) {
      return true;
    }
    return false;
  }

  int getQuantity(ProductModel productModel) {
    var quantity = 0;
    if (_items.containsKey(productModel.id)) {
      _items.forEach((key, value) {
        if (key == productModel.id!) {
          quantity = value.quantity!;
        } else {}
      });
    }
    return quantity;
  }

  int get totalItems {
    var totalQuantity = 0;
    _items.forEach((key, value) {
      totalQuantity += value.quantity!;
    });

    return totalQuantity;
  }

  List<CartModel> get getCartItem {
    return _items.entries.map((e) {
      return e.value;
    }).toList();
  }

  double get totalPrice {
    var total = 0.0;
    _items.forEach((key, value) {
      total += value.quantity! * value.price!;
    });
    return total;
  }

  snackBar(title, message) {
    Get.snackbar(title, message,
        backgroundColor: AppColors.mainColor, colorText: Colors.white);
  }
}
