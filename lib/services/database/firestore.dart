import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreServices {
  // add a data collection
  CollectionReference orders = FirebaseFirestore.instance.collection('orders');
  final _auth = FirebaseAuth.instance;

  //save orders to this collection
  Future<void> saveOrderToDataBase(String receipt)async {
    orders.add({
      'date' : DateTime.now(),
      'order' : receipt,
      'user' : _auth.currentUser!.isAnonymous? 'Guest' : _auth.currentUser!.email,
    });
  }
}