import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/components/language_drop_down.dart';
import 'package:lingogem/components/translate_from.dart';
import 'package:lingogem/components/translate_to.dart';
import 'package:lingogem/controllers/prompt_screen_controller.dart';

class PromptScreen extends GetView<PromptScreenController> {
  const PromptScreen({super.key, required this.showHomeScreen});

  final VoidCallback showHomeScreen;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(
          top: kIsWeb ? 0.h : 30.h,
          left: kIsWeb ? 40.w : 10.w,
          right: kIsWeb ? 40.w : 10.w,
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: ScreenUtil().screenWidth,
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(color: Colors.black.withOpacity(0.5), width: 0.2),
                  ),
                ),
                padding: EdgeInsets.only(top: kIsWeb ? 25.h : 15.h, bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Language Translation Text
                    Text(
                      "Language Translation",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF000000),
                      ),
                    ),

                    // Icon
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
                padding: EdgeInsets.only(top: kIsWeb ? 30.h : 40.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: kIsWeb ? CrossAxisAlignment.end : CrossAxisAlignment.center,
                  children: [
                    // Drop Down for Selected Country Language From
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (kIsWeb)
                          Text(
                            "Select a Language to Translate From",
                            style: GoogleFonts.poppins(
                              fontSize: kIsWeb ? 14.sp : 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        if (kIsWeb)
                          SizedBox(
                            height: 20.h,
                          ),
                        SizedBox(
                          width: ScreenUtil().screenWidth / 2.4,
                          child: LanguageDropDown(
                            onLanguageChanged: controller.handleSelectedCountryFrom,
                            hintText: "From",
                          ),
                        ),
                      ],
                    ),

                    // Swap Button
                    const Column(
                      children: [
                        Icon(Icons.swap_horiz_outlined),
                        SizedBox(
                          height: 15,
                        ),
                      ],
                    ),

                    // Drop Down for Selected Country Language To
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (kIsWeb)
                          Text(
                            "Select a Language to Translate To",
                            style: GoogleFonts.poppins(
                              fontSize: kIsWeb ? 14.sp : 14,
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                            ),
                          ),
                        if (kIsWeb)
                          SizedBox(
                            height: 20.h,
                          ),
                        SizedBox(
                          width: ScreenUtil().screenWidth / 2.4,
                          child: LanguageDropDown(
                            onLanguageChanged: controller.handleSelectedCountryTo,
                            hintText: "To",
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              if (kIsWeb)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selected Language From Text
                        Obx(
                          () {
                            return Row(
                              children: [
                                Text(
                                  "Translate From",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.selectedCountryFrom.value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        // Selected Language From TextField
                        Container(
                          width: ScreenUtil().screenWidth / 2.4,
                          height: 220.h,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                              width: 0.1,
                            ),
                          ),
                          child: const TranslateFrom(),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Selected Language To Text
                        Obx(
                          () {
                            return Row(
                              children: [
                                Text(
                                  "Translate To",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w300,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  controller.selectedCountryTo.value,
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            );
                          },
                        ),

                        SizedBox(
                          height: 20.h,
                        ),

                        // Selected Language To TextField
                        Container(
                          width: ScreenUtil().screenWidth / 2.4,
                          height: 220.h,
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey.withOpacity(0.05),
                            border: Border.all(
                              color: Colors.black.withOpacity(0.5),
                              width: 0.1,
                            ),
                          ),
                          child: Obx(
                            () {
                              return controller.isLoading.value
                                  ? Center(
                                      child: Container(
                                        padding: const EdgeInsets.all(12),
                                        height: 50,
                                        width: 50,
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const CircularProgressIndicator(
                                          color: Colors.black,
                                          strokeWidth: 2,
                                        ),
                                      ),
                                    )
                                  : TranslateTo(
                                      translatedText: controller.translatedText.value,
                                    );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    // Selected Language From Text
                    Obx(
                      () {
                        return Row(
                          children: [
                            Text(
                              "Translate From",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.selectedCountryFrom.value,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    // Selected Language From TextField
                    Container(
                      width: ScreenUtil().screenWidth,
                      height: 220.h,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          width: 0.1,
                        ),
                      ),
                      child: const TranslateFrom(),
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    // Selected Language To Text
                    Obx(
                      () {
                        return Row(
                          children: [
                            Text(
                              "Translate To",
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w300,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              controller.selectedCountryTo.value,
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        );
                      },
                    ),

                    SizedBox(
                      height: 20.h,
                    ),

                    // Selected Language To TextField
                    Container(
                      width: ScreenUtil().screenWidth,
                      height: 220.h,
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.withOpacity(0.05),
                        border: Border.all(
                          color: Colors.black.withOpacity(0.5),
                          width: 0.1,
                        ),
                      ),
                      child: Obx(
                        () {
                          return controller.isLoading.value
                              ? Center(
                                  child: Container(
                                    padding: const EdgeInsets.all(12),
                                    height: 50,
                                    width: 50,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                    ),
                                    child: const CircularProgressIndicator(
                                      color: Colors.black,
                                      strokeWidth: 2,
                                    ),
                                  ),
                                )
                              : TranslateTo(
                                  translatedText: controller.translatedText.value,
                                );
                        },
                      ),
                    ),
                  ],
                ),
              SizedBox(
                height: kIsWeb ? 35.h : 30.h,
              ),
              GestureDetector(
                onTap: () {
                  controller.translateLanguageToAnother();
                },
                child: Container(
                  width: kIsWeb ? 150 : ScreenUtil().screenWidth - 50,
                  height: 35,
                  margin: const EdgeInsets.only(top: 20),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Text(
                    "Translate",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
