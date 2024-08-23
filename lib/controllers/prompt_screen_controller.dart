import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';

class PromptScreenController extends GetxController {
  late TextEditingController textEditingController;

  var selectedCountryFrom = 'English - US'.obs;
  var selectedCountryTo = 'Urdu'.obs;

  var translatedText = RxString('');

  RxBool isLoading = false.obs;

  /// Variable to Hold Count of Word
  var wordsCount = 0.obs;

  /// Variable to Hold Limit of Total Words
  final int wordsLimit = 100;

  final FlutterTts flutterTts = FlutterTts();

  /// Variable to Track if TTS is Speaking
  var isSpeakingFrom = false.obs;
  var isSpeakingTo = false.obs;

  /// Set the translated text
  void setTranslatedText(String text) {
    translatedText.value = text;
  }

  @override
  void onInit() {
    super.onInit();
    textEditingController = TextEditingController();

    textEditingController.addListener(updateWordCount);

    // Initialize TTS handlers for "Translate From"
    // flutterTts.setStartHandler(() {
    //   if (!isSpeakingFrom.value) {
    //     isSpeakingFrom.value = true;
    //     debugPrint("TTS Started for Translate From");
    //   }
    //
    //   if (!isSpeakingTo.value) {
    //     isSpeakingTo.value = true;
    //     debugPrint("TTS Started for Translate To");
    //   }
    // });
    //
    // flutterTts.setCompletionHandler(() {
    //   if (isSpeakingFrom.value) {
    //     isSpeakingFrom.value = false;
    //     debugPrint("TTS Completed for Translate From");
    //   }
    //
    //   if (isSpeakingTo.value) {
    //     isSpeakingTo.value = false;
    //     debugPrint("TTS Completed for Translate To");
    //   }
    // });
    //
    // flutterTts.setCancelHandler(() {
    //   if (isSpeakingFrom.value) {
    //     isSpeakingFrom.value = false;
    //     debugPrint("TTS Cancelled for Translate From");
    //   }
    //
    //   if (isSpeakingTo.value) {
    //     isSpeakingTo.value = false;
    //     debugPrint("TTS Cancelled for Translate To");
    //   }
    // });
  }

  @override
  void dispose() {
    textEditingController.dispose();
    textEditingController.removeListener(updateWordCount);
    flutterTts.stop();
    super.dispose();
  }

  /// Method to Copy Text to Clipboard
  void copyToClipboard(String text) {
    if (text.isNotEmpty) {
      Clipboard.setData(ClipboardData(text: text)).then(
        (_) => showSnackBar("Copied To Clipboard"),
      );
    }
  }

  // Function to Update Selected Country From
  void handleSelectedCountryFrom(String? newSelectedCountryFrom) {
    selectedCountryFrom.value = newSelectedCountryFrom ?? '';
  }

  // Function to Update Selected Country To
  void handleSelectedCountryTo(String? newSelectedCountryTo) {
    selectedCountryTo.value = newSelectedCountryTo ?? '';
  }

  // Show SnackBar
  void showSnackBar(String message) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: GoogleFonts.poppins(fontSize: 12, color: Colors.white),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // Function to Translate
  Future<void> translateLanguageToAnother() async {
    final apiKey = dotenv.env["API_KEY"];

    if (apiKey == null) {
      debugPrint("No API Key Environment Variable");
      return;
    }

    final inputText = textEditingController.text.trim();
    final fromLanguage = selectedCountryFrom.value;
    final toLanguage = selectedCountryTo.value;

    if (fromLanguage.isEmpty) {
      showSnackBar("Select a Language to Translate From");
      return;
    }

    if (toLanguage.isEmpty) {
      showSnackBar("Select a Language to Translate To");
      return;
    }

    if (inputText.isEmpty) {
      showSnackBar("Input Text You Want to Translate");
      return;
    }

    isLoading.value = true;

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      final prompt = [
        Content.text(
            "You are a translation model. Your task is to translate the following text from $fromLanguage to $toLanguage:\n\n"
            "Input: \"$inputText\"\n\n"
            "Please return only the translated text in $toLanguage. "
            "If the input text is not a valid word or sentence in $fromLanguage, respond with: 'Please input a valid word or sentence.'"),
      ];

      final response = await model.generateContent(prompt);

      if (response.text != null) {
        translatedText.value = response.text!;
      }
    } catch (exception) {
      debugPrint("Translation Failed: $exception");
      showSnackBar("Failed to Translate Text");
    } finally {
      isLoading.value = false;
    }
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

  // Method to handle text-to-speech for "Translate From"
  Future<void> textToSpeechFrom() async {
    final text = textEditingController.text.trim();

    if (text.isNotEmpty) {
      isSpeakingFrom.value = true;
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
      isSpeakingFrom.value = false;
    }
  }

  // Method to handle text-to-speech for "Translate To"
  Future<void> textToSpeechTo() async {
    final text = translatedText.value.trim();

    if (text.isNotEmpty) {
      isSpeakingTo.value = true;
      await flutterTts.setVolume(1.0);
      await flutterTts.speak(text);
      await flutterTts.awaitSpeakCompletion(true);
      isSpeakingTo.value = false;
    }
  }

  // Stop speaking for both "Translate From" and "Translate To"
  Future<void> stopSpeaking() async {
    isSpeakingFrom.value = false;
    isSpeakingTo.value = false;
    await flutterTts.stop();
  }

  // Swapping Languages
  void swappingLanguages() {
    String temp = selectedCountryFrom.value;
    selectedCountryFrom.value = selectedCountryTo.value;
    selectedCountryTo.value = temp;
  }
}
