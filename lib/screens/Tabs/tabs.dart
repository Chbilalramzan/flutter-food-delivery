import 'package:flutter/material.dart';
import 'package:food_delivery/screens/home/home_screen.dart';
import 'package:food_delivery/utils/colors.dart';
import 'package:food_delivery/utils/dimensions.dart';
import 'package:food_delivery/widgets/app_icon.dart';

class TabScreen extends StatefulWidget {
  const TabScreen({Key? key}) : super(key: key);

  @override
  State<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  int currentTab = 0;
  final List<Widget> screens = [
    const HomeScreen(),
    const Center(child: Text('Next Page 1')),
    const Center(child: Text('Next Page 2')),
    const Center(child: Text('Next Page 3')),
  ];

  void onTapButton(int index) {
    setState(() {
      currentTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentTab],
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.mainColor,
        child: AppIcon(
          backgroundColor: Colors.transparent,
          icon: Icons.shopping_cart_outlined,
          iconColor: Colors.white,
          iconSize: Dimensions.iconSize24,
        ),
        onPressed: () {},
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 10,
        child: SizedBox(
          height: 60,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MaterialButton(
                    onPressed: () {
                      onTapButton(0);
                    },
                    minWidth: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.home,
                            size: 32,
                            color: currentTab == 0
                                ? AppColors.mainColor
                                : Colors.grey),
                        Text(
                          'Home',
                          style: TextStyle(
                              color: currentTab == 0
                                  ? AppColors.mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      onTapButton(1);
                    },
                    minWidth: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.category,
                            size: 32,
                            color: currentTab == 1
                                ? AppColors.mainColor
                                : Colors.grey),
                        Text(
                          'Categories',
                          style: TextStyle(
                              color: currentTab == 1
                                  ? AppColors.mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  MaterialButton(
                    onPressed: () {
                      onTapButton(2);
                    },
                    minWidth: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.search,
                            size: 32,
                            color: currentTab == 2
                                ? AppColors.mainColor
                                : Colors.grey),
                        Text(
                          'Search',
                          style: TextStyle(
                              color: currentTab == 2
                                  ? AppColors.mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                  MaterialButton(
                    onPressed: () {
                      onTapButton(3);
                    },
                    minWidth: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.account_circle,
                            size: 32,
                            color: currentTab == 3
                                ? AppColors.mainColor
                                : Colors.grey),
                        Text(
                          'Profile',
                          style: TextStyle(
                              color: currentTab == 3
                                  ? AppColors.mainColor
                                  : Colors.grey),
                        )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
