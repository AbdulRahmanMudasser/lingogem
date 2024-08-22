import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TranslateFromController extends GetxController {
  /// Variable to Hold Count of Word
  var wordsCount = 0.obs;

  /// Variable to Hold Limit of Total Words
  final int wordsLimit = 100;

  final FlutterTts flutterTts = FlutterTts();

  /// Variable to Track if TTS is Speaking
  var isSpeaking = false.obs;

  late TextEditingController textEditingController;

  @override
  void onInit() {
    super.onInit();

    textEditingController = TextEditingController();

    textEditingController.addListener(updateWordCount);

    // Initialize TTS handlers
    flutterTts.setStartHandler(() {
      isSpeaking.value = true;
      debugPrint("TTS started");
    });

    flutterTts.setCompletionHandler(() {
      isSpeaking.value = false;
      debugPrint("TTS completed");
    });

    flutterTts.setCancelHandler(() {
      isSpeaking.value = false;
      debugPrint("TTS canceled");
    });
  }

  @override
  void onClose() {
    textEditingController.removeListener(updateWordCount);
    flutterTts.stop();
    textEditingController.dispose();
    super.onClose();
  }

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
    final text = textEditingController.text;

    wordsCount.value = countWords(text);

    if (wordsCount.value > wordsLimit) {
      // Truncate Text if Word Limit Exceeded
      textEditingController.value = textEditingController.value.copyWith(
        text: _truncateTextToWordLimit(text, wordsLimit),
        selection: TextSelection.fromPosition(
          TextPosition(offset: textEditingController.text.length),
        ),
      );

      wordsCount.value = wordsLimit;
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
    final text = textEditingController.text.trim();

    if (text.isNotEmpty) {
      isSpeaking.value = true;
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
      isSpeaking.value = false;
    }
  }

  /// Stop Speaking
  Future<void> stopSpeaking() async {
    isSpeaking.value = false;
    await flutterTts.stop();
  }
}
