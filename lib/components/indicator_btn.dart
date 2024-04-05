import 'package:flutter/material.dart';

class IndicatorButton extends StatefulWidget {
  const IndicatorButton(
      {super.key,
      required this.onPressed,
      required this.index,
      this.isActive = false});
  final VoidCallback onPressed;
  final int index;
  final bool? isActive;
  @override
  State<StatefulWidget> createState() => _IndicatorButtonState();
}

class _IndicatorButtonState extends State<IndicatorButton> {
  final double _width = 40.0;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget.onPressed();
      },
      child: widget.isActive == true ? AnimatedContainer(
        width: _width,
        height: 15.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ) : AnimatedContainer(
        width: 15.0,
        height: 15.0,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
        duration: const Duration(seconds: 1),
        curve: Curves.fastOutSlowIn,
      ),
    );
  }
}