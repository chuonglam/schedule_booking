import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyles {
  static final regular = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.normal,
  );

  static final medium = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w500,
  );

  static final bold = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.bold,
  );

  static final thin = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w100,
  );

  static final semiBold = GoogleFonts.roboto(
    fontWeight: FontWeight.w600,
  );

  static final thinItalic = GoogleFonts.roboto(
    fontSize: 12,
    fontWeight: FontWeight.w100,
    fontStyle: FontStyle.italic,
  );

  static const MaterialColor mainColor = MaterialColor(
    0xFF1676F3,
    {
      50: Color(0xFF1676F3),
      100: Color(0xFF1676F3),
      200: Color(0xFF1676F3),
      300: Color(0xFF1676F3),
      400: Color(0xFF1676F3),
      500: Color(0xFF1676F3),
      600: Color(0xFF1676F3),
      700: Color(0xFF1676F3),
      800: Color(0xFF1676F3),
      900: Color(0xFF1676F3)
    },
  );

  static ThemeData theme(BuildContext context) {
    return ThemeData(
      primarySwatch: AppStyles.mainColor,
      tabBarTheme: TabBarTheme(
        labelStyle: AppStyles.semiBold.copyWith(
          fontSize: 17,
          color: Colors.black,
        ),
        labelColor: AppStyles.mainColor,
        unselectedLabelColor: const Color(0xff757575),
        indicatorSize: TabBarIndicatorSize.tab,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 1,
        titleTextStyle: TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.bold,
        ),
      ),
      textTheme: GoogleFonts.plusJakartaSansTextTheme(),
      navigationRailTheme: NavigationRailThemeData(
        selectedLabelTextStyle: AppStyles.medium.copyWith(
          fontSize: 14,
          color: AppStyles.mainColor,
        ),
        unselectedLabelTextStyle: AppStyles.medium.copyWith(
          color: const Color(0xff757575),
          fontSize: 14,
        ),
        indicatorColor: Colors.transparent,
      ),
      inputDecorationTheme: InputDecorationTheme(
        enabledBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffEAEAEA),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: AppStyles.mainColor,
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        border: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Color(0xffEAEAEA),
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        hoverColor: Colors.grey.shade100,
        filled: true,
        fillColor: Colors.white,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        isDense: true,
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).dividerColor),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 32),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }
}
