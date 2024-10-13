import 'package:flutter/material.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:provider/provider.dart';

class MyDeliveryReceipt extends StatelessWidget {
  const MyDeliveryReceipt({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(builder: (context, restaurant, child) {
      return Padding(padding: const EdgeInsets.only(left: 25,right: 25, bottom: 25, top: 25),
    child: Center(
      child: Column(
        children: [
          Text('Thank you for ordering!', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontFamily: 'sf_pro_display_regular', fontSize: 16),),
          const SizedBox(height: 25,),
          Container(
            padding: const EdgeInsets.all(25),
            decoration: BoxDecoration(
              border: Border.all(color: Theme.of(context).colorScheme.inversePrimary)
            ),
            child: Column(
              children: [
                Text(restaurant.displayReceipt(), style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary, fontFamily: 'sf_mono_regular')),
              ],
            ),
          )
        ],
      ),
    ),);
    },);
  }
}