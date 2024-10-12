import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_cart_tile.dart';
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
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      final userCart = restaurant.cart;
      return BottomSheet(
          dragHandleSize: const Size.fromWidth(140),
          onClosing: () {},
          enableDrag: true,
          animationController: _controller,
          builder: (context) {
            return Container(
              padding: const EdgeInsets.all(20),
              height: 700,
              width: 1000,
              decoration:
                  BoxDecoration(color: Theme.of(context).colorScheme.tertiary),
              child:  
              Column(
                children: [
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'My Cart',
                        style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          'Total Cost: \$${restaurant.totalCartCost}',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                      IconButton(
                          onPressed: () => showCupertinoModalPopup(
                                context: context,
                                builder: (context) {
                                  return CupertinoActionSheet(
                                    cancelButton: CupertinoActionSheetAction(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel',
                                            style: TextStyle(
                                                fontFamily:
                                                    'sf_pro_display_regular'))),
                                    title: Text(
                                      'Items in cart: ${restaurant.totalCartItems}',
                                      style: const TextStyle(
                                          fontFamily: 'sf_pro_display_regular',
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.8,
                                          fontSize: 15),
                                    ),
                                    actions: [
                                      CupertinoActionSheetAction(
                                          onPressed: () => setState(() {
                                                Navigator.pop(context);
                                                restaurant.clearCart();
                                              }),
                                          child: Text('Clear cart',
                                              style: TextStyle(
                                                  fontFamily:
                                                      'sf_pro_display_regular',
                                                  color: Colors.red
                                                      .withAlpha(190)))),
                                    ],
                                  );
                                },
                              ),
                          icon: const FaIcon(FontAwesomeIcons.ellipsis)),
                    ],
                  ),
                  if(restaurant.cart.isEmpty) 
                  const Expanded(
                    child: Center(
                      child: Text('Your cart is empty', style: TextStyle(fontFamily: 'sf_pro_display_regular'),),
                    ),
                  )
                  else ...[
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: userCart.length,
                    itemBuilder: (context, index) {
                      return MyCartTile(cartItem: userCart[index]);
                    },
                  )),
                  
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            padding: EdgeInsets.only(top: 15),
                            width: 500,
                            height: 80,
                            decoration: BoxDecoration(color: Theme.of(context).colorScheme.tertiary.withOpacity(0.2)),
                            child: CupertinoButton(color: Colors.green[700], child: Text('Checkout', style: TextStyle(color: Colors.white, fontFamily: 'sf_pro_display_regular'),), onPressed: (){})),
                        ),
                      ],
                    )
                  ]
                ],
              ),
            );
          });
    });
  }
}
