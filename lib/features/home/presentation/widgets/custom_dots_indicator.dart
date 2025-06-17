import 'package:flutter/material.dart';

class CustomDotsIndicator extends StatelessWidget {
  const CustomDotsIndicator({
    super.key,
    required this.currentIndex,
    required this.length,
  });

  final int currentIndex;
  final int length;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
        length,
        (index) => Flexible(
          child: Container(
            width: 8,
            height: 8,
            decoration: ShapeDecoration(
              color: currentIndex == index ? Colors.white : Colors.grey,
              shape: const CircleBorder(),
            ),
            margin: const EdgeInsets.all(4),
          ),
        ),
      ),
    );
  }
}
