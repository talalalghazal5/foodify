import 'package:flutter/material.dart';

class MyDescriptionBox extends StatelessWidget {
  const MyDescriptionBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 30),
      decoration: BoxDecoration(
        border: Border.all(color: Theme.of(context).colorScheme.primary),
        borderRadius: BorderRadius.circular(10)
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('\$0.99', style: TextStyle(fontFamily: 'sf_pro_display_regular', color: Theme.of(context).colorScheme.inversePrimary),),
              const Text('Delivery fees',style: TextStyle(fontFamily: 'sf_pro_display_regular',))
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('15-30 mins', style: TextStyle(fontFamily: 'sf_pro_display_regular', color: Theme.of(context).colorScheme.inversePrimary)),
              const Text('Delivery time',style: TextStyle(fontFamily: 'sf_pro_display_regular',))
            ],
          ),
        ],
      ),
    );
  }
}