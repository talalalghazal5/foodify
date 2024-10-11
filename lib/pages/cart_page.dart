import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/food.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = BottomSheet.createAnimationController(this);
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
        builder: (context, restaurant, child) => BottomSheet(
            onClosing: () {},
            enableDrag: true,
            animationController: _controller,
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(20),
                height: 700,
                width: 1000,
                decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.tertiary),
                child: Column(
                  children: [
                    const Text(
                      'My Cart',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 15),
                    ),
                    Expanded(
                        child: ListView.builder(
                      itemCount: restaurant.cart.length,
                      itemBuilder: (context, index) {
                        if (restaurant.cart[index].selectedAddOns == null) {
                          return ListTile(
                            title: Text(restaurant.cart[index].food.name),
                            subtitle: Text('No addons available'),
                          );
                        } else {
                          return ListTile(
                            title: Text(restaurant.cart[index].food.name),
                            subtitle: Text(restaurant.cart[index].selectedAddOns!.map((addon) {
                              String addonNames = '';
                              for (AddOn addon in restaurant.cart[index].selectedAddOns!) {
                                addonNames += '${addon.name}, ';
                              }
                            },).toString()),
                          );
                        }
                      },
                    ))
                  ],
                ),
              );
            }));
  }
}
