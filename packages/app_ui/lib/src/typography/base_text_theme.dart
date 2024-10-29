part of 'text_theme.dart';

const _baseTextTheme = TextTheme(
  displayLarge: _CustomTextTheme.m3DisplayLarge,
  displayMedium: _CustomTextTheme.m3DisplayMedium,
  displaySmall: _CustomTextTheme.m3DisplaySmall,
  headlineLarge: _CustomTextTheme.m3HeadlineLarge,
  headlineMedium: _CustomTextTheme.m3HeadlineMedium,
  headlineSmall: _CustomTextTheme.m3HeadlineSmall,
  titleLarge: _CustomTextTheme.m3TitleLarge,
  titleMedium: _CustomTextTheme.m3TitleMedium,
  titleSmall: _CustomTextTheme.m3TitleSmall,
  bodyLarge: _CustomTextTheme.m3BodyLarge,
  bodyMedium: _CustomTextTheme.m3BodyMedium,
  bodySmall: _CustomTextTheme.m3BodySmall,
  labelLarge: _CustomTextTheme.m3LabelLarge,
  labelMedium: _CustomTextTheme.m3LabelMedium,
  labelSmall: _CustomTextTheme.m3LabelSmall,
);

class _CustomTextTheme {
  // m3DisplayLarge Text Style
  static const TextStyle m3DisplayLarge = TextStyle(
    fontSize: 57,
    fontWeight: FontWeight.w400, // regular
    // height: 1.12, // 64px
    letterSpacing: -0.25,
  );
  // m3DisplayMedium Text Style
  static const TextStyle m3DisplayMedium = TextStyle(
    fontSize: 45,
    fontWeight: FontWeight.w400, // regular
    // height: 1.16, // 52px
  );
  // m3DisplaySmall Text Style
  static const TextStyle m3DisplaySmall = TextStyle(
    fontSize: 36,
    fontWeight: FontWeight.w400, // regular
    // height: 1.22, // 44px
  );
  // m3HeadlineLarge Text Style
  static const TextStyle m3HeadlineLarge = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.w400, // regular
    // height: 1.25, // 40px
  );
  // m3HeadlineMedium Text Style
  static const TextStyle m3HeadlineMedium = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.w400, // regular
    // height: 1.29, // 36px
  );
  // m3HeadlineSmall Text Style
  static const TextStyle m3HeadlineSmall = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w400, // regular
    // height: 1.33, // 32px
  );
  // m3TitleLarge Text Style
  static const TextStyle m3TitleLarge = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w400, // regular
    // height: 1.27, // 28px
  );
  // m3TitleMedium Text Style
  static const TextStyle m3TitleMedium = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w500, // medium
    // height: 1.5, // 24px
    letterSpacing: 0.15,
  );
  // m3TitleSmall Text Style
  static const TextStyle m3TitleSmall = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // medium
    // height: 1.43, // 20px
    letterSpacing: 0.1,
  );
  // m3BodyLarge Text Style
  static const TextStyle m3BodyLarge = TextStyle(
    fontSize: 15,
    fontWeight: FontWeight.w400, // regular
    // height: 1.5, // 24px
    letterSpacing: 0.5,
  );
  // m3BodyMedium Text Style
  static const TextStyle m3BodyMedium = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400, // regular
    // height: 1.43, // 20px
    letterSpacing: 0.25,
  );
  // m3BodySmall Text Style
  static const TextStyle m3BodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w400, // regular
    // height: 1.33, // 16px
  );
  // m3LabelLarge Text Style
  static const TextStyle m3LabelLarge = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500, // medium
    // height: 1.43, // 20px
    letterSpacing: 0.1,
  );
  // m3LabelMedium Text Style
  static const TextStyle m3LabelMedium = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500, // medium
    // height: 1.33, // 16px
    letterSpacing: 0.5,
  );
  // m3LabelSmall Text Style
  static const TextStyle m3LabelSmall = TextStyle(
    fontSize: 11,
    fontWeight: FontWeight.w500, // medium
    // height: 1.45, // 16px
    letterSpacing: 0.5,
  );
}
