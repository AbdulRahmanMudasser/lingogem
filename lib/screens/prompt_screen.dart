import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:lingogem/components/language_drop_down.dart';
import 'package:lingogem/components/translate_from.dart';
import 'package:lingogem/components/translate_to.dart';

class PromptScreen extends StatefulWidget {
  const PromptScreen({super.key, required this.showHomeScreen});

  final VoidCallback showHomeScreen;

  @override
  State<PromptScreen> createState() => _PromptScreenState();
}

class _PromptScreenState extends State<PromptScreen> {
  String? selectedCountryFrom;
  String? selectedCountryTo;

  late TextEditingController textEditingController;

  String? translatedText;

  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    textEditingController = TextEditingController();
  }

  @override
  void dispose() {
    textEditingController.dispose();
    super.dispose();
  }

  // Function to Update Selected Country From
  void _handleSelectedCountryFrom(String? newSelectedCountryFrom) {
    setState(() {
      selectedCountryFrom = newSelectedCountryFrom;
    });
  }

  // Function to Update Selected Country To
  void _handleSelectedCountryTo(String? newSelectedTo) {
    setState(() {
      selectedCountryTo = newSelectedTo;
    });
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

  // Function to Translate
  Future<void> translateLanguageToAnother() async {
    final apiKey = dotenv.env["API_KEY"];

    if (apiKey == null) {
      debugPrint("No API Key Environment Variable");
      return;
    }

    final inputText = textEditingController.text;
    final fromLanguage = selectedCountryFrom;
    final toLanguage = selectedCountryTo;

    setState(() {
      isLoading = true;
    });

    try {
      final model = GenerativeModel(model: 'gemini-1.5-flash', apiKey: apiKey);

      final prompt = [
        Content.text(
            "Translate only $inputText from $fromLanguage to $toLanguage. Just provide the translation in $toLanguage"),
      ];

      final response = await model.generateContent(prompt);

      if (response.text != null) {
        setState(() {
          translatedText = response.text;
        });
      }
    } catch (exception) {
      debugPrint("Translation Failed: $exception");
      _showSnackBar("Failed to Translate Text");
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.only(top: kIsWeb ? 10.h : 30.h, left: 10.w, right: 10.w),
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
                padding: EdgeInsets.only(top: 15.h, bottom: 15.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Language Translation",
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
                padding: EdgeInsets.only(top: kIsWeb ? 50.h : 40.h),
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

              SizedBox(
                height: 30.h,
              ),

              // Selected Language From Text
              Row(
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
                    selectedCountryFrom ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
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
                child: TranslateFrom(
                  textEditingController: textEditingController,
                ),
              ),

              SizedBox(
                height: 20.h,
              ),

              // Selected Language To Text
              Row(
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
                    selectedCountryTo ?? "",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                ],
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
                child: isLoading
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
                        translatedText: translatedText ?? "",
                      ),
              ),

              SizedBox(
                height: 30.h,
              ),

              GestureDetector(
                onTap: () {
                  if (selectedCountryFrom == null || selectedCountryFrom!.isEmpty) {
                    _showSnackBar("Select a Language to Translate From");
                    return;
                  }

                  if (selectedCountryTo == null || selectedCountryTo!.isEmpty) {
                    _showSnackBar("Select a Language to Translate To");
                    return;
                  }

                  if (textEditingController.text.trim().isEmpty) {
                    _showSnackBar("Input Text You Want to Translate");
                    return;
                  }

                  translateLanguageToAnother();
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
                    "Translate ?",
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
