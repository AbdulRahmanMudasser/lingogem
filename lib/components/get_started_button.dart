import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class GetStartedButton extends StatelessWidget {
  const GetStartedButton({
    super.key,
    required this.onTap,
  });

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 150,
        height: 35,
        margin: const EdgeInsets.only(top: 20),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.8),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Text(
          "Get Started",
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.w300,
            color: Colors.white,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
