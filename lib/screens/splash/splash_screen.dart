import 'dart:async';

import 'package:flutter/material.dart';
import 'package:food_delivery/controllers/homeController.dart';
import 'package:food_delivery/routes/route_helper.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future<void> _loadResources() async {
    await Get.find<HomeController>().productsList();
    await Get.find<HomeController>().getRecommendedProductsList();
  }

  @override
  void initState() {
    _loadResources();
    Timer(const Duration(seconds: 3),
        () => Get.toNamed(RouteHelper.getInitial()));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          height: 200,
          width: 200,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: AppColors.mainColor),
        ),
      ),
    );
  }
}
