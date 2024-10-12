import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodify/components/my_button.dart';
import 'package:foodify/models/food.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:provider/provider.dart';

class FoodPage extends StatefulWidget {
  final Food food;
  final Map<AddOn, bool> selectedAddOns = {};
  FoodPage({super.key, required this.food,}) {
    if (food.availableAddOns != null) {
      for (AddOn addon in food.availableAddOns!) {
        selectedAddOns[addon] = false;
      }
    }
  }

  @override
  State<FoodPage> createState() => _FoodPageState();
}

class _FoodPageState extends State<FoodPage> {
  void addToUICart({required Food food, Map<AddOn, bool>? selectedAddOns}) {

    // closing the food page:
    Navigator.pop(context);

    // main operation:
    if (widget.food.availableAddOns != null) {
      List<AddOn> currentlySelectedAddons = [];
      for (AddOn addOn in widget.food.availableAddOns!) {
        if (widget.selectedAddOns[addOn] == true) {
          currentlySelectedAddons.add(addOn);
        }
      }
      context.read<Restaurant>().addToCart(food: food, selectedAddOns: currentlySelectedAddons);
    } else {
      context.read<Restaurant>().addToCart(food: food);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.pop(context),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        child: const Icon(CupertinoIcons.chevron_back),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startTop,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // image
            Image.asset(
              widget.food.imagePath,
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //name
                  Text(
                    widget.food.name,
                    style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'sf_pro_display_regular'),
                  ),
                  // price
                  Text(
                    '\$${widget.food.price.toString()}',
                    style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
              
                  //description
                  Text(
                    widget.food.description,
                    style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        fontSize: 16,
                        color: Theme.of(context).colorScheme.primary),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Divider(
                      indent: 20,
                      endIndent: 20,
                      color: Theme.of(context).colorScheme.primary),
                  //addons
              
                  if (widget.food.availableAddOns == null ||
                      widget.food.availableAddOns!.isEmpty)
                    Align(
                      alignment: Alignment.center,
                      // padding: const EdgeInsets.all(30),
                      child: Center(
                        child: Text(
                          '- There are no add-ons for this item -',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              fontSize: 15,
                              color: Theme.of(context)
                                  .colorScheme
                                  .inversePrimary),
                        ),
                      ),
                    )
                  else
                    _buildAddOnContainer(context)
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shadowColor: Theme.of(context).colorScheme.inversePrimary,
        surfaceTintColor: Theme.of(context).colorScheme.tertiary,
        elevation: 10,
        height: 110,
        child: Container(
            margin: const EdgeInsets.only(bottom: 10),
            child: MyButton(
              text: 'Add to cart',
              onTap: () {
                addToUICart(
                    food: widget.food, selectedAddOns: widget.selectedAddOns);
              },
            )),
      ),
    );
  }

  Widget _buildAddOnContainer(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 15,
        ),
        Text(
          'Add-Ons:',
          style: TextStyle(
              fontFamily: 'sf_pro_display_regular',
              fontSize: 15,
              color: Theme.of(context).colorScheme.inversePrimary),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          decoration: BoxDecoration(
              border:
                  Border.all(color: Theme.of(context).colorScheme.secondary),
              borderRadius: BorderRadius.circular(10)),
          child: ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: widget.food.availableAddOns?.length,
            padding: const EdgeInsets.only(top: 0),
            itemBuilder: (context, index) {
              AddOn addOn = widget.food.availableAddOns![index];
              return CheckboxListTile(
                value: widget.selectedAddOns[addOn],
                onChanged: (bool? value) {
                  setState(() {
                    widget.selectedAddOns[addOn] = value!;
                  });
                },
                title: Text(
                  addOn.name,
                  style: const TextStyle(fontFamily: 'sf_pro_display_regular'),
                ),
                subtitle: Text(
                  '\$${addOn.price.toString()}',
                  style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                      color: Theme.of(context).colorScheme.primary),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
