import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_button.dart';
import 'package:foodify/components/my_text_field.dart';
import 'package:foodify/components/my_text_form_field.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController userNameController = TextEditingController();
  bool _isLoading = false;
  GlobalKey<FormState> formKey = GlobalKey();

  Widget _buildLoader() {
    return Center(
        child: CircularProgressIndicator(
      backgroundColor: Theme.of(context).colorScheme.inversePrimary,
    ));
  }

  void register() async {
    final auth = FirebaseAuth.instance;
    final String email = emailController.text;
    final String password = passwordController.text;
    setState(() {
      _isLoading = true;
    });
    if (passwordController.text == confirmPasswordController.text) {
      try {
        if (formKey.currentState!.validate()) {
          await auth.createUserWithEmailAndPassword(
              email: email, password: password);
          auth.currentUser!.updateDisplayName(userNameController.text);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'email-already-in-use') {
          showCupertinoDialog(
            barrierDismissible: true,
            context: mounted ? context : context,
            builder: (context) {
              return CupertinoAlertDialog(
                title: Text(
                  'E-mail address already used',
                  style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                content: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Text(
                    'Try signing up with another account',
                    style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Theme.of(context).colorScheme.error),
                  ),
                ),
              );
            },
          );
        }
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        behavior: SnackBarBehavior.floating,
        padding: const EdgeInsets.all(10),
        backgroundColor: Theme.of(context).colorScheme.error,
        content: const Text(
          'Passwords does not match',
          style: TextStyle(fontFamily: 'sf_pro_display_regular'),
        ),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return DismissKeyboard(
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        body: Center(
          child: Stack(children: [
            SingleChildScrollView(
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

                    Text(
                      'Foodify',
                      style: TextStyle(
                          fontSize: 30,
                          fontFamily: 'sf_pro_display_regular',
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    //welcoming message
                    Text(
                      'Let\'s make you an account:',
                      style: TextStyle(
                          fontSize: 15,
                          fontFamily: 'sf_pro_display_regular',
                          color: Theme.of(context).colorScheme.inversePrimary),
                    ),

                    const SizedBox(
                      height: 60,
                    ),
                    Container(
                      margin: const EdgeInsets.symmetric(horizontal: 25),
                      child: Form(
                        autovalidateMode: AutovalidateMode.onUnfocus,
                        key: formKey,
                        child: Column(
                          children: [
                            MyTextFormField(
                              hintText: 'User Name',
                              controller: userNameController,
                              inputType: TextInputType.text,
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            //email text field
                            MyTextFormField(
                              controller: emailController,
                              hintText: "E-Mail",
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

                            const SizedBox(
                              height: 15,
                            ),

                            //password text field
                            MyTextFormField(
                              controller: confirmPasswordController,
                              hintText: "Confirm password",
                              inputType: TextInputType.visiblePassword,
                            ),

                            const SizedBox(
                              height: 20,
                            ),

                            //signin button
                          ],
                        ),
                      ),
                    ),
                    DismissKeyboard(
                      child: MyButton(
                        text: 'Sign up',
                        margin: const EdgeInsets.symmetric(horizontal: 25),
                        onTap: () {
                          register();
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
                          'Already have an account? ',
                          style: TextStyle(
                              fontSize: 15,
                              fontFamily: 'sf_pro_display_regular',
                              color:
                                  Theme.of(context).colorScheme.inversePrimary),
                        ),
                        InkWell(
                          onTap: widget.onTap,
                          child: const Text('Login now!',
                              style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: 'sf_pro_display_regular',
                                  fontWeight: FontWeight.bold)),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            if (_isLoading) _buildLoader(),
          ]),
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
