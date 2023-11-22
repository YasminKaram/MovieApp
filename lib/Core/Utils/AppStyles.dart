import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/src/painting/text_style.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:movieapp/Core/Utils/AppColors.dart';

class AppStyles {
  static TextStyle headLine = GoogleFonts.inter(
      color: AppColors.whitecolor, fontSize: 15.sp, fontWeight: FontWeight.w400,);
  static TextStyle movieName = GoogleFonts.poppins(
      color: AppColors.whitecolor, fontSize: 10.sp, fontWeight: FontWeight.w400,);
  static TextStyle date = GoogleFonts.inter(
      color: AppColors.datecolor, fontSize: 8.sp, fontWeight: FontWeight.w400);

}
