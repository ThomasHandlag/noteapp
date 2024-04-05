import 'package:flutter/material.dart';

class FirstScreenSlide extends StatefulWidget {
  final int id;
  const FirstScreenSlide({super.key, required this.id});
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
            stops: [0.5, 1],
            colors: [
              Color.fromARGB(255, 19, 19, 32),
              Color.fromARGB(255, 50, 81, 255),
            ]),
      ),
      width: MediaQuery.of(context).size.width,
      alignment: Alignment.center,
      child: Text("${widget.id}"),
    );
  }
}
