import 'package:flutter/material.dart';
import 'package:foodify/models/food.dart';

class MyFoodTile extends StatelessWidget {
  final Food food;
  final Function() onTap;
  const MyFoodTile({super.key, required this.food, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.secondary,
                  borderRadius: BorderRadius.circular(10)),
              padding: const EdgeInsets.all(10),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          food.name,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'sf_pro_rounded_regular'),
                        ),
                        Text(
                          '\$${food.price}',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: 'sf_pro_rounded_regular'),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          food.description,
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontFamily: 'sf_pro_rounded_regular'),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(
                      food.imagePath,
                      width: 100,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        Divider(
          indent: 20,
          endIndent: 20,
          color: Theme.of(context).colorScheme.secondary,
        )
      ],
    );
  }
}
