import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/pages/cart_page.dart';

class MySliverAppBar extends StatelessWidget {
  final Widget child;
  final Widget title;
  final GlobalKey<ScaffoldState> scaffoldKey;

  const MySliverAppBar(
      {super.key,
      required this.child,
      required this.title,
      required this.scaffoldKey});

//=======================================----------M A I N  C O N T E N T ------------=======================================================
  
  @override
  Widget build(context) {
    return SliverAppBar(
      backgroundColor: Theme.of(context).colorScheme.surface,
      surfaceTintColor: Theme.of(context).colorScheme.surface,
      foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      title: const Text(
        'Sunset diner',
        style: TextStyle(
            fontFamily: 'sf_pro_display_regular', fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      expandedHeight: 350,
      collapsedHeight: 150,
      floating: false,
      pinned: true,
      leading: IconButton(
          onPressed: () {
            scaffoldKey.currentState!.openDrawer();
          },
          icon: const FaIcon(FontAwesomeIcons.bars)),
      actions: [
        IconButton(
            onPressed: () {
              scaffoldKey.currentState!
                  .showBottomSheet((context) => CartPage(), showDragHandle: true, backgroundColor: Theme.of(context).colorScheme.tertiary);
            },
            icon: const FaIcon(FontAwesomeIcons.cartShopping))
      ],
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          color: Theme.of(context).colorScheme.surface,
          padding: const EdgeInsets.only(bottom: 60),
          child: child,
        ),
        title: title,
        titlePadding: const EdgeInsets.only(bottom: 0),
        centerTitle: true,
        expandedTitleScale: 1,
      ),
    );
  }

  
  
}

