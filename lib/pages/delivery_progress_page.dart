import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_delivery_receipt.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:foodify/services/database/firestore.dart';
import 'package:provider/provider.dart';

class DeliveryProgressPage extends StatefulWidget {
  const DeliveryProgressPage({super.key});

  @override
  State<DeliveryProgressPage> createState() => _DeliveryProgressPageState();
}

class _DeliveryProgressPageState extends State<DeliveryProgressPage> {

  final FirestoreServices database = FirestoreServices();
  @override
  void initState() {
    super.initState();
    String receipt = context.read<Restaurant>().displayReceipt();
    database.saveOrderToDataBase(receipt);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Delivery in progress...',
          style: TextStyle(
              color: Theme.of(context).colorScheme.inversePrimary,
              fontFamily: 'sf_pro_display_regular'),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: FaIcon(
            FontAwesomeIcons.chevronLeft,
            color: Theme.of(context).colorScheme.inversePrimary,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
              child: ListView(
            children: const [
              MyDeliveryReceipt(),
            ],
          ))
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context){
    return Container(
      height: 100,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30),),
        color: Theme.of(context).colorScheme.tertiary,
      ),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(10),
            child: FaIcon(FontAwesomeIcons.solidCircleUser, color: Theme.of(context).colorScheme.inversePrimary, size: 60,),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Driver info:', style: TextStyle(fontFamily: 'sf_pro_display_regular', color: Theme.of(context).colorScheme.inversePrimary),),
              Text('  John Doe', style: TextStyle(fontFamily: 'sf_pro_display_regular', color: Theme.of(context).colorScheme.inversePrimary, fontWeight: FontWeight.bold, fontSize: 18),),
              Text('  0935299727', style: TextStyle(fontFamily: 'sf_pro_display_regular', color: Theme.of(context).colorScheme.primary, fontSize: 13),)
            ],
          ),
          const Spacer(),
          Row(
            
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                  child: IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.chat_bubble_fill, color: Colors.blue[800],size: 30,)),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 10, bottom: 10, top: 10),
                child: Container(
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Theme.of(context).colorScheme.secondary),
                  child: IconButton(onPressed: (){}, icon: FaIcon(FontAwesomeIcons.phone, color: Colors.green[800],)),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
