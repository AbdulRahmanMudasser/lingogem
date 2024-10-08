import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lingogem/data/countries_data.dart';

class LanguageDropDown extends StatelessWidget {
  const LanguageDropDown({
    super.key,
    required this.onLanguageChanged,
    required this.hintText,
    required this.selectedCountry,
  });

  final ValueChanged<String?> onLanguageChanged;
  final String hintText;
  final String? selectedCountry;

  @override
  Widget build(BuildContext context) {
    return Container(
      // padding: const EdgeInsets.symmetric(horizontal: 10),
      // width: ScreenUtil().screenWidth / 2.28,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: Colors.grey.withOpacity(0.05),
        border: Border.all(
          color: Colors.black.withOpacity(0.5),
          width: 0.1,
        ),
      ),
      child: DropdownButton<String>(
        borderRadius: BorderRadius.circular(12),
        menuMaxHeight: 250,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        isExpanded: true,
        // isDense: true,
        value: selectedCountry,
        hint: Text(
          hintText,
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: const Color(0xFF000000),
          ),
        ),
        icon: const Icon(
          Icons.keyboard_arrow_down_rounded,
          color: Color(0xFF000000),
        ),
        underline: Container(
          color: Colors.transparent,
        ),
        dropdownColor: Colors.white,
        items: CountriesData.translateToCountryLanguage.map(
          (countryLanguage) {
            return DropdownMenuItem<String>(
              value: countryLanguage["countryLanguage"],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Image.asset(
                      countryLanguage["countryImage"]!,
                      width: 24,
                      height: 24,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Text(
                    countryLanguage["countryLanguage"]!,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: selectedCountry == countryLanguage["countryLanguage"]
                          ? Colors.black
                          : Colors.black.withOpacity(0.5),
                    ),
                  ),
                ],
              ),
            );
          },
        ).toList(),
        onChanged: (value) {
          onLanguageChanged(value);
        },
      ),
    );
  }
}
