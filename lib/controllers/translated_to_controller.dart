import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';

class TranslateToController extends GetxController {
  final FlutterTts flutterTts = FlutterTts();

  /// Variable to hold translated text
  var translatedText = ''.obs;

  /// Variable to track if TTS is speaking
  var isSpeaking = false.obs;

  @override
  void onInit() {
    super.onInit();

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
    flutterTts.stop();
    super.onClose();
  }

  /// Set the translated text
  void setTranslatedText(String text) {
    translatedText.value = text;
  }

  /// Text to Speech
  Future<void> textToSpeech() async {
    final text = translatedText.value.trim();
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

  /// Method to Copy Text to Clipboard
  void copyToClipboard(String text) {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text)).then(
        (_) => Get.snackbar(
          "Copied To Clipboard",
          "",
          snackPosition: SnackPosition.BOTTOM,
          margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
        ),
      );
    }
  }
}
