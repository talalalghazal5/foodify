import 'package:flutter/material.dart';

class DeliveryProgressPage extends StatelessWidget {
  const DeliveryProgressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Your order on its way!', style: TextStyle(color: Colors.green[700], fontFamily: 'sf_pro_display_regular', fontSize: 40),),
      ),
    );
  }
}