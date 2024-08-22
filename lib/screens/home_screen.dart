import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/components/country_rectangle_container.dart';
import 'package:lingogem/components/get_started_button.dart';
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
        padding: EdgeInsets.only(
          top: 60.h,
          left: 10.w,
          right: 10.w,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!kIsWeb)
              const Expanded(
                flex: 2,
                child: Center(
                  child: CountryRectangleContainer(),
                ),
              )
            else
              const Align(
                alignment: Alignment.topCenter,
                child: CountryRectangleContainer(),
              ),
            if (!kIsWeb)
              Expanded(
                flex: 2,
                child: Column(
                  children: [
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        style: GoogleFonts.poppins(),
                        children: [
                          TextSpan(
                            text: 'Translate',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          TextSpan(
                            text: ' Every\n',
                            style: TextStyle(
                              fontSize: 30.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.brown.withOpacity(0.5),
                            ),
                          ),
                          TextSpan(
                            text: 'Type Word\n',
                            style: TextStyle(
                              fontSize: 28.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          WidgetSpan(
                            child: SizedBox(
                              height: 35.sh,
                            ),
                          ),
                          TextSpan(
                            text: 'Help You Communicate In\n',
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w300,
                              color: Colors.black.withOpacity(0.5),
                            ),
                          ),
                          TextSpan(
                            text: 'Different Languages\n',
                            style: TextStyle(
                              fontSize: 14.sp,
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
                            child: Container(
                              width: ScreenUtil().screenWidth - 50,
                              height: 35,
                              margin: const EdgeInsets.only(top: 20),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Text(
                                "Get Started",
                                style: GoogleFonts.poppins(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize: 16.sp,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                height: 120.h,
                margin: EdgeInsets.symmetric(vertical: 100.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            style: GoogleFonts.poppins(),
                            children: [
                              TextSpan(
                                text: 'Translate',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                              TextSpan(
                                text: ' Every\n',
                                style: TextStyle(
                                  fontSize: 30.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.brown.withOpacity(0.5),
                                ),
                              ),
                              TextSpan(
                                text: 'Type Word',
                                style: TextStyle(
                                  fontSize: 28.sp,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 2,
                      height: 100,
                      margin: const EdgeInsets.symmetric(horizontal: 50),
                      color: Colors.black.withOpacity(0.5),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          style: GoogleFonts.poppins(),
                          children: [
                            TextSpan(
                              text: 'Help You Communicate In\n',
                              style: TextStyle(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                            TextSpan(
                              text: 'Different ',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.brown.withOpacity(0.5),
                              ),
                            ),
                            TextSpan(
                              text: 'Languages',
                              style: TextStyle(
                                fontSize: 28.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (kIsWeb)
              GetStartedButton(
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
              ),
          ],
        ),
      ),
    );
  }
}
