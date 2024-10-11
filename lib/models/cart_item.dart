import 'package:foodify/models/food.dart';

class CartItem {
  Food food;
  List<AddOn>? selectedAddOns;
  int quantity;

  CartItem({required this.food, this.selectedAddOns , this.quantity = 1});

  double get totalPrice {
    // TODO: Ask Copilot about this fold() function:
    if (selectedAddOns != null) {
      double addonsPrice = selectedAddOns!.fold(0, (sum, addon) => sum + addon.price,);
      return (food.price + addonsPrice) * quantity;
    }
    else {
      return food.price * quantity;
    }
  }



}