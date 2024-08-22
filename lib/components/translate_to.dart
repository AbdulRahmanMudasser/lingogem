import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/controllers/prompt_screen_controller.dart';

class TranslateTo extends GetView<PromptScreenController> {
  const TranslateTo({super.key, required this.translatedText});

  final String translatedText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Translated Text
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              translatedText,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
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

        // Word Count, Listen Button
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            // Copy to Clipboard Button
            GestureDetector(
              onTap: () => controller.copyToClipboard(translatedText),
              child: const Icon(
                Icons.content_copy_rounded,
                size: 20,
                color: Color(0xFF000000),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // Speak, Mute Button
            GestureDetector(
              onTap: () {
                if (controller.isSpeakingTo.value) {
                  controller.stopSpeaking();
                } else {
                  controller.textToSpeechTo();
                }
              },
              child: Obx(
                () {
                  return Icon(
                    controller.isSpeakingTo.value ? Icons.stop_circle_outlined : Icons.volume_up_outlined,
                    size: 24,
                    color: const Color(0xFF000000),
                  );
                },
              ),
            ),
          ],
        )
      ],
    );
  }
}
