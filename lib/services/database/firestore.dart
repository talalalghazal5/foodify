import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:foodify/models/cart_item.dart';
import 'package:foodify/models/restaurant.dart';

class FirestoreServices {
  // add a data collection
  FirebaseFirestore database = FirebaseFirestore.instance;
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');

  String? userID = FirebaseAuth.instance.currentUser!.uid;
  //save orders to this collection

int orderNumber = 1;
Future<void> addOrderToDataBase()async{
  QuerySnapshot cartSnapshots = await database.collection('cart').get();

  if (cartSnapshots.docs.isNotEmpty) {
    DocumentReference order = database.collection('orders').doc();
  List<Map<String, dynamic>> items = cartSnapshots.docs.map((element) {
    return element.data() as Map<String, dynamic>;
  }).toList();

  await order.set({
    'items' : items,
    'totalPrice' : items.fold(0.0, (summ, item) => summ + item['cost']),
    'date' : DateTime.now().toIso8601String()
  });
    for (DocumentSnapshot doc in cartSnapshots.docs) {
      await doc.reference.delete();
    }  
  }

  
}

  Future<void> addCartItemToDatabase(CartItem item) async {
    DocumentReference response =
        database.collection('cart').doc(item.food.name);

    await response.set({
      'id': item.food.name,
      'name': item.food.name,
      'image' : item.food.imagePath,
      'quantity': item.quantity,
      'cost': item.totalPrice,
      'selectedAddons': (item.food.availableAddOns == null ||
              item.selectedAddOns == null ||
              item.selectedAddOns!.isEmpty)
          ? 'No addons'
          : item.selectedAddOns!.map((addon) {
              return '${addon.name} - (\$${addon.price}) \n ';
            }).toString(),
    });
  }

  Stream<QuerySnapshot> getUserOrders() {
    return database.collection('cart').snapshots();

  }
}
