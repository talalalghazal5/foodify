import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class AccountPage extends StatefulWidget {
  const AccountPage({super.key});

  @override
  State<AccountPage> createState() => _AccountPageState();
}

class _AccountPageState extends State<AccountPage> {
  late final User? user;
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
      body: Column(
        children: [
          Expanded(
              child: ListView(
            children: [
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
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
                            ? 'No user name' : user!.isAnonymous ?'Guest'
                            : user!.displayName!,
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color: Theme.of(context).colorScheme.inversePrimary,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                      if (user!.emailVerified) ...[
                        const SizedBox(
                          width: 5,
                        ),
                        FaIcon(
                          FontAwesomeIcons.solidCircleCheck,
                          color: Theme.of(context).colorScheme.inversePrimary,
                          size: 20,
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
                height: 20,
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
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
              )
            ],
          )),
        ],
      ),
    );
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
      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: const Text(
            'An error occurred while sending email verification.',
            style: TextStyle(
              fontFamily:
                  'sf_pro_display_regular',
            ),
          ),
          behavior:
              SnackBarBehavior.floating,
          backgroundColor:
              Colors.red[900],
          shape: RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10),
          ),
        ),
      );
    }
  }
}
