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
      return double.parse(((food.price + addonsPrice) * quantity).toStringAsFixed(2));
    }
    else {
      return double.parse((food.price * quantity).toStringAsFixed(2));
    }
  }



}