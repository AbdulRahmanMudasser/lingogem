import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lingogem/data/countries_data.dart';

class CountryRectangleContainer extends StatefulWidget {
  const CountryRectangleContainer({super.key});

  @override
  State<CountryRectangleContainer> createState() => _CountryRectangleContainerState();
}

class _CountryRectangleContainerState extends State<CountryRectangleContainer> {
  @override
  void initState() {
    super.initState();
    randomize();
  }

  /// RANDOM OBJECT TO CREATE RANDOM NUMBERS
  final Random random = Random();

  /// VARIABLE TO HOLD SELECTED COUNTRY
  String? selectedCountry;

  /// VARIABLE TO HOLD BACKGROUND COLOR
  Color? backgroundColor;

  /// METHOD TO GENERATE RANDOM COUNTRY FLAGS
  void randomize() {
    setState(() {
      selectedCountry =
          CountriesData.countriesData[random.nextInt(CountriesData.countriesData.length)]["countryName"];
      backgroundColor = _generateContrastingColor();
    });
  }

  /// Generate a color with sufficient contrast from white
  Color _generateContrastingColor() {
    Color color = Color((random.nextDouble() * 0xFFFFFF).toInt()).withOpacity(0.01);
    // If the color is too light, regenerate
    if (color.computeLuminance() > 0.5) {
      return _generateContrastingColor();
    }
    return color;
  }

  @override
  Widget build(BuildContext context) {
    // Use a Set to filter out duplicates based on the country name
    final uniqueCountries = CountriesData.countriesData.toSet();

    return RefreshIndicator(
      onRefresh: () async {
        randomize();
      },
      child: SingleChildScrollView(
        child: Wrap(
          spacing: 15.w,
          runSpacing: 10,
          direction: Axis.horizontal,
          children: uniqueCountries.map(
            (country) {
              // Check If The Current Country Is Selected
              bool isSelected = country["countryName"] == selectedCountry;

              return Card(
                // elevation: 1,
                color: isSelected ? backgroundColor : Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                  side: BorderSide(
                    color: isSelected ? Colors.transparent : Colors.black.withOpacity(0.5),
                    width: 0.4,
                  ),
                ),
                child: Container(
                  width: 150.w,
                  height: 50,
                  padding: EdgeInsets.symmetric(
                    vertical: 15.w,
                    horizontal: 15.w,
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (country["countryImage"] != null)
                        SizedBox(
                          width: 35,
                          child: Image.asset(
                            country["countryImage"]!,
                            height: 25,
                            fit: BoxFit.cover,
                          ),
                        ),
                      const SizedBox(
                        width: 15,
                      ),
                      Text(
                        country["countryName"]!,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w300,
                          color: isSelected ? Colors.white : Colors.black,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              );
            },
          ).toList(),
        ),
      ),
    );
  }
}
