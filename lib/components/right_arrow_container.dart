import 'package:flutter/material.dart';

class RightArrowContainer extends StatelessWidget {
  const RightArrowContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: 50,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.brown.withOpacity(0.8),
      ),
      child: Container(
        height: 30,
        width: 30,
        padding: const EdgeInsets.all(2),
        decoration: const BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
        ),
        child: Icon(
          Icons.arrow_forward,
          color: Colors.brown.withOpacity(0.8),
          size: 20,
        ),
      ),
    );
  }
}
