import 'dart:ui';

import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_button.dart';
import 'package:foodify/components/my_text_form_field.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoading = false;
  final auth = FirebaseAuth.instance;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void resetPassword(String email) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: AwesomeSnackbarContent(
              title: 'Reset link sent',
              message:
                  'We sent you an e-mail with a reset link to your e-mail address',
              contentType: ContentType.success)));
    } catch (e) {
      showCupertinoDialog(
          barrierDismissible: true,
          context: context,
          builder: (context) {
            return CupertinoAlertDialog(
              content: Text(
                'Error occured during sending password reset link',
                style: TextStyle(
                    fontFamily: 'sf_pro_display_regular',
                    color: Theme.of(context).colorScheme.inversePrimary),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Okay',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          color: Theme.of(context).colorScheme.inversePrimary)),
                )
              ],
            );
          });
    }
  }

  Widget _buildLoader() {
    return Center(
        child: BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
      child: CircularProgressIndicator(
          backgroundColor: Theme.of(context).colorScheme.primary,
          color: Theme.of(context).colorScheme.inversePrimary),
    ));
  }

  void login() async {
    final String email = emailController.text;
    final String password = passwordController.text;
    setState(() {
      _isLoading = true;
    });
    try {
      if (formKey.currentState!.validate()) {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
            email: email, password: password);
      }
    } on FirebaseAuthException catch (e) {
      if (auth.currentUser != null) {
        showCupertinoDialog(
            context: context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  'E-mail not registered',
                  style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                      fontWeight: FontWeight.normal,
                      color: Theme.of(context).colorScheme.error),
                ),
                content: Text(
                  'The email you entered is not registered, try to register as a new account or try agian with another email address',
                  style: TextStyle(
                    fontFamily: 'sf_pro_display_regular',
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Cancel',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      resetPassword(email);
                      Navigator.pop(context);
                    },
                    child: Text(
                      'Register now',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.normal,
                          color: Colors.green[700]),
                    ),
                  ),
                ],
              );
            });
      } else {
        switch (e.code) {
          case 'invalid-credential':
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'Wrong password',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.error),
                    ),
                    content: Text(
                      'Your password is incorrect',
                      style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Okay',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              fontWeight: FontWeight.normal,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ],
                  );
                });
            print('the password is wrong');
            break;
          case 'user-not-found':
            print('email unregistered');
            break;
          case 'too-many-requests':
            showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text(
                      'Login banned',
                      style: TextStyle(
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.normal,
                          color: Theme.of(context).colorScheme.error),
                    ),
                    content: Text(
                      'Due to too many login attempts, you have been prohibited from logging in for now, to login again, please reset your password now to get access to your account',
                      style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              fontWeight: FontWeight.normal,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          resetPassword(email);
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Reset password',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              fontWeight: FontWeight.normal,
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                      ),
                    ],
                  );
                });
          default:
            print(
                '${e.code} ===========================================================');
        }
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Stack(
          children: [
            Center(
              child: SingleChildScrollView(
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      //logo
                      FaIcon(
                        FontAwesomeIcons.burger,
                        size: 100,
                        color: Theme.of(context).colorScheme.inversePrimary,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      //welcoming message
                      Text(
                        'Foodify',
                        style: TextStyle(
                            fontSize: 30,
                            fontFamily: 'sf_pro_display_regular',
                            fontWeight: FontWeight.bold,
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        'Welcome back! sign in to continue',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),

                      const SizedBox(
                        height: 50,
                      ),
                      Container(
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        child: Form(
                            autovalidateMode:
                                AutovalidateMode.onUnfocus,
                            key: formKey,
                            child: Column(
                              children: [
                                //email text field
                                MyTextFormField(
                                  controller: emailController,
                                  hintText: "E-mail",
                                  inputType: TextInputType.emailAddress,
                                ),

                                const SizedBox(
                                  height: 15,
                                ),
                                //password text field
                                MyTextFormField(
                                  controller: passwordController,
                                  hintText: "Password",
                                  inputType: TextInputType.visiblePassword,
                                ),
                              ],
                            )),
                      ),
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.only(left: 25, top: 15),
                          child: Row(
                            children: [
                              Text(
                                'Forgot password? ',
                                style: TextStyle(
                                    fontFamily: 'sf_pro_display_regular',
                                    fontSize: 13,
                                    color:
                                        Theme.of(context).colorScheme.primary),
                              ),
                              InkWell(
                                onTap: () {
                                  resetPassword(emailController.text);
                                },
                                child: Text(
                                  'Reset it now',
                                  style: TextStyle(
                                      fontFamily: 'sf_pro_display_regular',
                                      fontSize: 13,
                                      color: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary,
                                      decoration: TextDecoration.underline,
                                      decorationColor: Theme.of(context)
                                          .colorScheme
                                          .inversePrimary),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(
                        height: 20,
                      ),
                      //signin button
                      DismissKeyboard(
                        child: MyButton(
                          text: 'Sign in',
                          margin: const EdgeInsets.symmetric(horizontal: 25),
                          onTap: () {
                            login();
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Not a member? ',
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: 'sf_pro_display_regular',
                                color: Theme.of(context)
                                    .colorScheme
                                    .inversePrimary),
                          ),
                          InkWell(
                            onTap: widget.onTap,
                            child: const Text('Register now!',
                                style: TextStyle(
                                    fontSize: 15,
                                    fontFamily: 'sf_pro_display_regular',
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (_isLoading) _buildLoader(),
          ],
        ),
      ),
    );
  }
}

class DismissKeyboard extends StatelessWidget {
  final Widget child;

  const DismissKeyboard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus &&
            currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
