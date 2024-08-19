import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/components/country_rectangle_container.dart';
import 'package:lingogem/components/right_arrow_container.dart';
import 'package:lingogem/screens/prompt_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.showPromptScreen});

  final VoidCallback showPromptScreen;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: const BoxDecoration(
          // Background Image
          image: DecorationImage(
            image: AssetImage("assets/images/worldmap.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.only(
            top: 60.h,
            left: 10.w,
            right: 10.w,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                flex: 3,
                child: Center(
                  child: CountryRectangleContainer(),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(),
                        children: [
                          const TextSpan(
                            text: 'Translate',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Every\n',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.withOpacity(0.5),
                            ),
                          ),
                          const TextSpan(
                            text: 'Type Word\n',
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const WidgetSpan(
                            child: SizedBox(
                              height: 35,
                            ),
                          ),
                          TextSpan(
                            text: 'Help You Communicate In\n',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          TextSpan(
                            text: 'Different Languages\n',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) {
                                      return PromptScreen(showHomeScreen: widget.showPromptScreen);
                                    },
                                  ),
                                );
                              },
                              child: const RightArrowContainer()),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
