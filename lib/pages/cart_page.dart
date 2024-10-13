import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_cart_tile.dart';
import 'package:foodify/models/restaurant.dart';

import 'package:foodify/pages/checkout_page.dart';
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
              child: Column(
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
                        icon: const FaIcon(FontAwesomeIcons.ellipsis),
                        onPressed: () => showCupertinoModalPopup(
                          context: context,
                          builder: (context) {
                            return CupertinoActionSheet(
                              cancelButton: CupertinoActionSheetAction(
                                  onPressed: () => Navigator.pop(context),
                                  child: const Text('Close',
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
                                    onPressed: () {
                                      if (restaurant.cart.isEmpty) {
                                        Navigator.pop(context);
                                        const snackBar = SnackBar(
                                          backgroundColor: Colors.transparent,
                                          elevation: 0,
                                          behavior: SnackBarBehavior.floating,
                                          content: AwesomeSnackbarContent(title: 'Your cart is empty', message: 'There are no items in the cart', contentType: ContentType.help));
                                        ScaffoldMessenger.of(context).showSnackBar(snackBar);
                                      } else {
                                        setState(() {
                                          Navigator.pop(context);
                                          showCupertinoDialog(
                                            barrierDismissible: true,
                                            context: context,
                                            builder: (context) {
                                              return CupertinoAlertDialog(
                                                  title: const Text(
                                                      'Are you sure?'),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: const Text(
                                                          'Cancel',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'sf_pro_display_regular'),
                                                        )),
                                                    TextButton(
                                                        onPressed: () {
                                                          setState(() {
                                                            restaurant
                                                                .clearCart();
                                                          });
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child: Text(
                                                          'Confirm',
                                                          style: TextStyle(
                                                              fontFamily:
                                                                  'sf_pro_display_regular',
                                                              color: Colors
                                                                  .red[700]),
                                                        ))
                                                  ]);
                                            },
                                          );
                                        });
                                      }
                                    },
                                    child: Text('Clear cart',
                                        style: TextStyle(
                                            fontFamily:
                                                'sf_pro_display_regular',
                                            color: Colors.red.withAlpha(190)))),
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  ),
                  if (restaurant.cart.isEmpty)
                    const Expanded(
                      child: Center(
                        child: Text(
                          'Your cart is empty',
                          style:
                              TextStyle(fontFamily: 'sf_pro_display_regular'),
                        ),
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
                              padding: const EdgeInsets.only(top: 15),
                              width: 500,
                              height: 80,
                              decoration: BoxDecoration(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .tertiary
                                      .withOpacity(0.2)),
                              child: CupertinoButton(
                                  color: Colors.green[700],
                                  child: const Text(
                                    'Checkout',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'sf_pro_display_regular'),
                                  ),
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        CupertinoPageRoute(
                                            builder: (context) =>
                                                const CheckoutPage()));
                                  })),
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
