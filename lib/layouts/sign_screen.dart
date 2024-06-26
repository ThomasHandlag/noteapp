import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:noteapp/layouts/sign_in_screen.dart';
import 'dart:developer' as dev;
import 'package:noteapp/layouts/sign_up_screen.dart';

class SignScreen extends StatefulWidget {
  const SignScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignScreen> {
  final CarouselController _carouselController = CarouselController();

  void press() {
    _carouselController.nextPage();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: [
                  0.5,
                  1
                ],
                colors: [
                  Color.fromARGB(255, 19, 19, 32),
                  Color.fromARGB(255, 50, 81, 255),
                ]),
            image: DecorationImage(
                image: AssetImage('assets/images/sl_bg.png'), fit: BoxFit.fill),
          ),
          child: CarouselSlider(
            carouselController: _carouselController,
            items: [SignInScreen(onPress: press,), SignUpScreen(onPress: press)],
            options: CarouselOptions(
              height: MediaQuery.of(context).size.height,
              viewportFraction: 1.0,
              initialPage: 2,
            ),
          )),
    );
  }
}
