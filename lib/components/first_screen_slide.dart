import 'package:flutter/material.dart';

class FirstScreenSlide extends StatefulWidget {
  final String imagePath;
  final int id;
  const FirstScreenSlide(
      {super.key, required this.id, required this.imagePath});
  @override
  State<StatefulWidget> createState() => _FirstScreenSlideState();
}

class _FirstScreenSlideState extends State<FirstScreenSlide> {
  @override
  Widget build(BuildContext context) {
    return Container(
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
            image: DecorationImage(image: AssetImage('assets/images/sl_bg.png'), fit: BoxFit.fill),
      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.topCenter,
      padding:  EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.18),
      child: Image.asset(widget.imagePath),
    );
  }
}
