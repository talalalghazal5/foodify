// ignore_for_file: unused_element

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/components/my_current_location.dart';
import 'package:foodify/components/my_description_box.dart';
import 'package:foodify/components/my_drawer.dart';
import 'package:foodify/components/my_food_tile.dart';
import 'package:foodify/components/my_sliver_app_bar.dart';
import 'package:foodify/components/my_tab_bar.dart';
import 'package:foodify/models/food.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:foodify/pages/food_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _tabController =
        TabController(length: FoodCategory.values.length, vsync: this);
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  //sort foods by category:
  List<Food> _filterFoodByCategory(FoodCategory category, List<Food> fullMenu) {
    return fullMenu.where((food) => food.category == category).toList();
  }

  //get a list of food in a certain category:
  List<Widget> _getFoodInThisCategory(List<Food> fullMenu) {
    return FoodCategory.values.map((category) {
      List<Food> foodOfThisCategory = _filterFoodByCategory(category, fullMenu);

      return ListView.builder(
        controller: _scrollController,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: foodOfThisCategory.length,
        itemBuilder: (context, index) {
          final Food food = foodOfThisCategory[index];
          return MyFoodTile(
            food: food,
            onTap: () {
              Navigator.push(
                  context,
                  CupertinoPageRoute(
                      builder: (context) => FoodPage(food: food)));
            },
          );
        },
      );
    }).toList();
  }

// M A I N  P A G E :
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const MyDrawer(),
      body: NestedScrollView(
          controller: _scrollController,
          floatHeaderSlivers: true,
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
                MySliverAppBar(
                  scaffoldKey: scaffoldKey,
                  title: MyTabBar(tabController: _tabController),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Divider(
                        indent: 20,
                        endIndent: 20,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const MyCurrentLocation(),
                      const MyDescriptionBox(),
                    ],
                  ),
                ),
              ],
          body: Consumer<Restaurant>(
            builder: (context, restaurant, child) => TabBarView(
                controller: _tabController,
                children: _getFoodInThisCategory(restaurant.menu)),
          )),
    );
  }
}
