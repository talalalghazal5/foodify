// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/models/cart_item.dart';
import 'package:foodify/models/food.dart';
import 'package:foodify/services/database/firestore.dart';
import 'package:intl/intl.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final User? user;
  FirestoreServices database = FirestoreServices();

  @override
  void initState() {
    super.initState();
    final auth = FirebaseAuth.instance;
    try {
      user = auth.currentUser;

      print('User data: ${user != null ? user!.toString() : 'No user'}');
    } catch (e) {
      print('$e========================================================');
    }
    
  }

  getCart() async {
    QuerySnapshot snapshots = await database.cart.get();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'My Account',
            style: TextStyle(
                color: Theme.of(context).colorScheme.inversePrimary,
                fontWeight: FontWeight.bold,
                fontFamily: 'sf_pro_display_regular'),
          ),
          centerTitle: true,
          leading: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: FaIcon(
                FontAwesomeIcons.chevronLeft,
                color: Theme.of(context).colorScheme.inversePrimary,
              )),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  tileColor: Theme.of(context).colorScheme.secondary,
                  minTileHeight: 70,
                  contentPadding: const EdgeInsets.only(
                      bottom: 10, left: 10, right: 10, top: 5),
                  leading: FaIcon(
                    FontAwesomeIcons.solidCircleUser,
                    color: Theme.of(context).colorScheme.inversePrimary,
                    size: 60,
                  ),
                  title: Row(
                    children: [
                      Text(
                        user!.displayName == null || user!.displayName! == ''
                            ? 'No user name'
                            : user!.isAnonymous
                                ? 'Guest'
                                : user!.displayName!,
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                      if (user!.emailVerified) ...[
                        const SizedBox(
                          width: 5,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Colors.blue[700],
                          size: 17,
                        )
                      ],
                    ],
                  ),
                  subtitle: Text(
                    user!.isAnonymous ? '' : user!.email!,
                    style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                      color: Theme.of(context).colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                ),
                child: ListTile(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    leading: Text(
                      'Verification Status:',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          color: Theme.of(context).colorScheme.inversePrimary,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                    tileColor: Theme.of(context).colorScheme.secondary,
                    trailing: user!.emailVerified
                        ? SizedBox(
                            width: 90,
                            height: 30,
                            child: Center(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  Text(
                                    'verified',
                                    style: TextStyle(
                                        fontFamily: 'sf_pro_display_regular',
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                        fontSize: 15),
                                  ),
                                  const SizedBox(
                                    width: 4,
                                  ),
                                  FaIcon(
                                    FontAwesomeIcons.solidCircleCheck,
                                    color: Colors.green[700],
                                    size: 23,
                                  ),
                                ],
                              ),
                            ),
                          )
                        : TextButton(
                            style: ButtonStyle(
                                backgroundColor: WidgetStatePropertyAll(
                                  Colors.yellow[800],
                                ),
                                foregroundColor:
                                    const WidgetStatePropertyAll(Colors.white),
                                shape: WidgetStatePropertyAll(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(8)))),
                            onPressed: () {
                              showCupertinoDialog(
                                context: context,
                                builder: (context) {
                                  return CupertinoAlertDialog(
                                    content: Text(
                                      'We will send a verification e-mail to your address to verify your account',
                                      style: TextStyle(
                                        fontFamily: 'sf_pro_display_regular',
                                        fontSize: 12,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .inversePrimary,
                                      ),
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          'Cancel',
                                          style: TextStyle(
                                            fontFamily:
                                                'sf_pro_display_regular',
                                            color: Theme.of(context)
                                                .colorScheme
                                                .inversePrimary,
                                          ),
                                        ),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          verifyEmail();
                                        },
                                        child: Text(
                                          'Confirm',
                                          style: TextStyle(
                                            fontFamily:
                                                'sf_pro_display_regular',
                                            color: Colors.green[700],
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                            child: const Text(
                              'Not verified, verify now',
                              style: TextStyle(
                                  fontFamily: 'sf_pro_display_regular',
                                  fontSize: 12),
                            ))),
              ),
              const SizedBox(
                height: 25,
              ),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Order History',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  )),
              Container(
                  height: 500,
                  child: StreamBuilder(
                    stream: database.cart.snapshots(),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                        return Center(child: Text('No items in the cart.'));
                      }
                      var orders = snapshot.data!.docs;
                      return ListView.builder(
                        itemCount: orders.length,
                        itemBuilder: (context, index) {
                          var item = orders[index];
                          return Card(
                            child: ListTile(
                              title: Text(
                                  '${item['name']} x ${item['quantity']} '),
                              subtitle: Text(
                                item['selectedAddons'].toString(),
                              ),
                              trailing: Text('${item['cost']}'),
                            ),
                          );
                        },
                      );
                    },
                  ))
            ],
          ),
        ));
  }

  void verifyEmail() async {
    try {
      await user!.sendEmailVerification(
        ActionCodeSettings(
          url:
              'https://myfoodify.app.link/verify?email=${user!.email}', // Customize this URL for your app
          handleCodeInApp: true,
          iOSBundleId: 'com.example.ios',
          androidPackageName: 'com.example.foodify',
          androidInstallApp: true,
          androidMinimumVersion: '12',
        ),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'Verification email sent. Check your inbox.',
            style: TextStyle(
              fontFamily: 'sf_pro_display_regular',
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.green[700],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    } catch (e) {
      print(
          '$e =============================================================================');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
            'An error occurred while sending email verification.',
            style: TextStyle(
              fontFamily: 'sf_pro_display_regular',
            ),
          ),
          behavior: SnackBarBehavior.floating,
          backgroundColor: Colors.red[900],
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}


// 