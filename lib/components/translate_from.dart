import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/controllers/prompt_screen_controller.dart';

class TranslateFrom extends GetView<PromptScreenController> {
  const TranslateFrom({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField for Translate From
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              controller: controller.textEditingController,
              maxLines: 7,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
              ),
              decoration: InputDecoration(
                hintText: "Have Something To Translate?",
                hintStyle: GoogleFonts.poppins(
                  fontSize: 14,
                  color: Colors.black.withOpacity(0.3),
                ),
                contentPadding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                border: InputBorder.none,
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 20,
        ),

        // Divider
        Container(
          decoration: BoxDecoration(
            border: Border(
              top: BorderSide(
                color: Colors.black.withOpacity(0.1),
              ),
            ),
          ),
        ),

        const SizedBox(
          height: 10,
        ),

        // Word Count and Listen, Stop Button
        Obx(
          () {
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Words Count, Words Limit
                Text(
                  "${controller.wordsCount.value} / ${controller.wordsLimit} Words",
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF000000),
                  ),
                ),

                // Speak, Mute Button
                GestureDetector(
                  onTap: () {
                    if (controller.isSpeakingFrom.value) {
                      controller.stopSpeaking();
                    } else {
                      controller.textToSpeechFrom();
                    }
                  },
                  child: Icon(
                    controller.isSpeakingFrom.value ? Icons.stop_circle_outlined : Icons.volume_up_outlined,
                    size: 24,
                    color: const Color(0xFF000000),
                  ),
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}
