import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:foodify/models/cart_item.dart';
import 'package:foodify/models/food.dart';
import 'package:intl/intl.dart';

class Restaurant extends ChangeNotifier {
  final List<Food> _menu = [
    //burger
    Food(
        name: 'Cheese burger',
        description: 'Huge burger with cheese dressing',
        imagePath: 'lib/assets/images/burger_1.jpg',
        price: 4.99,
        category: FoodCategory.burgers,
        availableAddOns: [AddOn(name: 'Ketchup', price: 0.99)]),
    Food(
        name: 'Mac burger',
        description: 'Huge mac burger with sesame dressing',
        imagePath: 'lib/assets/images/burger_2.jpg',
        price: 4.99,
        category: FoodCategory.burgers,
        availableAddOns: [AddOn(name: 'Lettuce', price: 0.89)]),

    //salads
    Food(
        name: 'Caesar salad',
        description: 'Salad of lettuce and chicken with mayo',
        imagePath: 'lib/assets/images/light_1.jpg',
        price: 6.98,
        category: FoodCategory.salads,
        availableAddOns: [AddOn(name: 'Ketchup', price: 0.59)]),
    Food(
        name: 'Fattoush salad',
        description:
            'Salad of many vegetables mixed together and dressing of fried bread',
        imagePath: 'lib/assets/images/light_2.jpg',
        price: 7.00,
        category: FoodCategory.salads,
        availableAddOns: [AddOn(name: 'French fries', price: 1.99)]),
    Food(
        name: 'Tabbouleh',
        description: 'Shredded Bakdounes with little tomato cubes',
        imagePath: 'lib/assets/images/light_3.jpg',
        price: 4.00,
        category: FoodCategory.salads,
        availableAddOns: [AddOn(name: 'French fries', price: 1.99)]),
    //sides
    Food(
        name: 'Hot Dog',
        description: 'Roasted hot dog with a bun',
        imagePath: 'lib/assets/images/hot_dog_1.jpg',
        price: 2.99,
        category: FoodCategory.sides,
        availableAddOns: [AddOn(name: 'Mustard', price: 0.95)]),
    Food(
        name: 'Hot Dog 2',
        description: 'Roasted hot dog with a bun',
        imagePath: 'lib/assets/images/hot_dog_2.jpg',
        price: 2.99,
        category: FoodCategory.sides,
        availableAddOns: [
          AddOn(name: 'Mustard', price: 0.95),
          AddOn(name: 'Ketchup', price: 1.99)
        ]),

    //dessert
    Food(
        name: 'Chocolate ice cream',
        description: 'Ice cream in chocolate flavor with sprinkles as dressing',
        imagePath: 'lib/assets/images/blue_bird_1.jpg',
        price: 4.99,
        category: FoodCategory.desserts,
        availableAddOns: [
          AddOn(name: 'Chocolate chips', price: 2.99),
          AddOn(name: 'Biscuit cornet', price: 0.99)
        ]),
    Food(
        name: 'Milk ice cream',
        description: 'Ice cream in Milk flavor with sprinkles as dressing',
        imagePath: 'lib/assets/images/blue_bird_2.jpg',
        price: 4.99,
        category: FoodCategory.desserts,
        availableAddOns: [
          AddOn(name: 'Chocolate chips', price: 2.99),
          AddOn(name: 'Biscuit cornet', price: 0.99)
        ]),
    Food(
        name: 'Fruit salad',
        description:
            'Salad of strawberries, apples, bananas, mango, kiwi, and pineapples ',
        imagePath: 'lib/assets/images/blue_bird_3.jpg',
        price: 6.99,
        category: FoodCategory.desserts,
        availableAddOns: [
          AddOn(name: 'Pomegranate dressing', price: 0.85),
          AddOn(name: 'Sugar syrup', price: 0.59),
          AddOn(name: 'Chocolate sauce', price: 1.99),
        ]),
    //drinks
    Food(
        name: 'Pepsi',
        description: 'A cup of pepsi with ice cubes',
        imagePath: 'lib/assets/images/medicine_1.jpg',
        price: 4.99,
        category: FoodCategory.drinks),
    Food(
        name: 'Cappuccino',
        description: 'Fancy-made Cappuccino',
        imagePath: 'lib/assets/images/medicine_2.jpg',
        price: 6.99,
        category: FoodCategory.drinks),
    Food(
        name: 'Nescafe',
        description: 'Nescafe with milk',
        imagePath: 'lib/assets/images/medicine_3.jpg',
        price: 4.99,
        category: FoodCategory.drinks),
    Food(
        name: 'Seven-up Grandine',
        description: 'A mix of seven-up with strawberry sauce and lemon',
        imagePath: 'lib/assets/images/medicine_4.jpg',
        price: 5.99,
        category: FoodCategory.drinks),
  ];

/*
  G E T T E R S:
*/
  List<Food> get menu => _menu;

/*
  O P E R A T I O N S:
*/

  final List<CartItem> _cart = [];

  List<CartItem> get cart => _cart;

// add to cart
  void addToCart({required Food food, List<AddOn>? selectedAddOns}) {
    if (food.availableAddOns != null) {
      CartItem? cartItem = _cart.firstWhereOrNull(
        (item) {
          bool isSameItem = item.food == food;

          bool isSameAddOns =
              const ListEquality().equals(item.selectedAddOns, selectedAddOns);

          return isSameAddOns && isSameItem;
        },
      );

      if (cartItem != null) {
        cartItem.quantity++;
      } else {
        _cart.add(CartItem(food: food, selectedAddOns: selectedAddOns!));
      }
    } else {
      CartItem? cartItem = _cart.firstWhereOrNull((item) {
        bool isSameItem = item.food == food;
        return isSameItem;
      });
      if (cartItem != null) {
        cartItem.quantity++;
      } else {
        _cart.add(CartItem(food: food));
      }
    }
    notifyListeners();
  }

// remove from cart
  void removeFromCart(CartItem cartItem) {
    int cartIndex = _cart.indexOf(cartItem);

    if (cartIndex != -1) {
      if (_cart[cartIndex].quantity > 1) {
        _cart[cartIndex].quantity--;
      } else {
        _cart.removeAt(cartIndex);
      }
    }
    notifyListeners();
  }

// get total cart cost
  double get totalCartCost {
    double cost = 0.0;
    for (CartItem cartItem in _cart) {
      cost += cartItem.totalPrice;
    }
    return double.parse(cost.toStringAsFixed(2));
  }

// get total number of items in the cart
  int get totalCartItems {
    int totalNumber = 0;
    for (CartItem cartItem in _cart) {
      totalNumber += cartItem.quantity;
    }
    return totalNumber;
  }

// clear cart
  void clearCart() {
    _cart.clear();
    notifyListeners();
  }

/*
  H E L P E R S:
*/
// generate receipt
  String displayReceipt() {
    final receipt = StringBuffer();
    receipt.writeln('Receipt here:');
    receipt.writeln();

    String formattedDate =
        DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
    receipt.writeln(formattedDate);
    receipt.writeln('-------------------------');
    receipt.writeln();

    for (CartItem cartItem in _cart) {
      receipt.writeln(
          '${cartItem.quantity} x ${cartItem.food.name} - ${_priceFormatter(cartItem.food.price)}');
      if (cartItem.selectedAddOns != null) {
        if (cartItem.selectedAddOns!.isNotEmpty) {
          receipt.writeln(' Add-ons:');
          for (AddOn addon in cartItem.selectedAddOns!) {
            receipt.writeln(' ${addon.name} (${_priceFormatter(addon.price)})');
          }
        }
      }
      receipt.writeln();
    }
    receipt.writeln('--------------------------');
    receipt.writeln('Total items number: $totalCartItems');
    receipt.writeln('Total cart cost: ${_priceFormatter(totalCartCost)}');
    receipt.writeln();
    receipt.writeln('Estimated delivery time: 14 minutes');
    return receipt.toString();
  }

// format double values into money
  String _priceFormatter(double price) {
    return '\$${price.toStringAsFixed(2)}';
  }

// format list of addons into string summary
  String _formatAddons(List<AddOn> addons) {
    return addons.map((addon) {
      return '${addon.name} (\$${_priceFormatter(addon.price)})';
    }).join(', ');
  }
}
