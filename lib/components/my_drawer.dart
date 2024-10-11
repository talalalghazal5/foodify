import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_drawer_tile.dart';
import 'package:foodify/pages/settings_page.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 80, bottom: 20),
            child: FaIcon(
              FontAwesomeIcons.burger,
              size: 80,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(25),
            child: Divider(),
          ),
          MyDrawerTile(
              text: 'HOME',
              icon: FontAwesomeIcons.house,
              onTap: () => Navigator.pop(context)),
          MyDrawerTile(
              text: 'SETTINGS',
              icon: FontAwesomeIcons.gear,
              onTap: () => {
                    Navigator.pop(context),
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) => const SettingsPage()))
                  }),
          const Spacer(),
          MyDrawerTile(
              text: 'LOGOUT',
              icon: FontAwesomeIcons.arrowRightFromBracket,
              onTap: () {}),
          const SizedBox(
            height: 20,
          )
        ],
      ),
    );
  }
}
