import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/components/language_drop_down.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key, required this.showHomeScreen});

  final VoidCallback showHomeScreen;

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectedCountryFrom;
  String? selectedCountryTo;

  // Function to Update Selected Country From
  void _handleSelectedCountryFrom(String? newSelectedCountryFrom) {
    setState(() {
      selectedCountryFrom = newSelectedCountryFrom;
    });
  }

  // Function to Update Selected Country To
  void _handleSelectedCountryTo(String? newSelectedTo) {
    setState(() {
      selectedCountryFrom = newSelectedTo;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: kIsWeb ? 10.h : 30.h, left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: ScreenUtil().screenWidth,
              // decoration: BoxDecoration(
              //   border: Border(
              //     bottom: BorderSide(color: Colors.black.withOpacity(0.5), width: 0.2),
              //   ),
              // ),
              padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
              // margin: EdgeInsets.only(left: 10.w, right: 10.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Text Translation",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF000000),
                    ),
                  ),
                  const Icon(
                    Icons.text_fields_outlined,
                    size: 22,
                    color: Color(0xFF000000),
                  ),
                ],
              ),
            ),
            Container(
              width: ScreenUtil().screenWidth,
              padding: EdgeInsets.only(top: kIsWeb ? 50.h : 30.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Drop Down for Selected Country Language From
                  SizedBox(
                    width: ScreenUtil().screenWidth / 2.4,
                    child: LanguageDropDown(
                      onLanguageChanged: _handleSelectedCountryFrom,
                      hintText: "From",
                    ),
                  ),

                  // Swap Button
                  const Icon(Icons.swap_horiz_outlined),

                  // Drop Down for Selected Country Language To
                  SizedBox(
                    width: ScreenUtil().screenWidth / 2.4,
                    child: LanguageDropDown(
                      onLanguageChanged: _handleSelectedCountryTo,
                      hintText: "To",
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
