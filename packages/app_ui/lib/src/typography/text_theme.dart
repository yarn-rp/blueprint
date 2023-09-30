// Example typography.dart file
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

part 'base_text_theme.dart';

final customTextTheme =
    kIsWeb ? GoogleFonts.nunitoTextTheme(_baseTextTheme) : _baseTextTheme;
