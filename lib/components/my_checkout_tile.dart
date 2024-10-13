import 'package:flutter/material.dart';
import 'package:foodify/models/cart_item.dart';

class MyCheckoutTile extends StatelessWidget {
  final CartItem cartItem;

  const MyCheckoutTile({super.key, required this.cartItem});
  @override
  Widget build(BuildContext context) {
    String fontFamily = 'sf_pro_display_regular';
    return IntrinsicHeight(
      child: Container(
        padding: const EdgeInsets.all(10),
        margin: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.tertiary,
            borderRadius: BorderRadius.circular(12)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              // N A M E  A N D  P R I C E  A N D  Q U A N T I T Y. A N D  I M A G E.
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  // N A M E  A N D  P R I C E  A N D  Q U A N T I T Y.
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      // N A M E  A N D  Q U A N T I T Y.
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          cartItem.food.name, // F O O D  N A M E.
                          style: TextStyle(
                              fontFamily: fontFamily,
                              fontWeight: FontWeight.bold,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 20),
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Container(
                          padding: const EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Theme.of(context).colorScheme.primary),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            'Quantity: ${cartItem.quantity}', // Q U A N T I T Y
                            style: TextStyle(
                                fontFamily: fontFamily,
                                fontWeight: FontWeight.bold,
                                color: Theme.of(context).colorScheme.primary,
                                fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      'Price: \$${cartItem.food.price}',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          fontFamily: fontFamily),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      'Total item Price:',
                      style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontFamily: fontFamily, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Row(
                      children: [
                        Text('\$${cartItem.totalPrice + 0.99}', style: TextStyle(
                          color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold,
                          fontFamily: fontFamily),)
                      ],
                    )
                  ],
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      cartItem.food.imagePath,
                      width: 60,
                    )),
              ],
            ),
            const Row(),
            const SizedBox(
              height: 10,
            ),
            Text(
              'Add-Ons:',
              style: TextStyle(
                  fontFamily: fontFamily,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.inversePrimary,
                  fontSize: 15),
            ),
            if (cartItem.food.availableAddOns != null)
              if (cartItem.selectedAddOns!.isEmpty) ...[
                Text(
                  'No add-ons selected',
                  style: TextStyle(
                      fontFamily: fontFamily,
                      color: Theme.of(context).colorScheme.primary),
                )
              ] else ...[
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: cartItem.selectedAddOns!.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: FilterChip(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          label: Text(
                            '${cartItem.selectedAddOns![index].name} (\$${cartItem.selectedAddOns![index].price})',
                            style: TextStyle(
                              fontFamily: fontFamily,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary,
                            ),
                          ),
                          onSelected: (value) {},
                        ),
                      );
                    },
                  ),
                )
              ]
            else
              Text(
                'No add-ons available for this item',
                style: TextStyle(
                    fontFamily: fontFamily,
                    color: Theme.of(context).colorScheme.primary),
              )
          ],
        ),
      ),
    );
  }
}
