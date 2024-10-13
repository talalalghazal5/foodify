import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:foodify/components/my_checkout_tile.dart';
import 'package:foodify/components/my_text_form_field.dart';
import 'package:foodify/models/cart_item.dart';
import 'package:foodify/models/restaurant.dart';
import 'package:foodify/pages/delivery_progress_page.dart';
import 'package:provider/provider.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  late PageController _pageController;
  final GlobalKey<FormState> formKey = GlobalKey();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();


  bool isShown = false;
  late List<CartItem> userCart;
  late double totalCartCost;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _pageController.dispose();
  }

  void usetTappedPay() {
    if (formKey.currentState!.validate()) {
      showCupertinoModalPopup(
        barrierDismissible: true,
        filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
        context: context,
        builder: (context) {
          return CupertinoAlertDialog(
            actions: [
              TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text(
                    'Cancel',
                    style: TextStyle(
                      fontFamily: 'sf_pro_display_regular',
                    ),
                  )),
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        CupertinoPageRoute(
                            builder: (context) =>
                                const DeliveryProgressPage()));
                  },
                  child: Text(
                    'Pay now!',
                    style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Colors.green[700]),
                  ))
            ],
            title: const Text(
              'Do you want to confirm?',
              style: TextStyle(fontFamily: 'sf_pro_display_regular'),
            ),
            content: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Card holder name:',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Text(
                        '${firstNameController.text} ${lastNameController.text}',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Card number:',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Text(
                        cardNumberController.text,
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Total cart cost:',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Text(
                        '\$$totalCartCost',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Text(
                    textAlign: TextAlign.center,
                    '+ \$0.99 delivery fees',
                    style: TextStyle(
                        fontFamily: 'sf_pro_display_regular',
                        color: Theme.of(context).colorScheme.primary),
                  ),
                ),
                Divider(
                    indent: 5,
                    endIndent: 5,
                    color: Theme.of(context).colorScheme.primary),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Final order cost:',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                      Text(
                        '\$${(totalCartCost + 0.99).toStringAsFixed(2)}',
                        style: TextStyle(
                            fontFamily: 'sf_pro_display_regular',
                            color:
                                Theme.of(context).colorScheme.inversePrimary),
                      ),
                    ],
                  ),
                )
              ],
            ),
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<Restaurant>(
      builder: (context, restaurant, child) {
        userCart = restaurant.cart;
        totalCartCost = restaurant.totalCartCost;
        return DismissKeyboard(
          child: Scaffold(
            appBar: AppBar(
              leading: InkWell(
                child: Center(
                  child: FaIcon(FontAwesomeIcons.chevronLeft,
                      color: Theme.of(context).colorScheme.inversePrimary),
                ),
                onTap: () => Navigator.pop(context),
              ),
              title: Text(
                'Checkout',
                style: TextStyle(
                    fontFamily: 'sf_pro_display_regular',
                    color: Theme.of(context).colorScheme.inversePrimary,
                    fontWeight: FontWeight.bold),
              ),
              centerTitle: true,
            ),
            body: Column(
              children: [
                Expanded(
                    child: ListView(children: [
                  Container(
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Current balance:',
                            style: TextStyle(
                                color: Theme.of(context).colorScheme.primary,
                                fontFamily: 'sf_pro_display_regular',
                                fontWeight: FontWeight.bold,
                                fontSize: 18)),
                        Text(
                          '\$1000',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.primary,
                              fontFamily: 'sf_pro_display_regular',
                              fontWeight: FontWeight.bold,
                              fontSize: 18),
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                      alignment: Alignment.centerLeft,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 15),
                        child: Text(
                          'Your ordered food:',
                          style: TextStyle(
                              fontFamily: 'sf_pro_display_regular',
                              color: Theme.of(context).colorScheme.inversePrimary,
                              fontSize: 15),
                          textAlign: TextAlign.start,
                        ),
                      )),
                  Container(
                    padding: const EdgeInsets.all(5),
                    height: 240,
                    child: PageView(
                      controller: _pageController,
                      children: userCart.map((cartItem) {
                        return MyCheckoutTile(cartItem: cartItem);
                      }).toList(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 17.0, vertical: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border: Border.all(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .inversePrimary)),
                            child: IconButton(
                                onPressed: () {
                                  _pageController.previousPage(
                                      duration: const Duration(milliseconds: 400),
                                      curve: Curves.decelerate);
                                },
                                icon: FaIcon(
                                  FontAwesomeIcons.chevronLeft,
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary,
                                  size: 18,
                                ))),
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border: Border.all(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .inversePrimary)),
                          child: IconButton(
                              onPressed: () {
                                _pageController.nextPage(
                                    duration: const Duration(milliseconds: 400),
                                    curve: Curves.decelerate);
                              },
                              icon: FaIcon(
                                FontAwesomeIcons.chevronRight,
                                color:
                                    Theme.of(context).colorScheme.inversePrimary,
                                size: 18,
                              )),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                    indent: 10,
                    endIndent: 10,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                  const SizedBox(height: 10,),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 5),
                    child: Center(
                        child: Text(
                      'Please enter your information:',
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary,
                        fontFamily: 'sf_pro_display_regular',
                      ),
                    )),
                  ),
                  // P A Y I N G  F O R M:
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 0, vertical: 15),
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            Row(
                              // F U L L  N A M E:
                              children: [
                                Expanded(
                                    child: MyTextFormField(
                                      controller: firstNameController,
                                  hintText: 'First name',
                                  inputType: TextInputType.text,
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: MyTextFormField(
                                      controller: lastNameController,
                                        hintText: 'Last name',
                                        inputType: TextInputType.text)),
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                    child: MyTextFormField(
                                      controller: emailController,
                                        hintText: 'E-mail',
                                        inputType: TextInputType.emailAddress))
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                    child: MyTextFormField(
                                      controller: passwordController,
                                        hintText: 'Password',
                                        inputType: TextInputType.visiblePassword))
                              ],
                            ),
                            const SizedBox(height: 10,),
                            Row(
                              children: [
                                Expanded(
                                    child: MyTextFormField(
                                      controller: cardNumberController,
                                        hintText: 'Credit card number',
                                        inputType: TextInputType.number))
                              ],
                            ),
                          ],
                        )),
                  ),
                  const Spacer(),
                ])),
                Container(
                    width: 1000,
                    height: 90,
                    padding: const EdgeInsets.all(15),
                    child: CupertinoButton(
                      onPressed: () {
                        usetTappedPay();
                      },
                      color: Colors.green[700],
                      child: const Text(
                        'Pay now',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'sf_pro_display_regular'),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        );
      },
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
        if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: child,
    );
  }
}
