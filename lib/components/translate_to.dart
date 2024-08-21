import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslateTo extends StatefulWidget {
  const TranslateTo({super.key, required this.translatedText});

  final String translatedText;

  @override
  State<TranslateTo> createState() => _TranslateToState();
}

class _TranslateToState extends State<TranslateTo> {
  final FlutterTts flutterTts = FlutterTts();

  /// Text to Speech
  Future<void> textToSpeech() async {
    final text = widget.translatedText.trim();

    // flutterTts.setVolume(100);

    await flutterTts.speak(text);
  }

  /// Method to Copy
  void copyToClipboard(String text) {
    if (text.isEmpty) {
      return;
    } else {
      Clipboard.setData(ClipboardData(text: text)).then(
        (value) => _showSnackBar("Copied To Clipboard"),
      );
    }
  }

  // Show SnackBar
  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Text(
              widget.translatedText,
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
              onTap: () => copyToClipboard(widget.translatedText),
              child: const Icon(
                Icons.content_copy_rounded,
                size: 20,
                color: Color(0xFF000000),
              ),
            ),

            const SizedBox(
              width: 10,
            ),

            // Speak Button
            GestureDetector(
              onTap: () => textToSpeech(),
              child: const Icon(
                Icons.volume_up_outlined,
                size: 24,
                color: Color(0xFF000000),
              ),
            ),
          ],
        )
      ],
    );
  }
}
