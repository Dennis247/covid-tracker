import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle {
  static final headerTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.w500),
  );

  static final mediumTextSTyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  );

  static final smallTextStyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.grey,
      fontSize: 11,
      fontWeight: FontWeight.w500,
    ),
  );

  static final mediumTextSTyleWhite = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.white,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    ),
  );

  static final largeTextSTyle = GoogleFonts.poppins(
    textStyle: TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w600,
    ),
  );
}
