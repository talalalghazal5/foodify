// ignore_for_file: avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/food.dart';

class MyTabBar extends StatelessWidget {
  final TabController tabController;
  const MyTabBar({super.key, required this.tabController});

  List<Tab> _myTabBuilder() {
    List<FaIcon> tabIcons = [
      const FaIcon(
        FontAwesomeIcons.burger,
      ),
      const FaIcon(
        FontAwesomeIcons.bowlFood,
      ),
      const FaIcon(
        FontAwesomeIcons.appleWhole,
      ),
      const FaIcon(
        FontAwesomeIcons.iceCream,
      ),
      const FaIcon(
        FontAwesomeIcons.mugSaucer,
      ),
    ];
    return List.generate(FoodCategory.values.length, (index) {
      return Tab(
        icon: tabIcons[index],
        text: FoodCategory.values[index].toString().split('.').last,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.surface,
      child: TabBar(
          unselectedLabelStyle:
              TextStyle(color: Theme.of(context).colorScheme.primary),
          labelColor: Theme.of(context).colorScheme.inversePrimary,

          unselectedLabelColor: Theme.of(context).colorScheme.primary,

          labelStyle: const TextStyle(fontFamily: 'sf_pro_display_regular'),

          dividerColor: Colors.transparent,

          controller: tabController,
          
          indicatorColor: Theme.of(context).colorScheme.inversePrimary,
          tabs: _myTabBuilder()),
    );
  }
}
