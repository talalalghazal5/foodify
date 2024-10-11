import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_button.dart';
import 'package:foodify/components/my_text_field.dart';
import 'package:foodify/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  final Function()? onTap;
  const LoginPage({super.key, this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
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
              'Foodify delivery app',
              style: TextStyle(
                  fontSize: 15,
                  fontFamily: 'sf_pro_display_regular',
                  color: Theme.of(context).colorScheme.inversePrimary),
            ),

            const SizedBox(
              height: 60,
            ),
            //email text field
            MyTextField(
                controller: emailController,
                hintText: "E-mail",
                obscureText: false),

            const SizedBox(
              height: 15,
            ),

            //password text field
            MyTextField(
                controller: passwordController,
                hintText: "Password",
                obscureText: true),
            const SizedBox(
              height: 20,
            ),
            //signin button
            MyButton(
              text: 'Sign in',
              margin: const EdgeInsets.symmetric(horizontal: 25),
              onTap: () {
                Navigator.push(context,
                    CupertinoPageRoute(builder: (context) => const HomePage()));
              },
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
                      color: Theme.of(context).colorScheme.inversePrimary),
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
    );
  }
}
