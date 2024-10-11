import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyCurrentLocation extends StatefulWidget {
  const MyCurrentLocation({super.key});

  @override
  State<MyCurrentLocation> createState() => _MyCurrentLocationState();
}

class _MyCurrentLocationState extends State<MyCurrentLocation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Deliver to:',
            style: TextStyle(
                fontFamily: 'sf_pro_display_regular',
                color: Theme.of(context).colorScheme.primary),
          ),
          InkWell(
            onTap: () => openLocationSearchBar(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Pasadena,California CA 9014',
                  style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                const SizedBox(
                  width: 5,
                ),
                const Icon(
                  CupertinoIcons.chevron_down,
                  size: 15,
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  openLocationSearchBar() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            
            title: const Text(
              'Enter your location:',
              style: TextStyle(fontFamily: 'sf_pro_display_regular'),
            ),
            content: TextField(
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                borderSide:
                    BorderSide(color: Theme.of(context).colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              )),
            ),
            actions: [
              CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancel')),
              CupertinoButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Save')),
            ],
          );
        });
  }
}
