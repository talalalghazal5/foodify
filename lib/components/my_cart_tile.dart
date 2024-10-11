import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/components/my_quantity_selector.dart';
import 'package:foodify/models/cart_item.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyCartTile extends StatelessWidget {
  final CartItem cartItem;
  const MyCartTile({super.key, required this.cartItem});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
        child: Container(
          padding: EdgeInsets.only(left: 12, top: 8, right: 8, bottom: 8),
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.secondary,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${cartItem.food.name}',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Text(
                        'Price: \$${cartItem.food.price}',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color: Theme.of(context).colorScheme.primary),
                      ),
                    ],
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      width: 80,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add-Ons:',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                            color: Theme.of(context)
                                .colorScheme
                                .inversePrimary
                                .withAlpha(200)),
                      ),
                      if (cartItem.food.availableAddOns != null)
                        if (cartItem.selectedAddOns!.isEmpty)
                          Text(
                            'No add-ons selected ',
                            style: TextStyle(
                                fontFamily: 'sf_pro_display_regular',
                                color: Theme.of(context).colorScheme.primary),
                          )
                        else ...[
                          Text(
                            cartItem.selectedAddOns!
                                .map((addon) =>
                                    ' - ${addon.name} (\$${addon.price})')
                                .join('\n'),
                            style: TextStyle(
                                fontFamily: 'sf_pro_display_regular',
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          )
                        ]
                      else
                        Text('No add-ons available',
                            style: TextStyle(
                                fontFamily: 'sf_pro_display_regular',
                                color: Theme.of(context).colorScheme.primary)),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 5),
                        width: 200,
                        height: 1,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      Text(
                        'Total price: \$${cartItem.totalPrice}',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      )
                    ],
                  ),
                  MyQuantitySelector(
                      quantity: cartItem.quantity,
                      onDecrement: () => restaurant.removeFromCart(cartItem),
                      onIncrement: () => restaurant.addToCart(
                          food: cartItem.food,
                          selectedAddOns: cartItem.selectedAddOns),
                      food: cartItem.food),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
