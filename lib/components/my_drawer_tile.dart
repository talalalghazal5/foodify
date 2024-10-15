import 'package:flutter/material.dart';

class MyDrawerTile extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function() onTap;

  const MyDrawerTile({super.key, required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 15, bottom: 15),
      child: ListTile(
        title: Text(text, style: TextStyle(fontFamily: 'sf_pro_display_regular', fontSize: 15, letterSpacing: 1.5, fontWeight: FontWeight.bold, color: Theme.of(context).colorScheme.inversePrimary),),
        titleAlignment: ListTileTitleAlignment.center,
        leading: Icon(icon, color: Theme.of(context).colorScheme.inversePrimary,applyTextScaling: true,),
        onTap: onTap,
      ),
    );
  }
}