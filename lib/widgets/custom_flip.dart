// ignore_for_file: prefer_const_constructors_in_immutables

import 'dart:math';

import 'package:flutter/material.dart';

class CustomFlipCard extends StatefulWidget {
  CustomFlipCard({
    Key? key,
    required this.front,
    required this.back,
  }) : super(key: key);
  final Image front;
  final Image back;
  @override
  _CustomFlipCardState createState() => _CustomFlipCardState();
}

class _CustomFlipCardState extends State<CustomFlipCard>
    with SingleTickerProviderStateMixin {
  late Animation<double> animation;
  late AnimationController controller;
  double dragPosition = 0;
  bool isFront = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    controller.addListener(() {
      dragPosition = animation.value;
      setImageSide();
    });

    controller.forward(from: 0);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final angle = (dragPosition / 180) * pi;
    final transform = Matrix4.identity()
      ..setEntry(3, 2, 0.001)
      ..rotateY(angle);

    return Scaffold(
     
      body: GestureDetector(
        onHorizontalDragUpdate: (d) => setState(() {
          dragPosition -= d.delta.dx;
          dragPosition %= 360;

          setImageSide();
        }),
        onHorizontalDragEnd: (d) {
          final double end = isFront ? (dragPosition > 180 ? 360 : 0) : 180;
          animation =
              Tween<double>(begin: dragPosition, end: end).animate(controller);
        },
        child: Transform(
          transform: transform,
          alignment: Alignment.center,
          child: isFront
              ? widget.front
              : Transform(
                  transform: Matrix4.identity()..rotateX(pi),
                  alignment: Alignment.center,
                  child: widget.back,
                ),
        ),
      ),
    );
  }

  void setImageSide() {
    if (dragPosition <= 90 || dragPosition >= 270) {
      isFront = true;
    } else {
      isFront = false;
    }
  }
}
