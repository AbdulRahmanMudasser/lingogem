import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:google_fonts/google_fonts.dart';

class TranslateFrom extends StatefulWidget {
  const TranslateFrom({super.key, required this.textEditingController});

  final TextEditingController textEditingController;

  @override
  State<TranslateFrom> createState() => _TranslateFromState();
}

class _TranslateFromState extends State<TranslateFrom> {
  /// Variable to Hold Count of Word
  int wordsCount = 0;

  /// Variable to Hold Limit of Total Words
  final int wordsLimit = 100;

  final FlutterTts flutterTts = FlutterTts();

  /// Method to Count Words
  int countWords(String text) {
    if (text.isEmpty) {
      return 0;
    } else {
      return text.trim().split(RegExp(r'\s+')).length;
    }
  }

  /// Method to Update Word Count
  void updateWordCount() {
    final text = widget.textEditingController.text;

    setState(() {
      wordsCount = countWords(text);
    });

    if (wordsCount > wordsLimit) {
      // Truncate Text if Work Limit Exceeded
      widget.textEditingController.value = widget.textEditingController.value.copyWith(
        text: _truncateTextToWordLimit(text, wordsLimit),
        selection: TextSelection.fromPosition(
          TextPosition(offset: widget.textEditingController.text.length),
        ),
      );

      wordsCount = wordsLimit;
    }
  }

  /// Truncate Text to Word Limit
  String _truncateTextToWordLimit(String text, int wordsLimit) {
    final splittedWords = text.trim().split(RegExp(r'\s+'));

    if (splittedWords.length <= wordsLimit) {
      return text;
    } else {
      return splittedWords.take(wordsLimit).join(' ');
    }
  }

  /// Text to Speech
  Future<void> textToSpeech() async {
    final text = widget.textEditingController.text.trim();

    flutterTts.setVolume(100);

    await flutterTts.speak(text);
  }

  @override
  void initState() {
    super.initState();

    widget.textEditingController.addListener(updateWordCount);
  }

  @override
  void dispose() {
    widget.textEditingController.removeListener(updateWordCount);

    widget.textEditingController.dispose();

    flutterTts.stop();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // TextField for Translate From
        Expanded(
          child: SingleChildScrollView(
            child: TextField(
              controller: widget.textEditingController,
              maxLines: 7,
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: Colors.black.withOpacity(0.5),
              ),
              // onChanged: (value) => updateWordCount(),
              decoration: InputDecoration(
                hintText: "Have Something To Translate ?",
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

        // Word Count, Listen Button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "$wordsCount / $wordsLimit Words",
              style: GoogleFonts.poppins(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: const Color(0xFF000000),
              ),
            ),
            GestureDetector(
              onTap: () => textToSpeech(),
              child: const Icon(
                Icons.volume_up_outlined,
                size: 24,
                color: Color(0xFF000000),
              ),
            )
          ],
        )
      ],
    );
  }
}
