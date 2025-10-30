import 'package:auth_sample/core/constants/const_colors.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTextTheme {
  AppTextTheme._();
  static final TextStyle blue35bold = GoogleFonts.poppins(
    color: ConstColors.firstBlue,
    fontWeight: FontWeight.w600,
    fontSize: 35,
  );
  static final TextStyle black15normal = GoogleFonts.poppins(
    color: ConstColors.firstBlack,
    fontWeight: FontWeight.w400,
    fontSize: 15,
  );
  static final TextStyle white20bold = GoogleFonts.poppins(
    color: ConstColors.firstWhite,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static final TextStyle black20bold = GoogleFonts.poppins(
    color: ConstColors.firstBlack,
    fontWeight: FontWeight.w600,
    fontSize: 20,
  );
  static final TextStyle grey16normal = GoogleFonts.poppins(
    color: ConstColors.firstGrey,
    fontWeight: FontWeight.w500,
    fontSize: 16,
  );
  static final TextStyle grey14normal = GoogleFonts.poppins(
    color: ConstColors.firstGrey,
    fontWeight: FontWeight.w500,
    fontSize: 14,
  );
}
