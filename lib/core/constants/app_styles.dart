import 'package:flutter/material.dart';
import 'package:vitas_clone/core/utils/util.dart';
import 'app_colors.dart';

class AppTheme {
  static ThemeData appTheme({final BuildContext? context}) {

    var textTheme = _baseTextTheme(); 

    var themeData = ThemeData(
      brightness: Brightness.light,
      appBarTheme: AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: AppColors.primaryText,
          )),
      pageTransitionsTheme: PageTransitionsTheme(builders: {
          TargetPlatform.android: CupertinoPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        }),

        // COLORS
        primaryColor: colorPurple,
        primaryColorDark: colorPurple[600],
        primaryColorLight: colorYellow[300],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: colorPurple,
          accentColor: colorYellow[500],
          cardColor: colorGrayscale[50],
          backgroundColor: colorGrayscale[100],
          errorColor: colorRed[500],
        ),
        canvasColor: colorGrayscale[50],
        cardColor: colorGrayscale[50],
        dividerColor: colorGrayscale[200],
        disabledColor: colorGrayscale[400],
        textSelectionTheme: TextSelectionThemeData(
          cursorColor: colorPurple[500],
          selectionColor: colorPurple[500]?.withOpacity(.2),
          selectionHandleColor: colorPurple[500],
        ),
        scaffoldBackgroundColor: colorGrayscale[100],
        unselectedWidgetColor: colorGrayscale[500],
        secondaryHeaderColor: colorPurple,
        dialogBackgroundColor: colorGrayscale[100],
        indicatorColor: colorGrayscale[100],
        hintColor: colorGrayscale[100],

        //TYPOGRAPHY
        fontFamily: 'Lato',

        // See: https://api.flutter.dev/flutter/material/TextTheme-class.html
        textTheme: textTheme,
        primaryTextTheme: _copyWithColor(textTheme, Colors.white),
        buttonTheme: ButtonThemeData(
          alignedDropdown: true,
        ),
        bottomAppBarTheme: BottomAppBarTheme(
          color: colorGrayscale[50],
        )
    );
    return themeData;
  }
}
  TextTheme _baseTextTheme() {
  var textTheme = TextTheme(
    //H1
    displayLarge: const TextStyle(
      fontSize: 32.0,
      fontWeight: FontWeight.bold,
      color: grey6,
    ),
    //H2
    displayMedium: const TextStyle(
      fontSize: 28.0,
      color: grey6,
    ),
    //H3
    displaySmall: const TextStyle(
      fontSize: 22.0,
      fontWeight: FontWeight.bold,
      color: grey6,
    ),
    //H4
    headlineMedium: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: grey6,
    ),
    //H5
    headlineSmall: const TextStyle(
      fontSize: 14.0,
      color: grey6,
    ),
    //Title
    titleLarge: const TextStyle(
      fontSize: 20.0,
      color: grey6,
    ),
    //Body
    bodyLarge: const TextStyle(
      fontSize: 19.0,
      color: grey6,
    ),
    //Body
    bodyMedium: const TextStyle(
      fontSize: 19.0,
      color: grey6,
    ),
    //Caption
    bodySmall: const TextStyle(
      fontSize: 12.0,
      color: grey6,
    ),
    // Button
    labelLarge: const TextStyle(
      fontSize: 16.0,
      fontWeight: FontWeight.bold,
      color: grey6,
    ),
    // Subtitle
    titleSmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: grey4,
      height: 1.1,
    ),
    // Overline
    labelSmall: const TextStyle(
      fontSize: 12.0,
      fontWeight: FontWeight.bold,
      color: grey4,
      height: 1.1,
    ),
  );

  return textTheme;
}

TextTheme _copyWithColor(final TextTheme textTheme, final Color color) {
  return textTheme.copyWith(
      displayLarge: textTheme.displayLarge?.copyWith(color: color),
      displayMedium: textTheme.displayMedium?.copyWith(color: color),
      displaySmall: textTheme.displaySmall?.copyWith(color: color),
      headlineMedium: textTheme.headlineMedium?.copyWith(color: color),
      headlineSmall: textTheme.headlineSmall?.copyWith(color: color),
      titleLarge: textTheme.titleLarge?.copyWith(color: color),
      bodyMedium: textTheme.bodyMedium?.copyWith(color: color),
      bodyLarge: textTheme.bodyLarge?.copyWith(color: color),
      bodySmall: textTheme.bodySmall?.copyWith(color: color),
      labelLarge: textTheme.labelLarge?.copyWith(color: color),
      titleSmall: textTheme.titleSmall?.copyWith(color: color),
      labelSmall: textTheme.labelSmall?.copyWith(color: color));
}

class Constants {
  final double vitasDrawerTopInset;
  final double profileSetupSpacerHeight;
  final EdgeInsets rolePromptPadding;
  final double rolePromptBottomPadding;
  final double serviceAreaAspectRatio;
  final double buttonHeight;
  final double formSpacerHeight;
  final EdgeInsets formActionButtonPadding;
  final double diagnosisGridAspectRatio;
  final double diagnosisCircleDiameter;
  final double bmiCalculatorLabelWidth;
  final double webinarCardAspectRatio;
  final double vitasComponentSpacing;
  final double calculatorButtonHeight;
  final double newsGridAspectRatio;

  Constants({
    required this.vitasDrawerTopInset,
    required this.profileSetupSpacerHeight,
    required this.rolePromptPadding,
    required this.rolePromptBottomPadding,
    required this.serviceAreaAspectRatio,
    required this.buttonHeight,
    required this.formSpacerHeight,
    required this.formActionButtonPadding,
    required this.diagnosisGridAspectRatio,
    required this.diagnosisCircleDiameter,
    required this.bmiCalculatorLabelWidth,
    required this.webinarCardAspectRatio,
    required this.vitasComponentSpacing,
    required this.calculatorButtonHeight,
    required this.newsGridAspectRatio,
  });

  static Constants of(BuildContext context) {
    return Constants(
      vitasDrawerTopInset: 32.0,
      profileSetupSpacerHeight: 40.0,
      rolePromptPadding: const EdgeInsets.all(24.0),
      rolePromptBottomPadding: isTablet(context) ? 32.0 : 16.0,
      serviceAreaAspectRatio: 1.5,
      buttonHeight: 48.0,
      formSpacerHeight: 24.0,
      formActionButtonPadding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      diagnosisGridAspectRatio: isTablet(context) ? 6.0 : 3.95,
      diagnosisCircleDiameter: 22.0,
      bmiCalculatorLabelWidth: 64.0,
      webinarCardAspectRatio: 0.95,
      vitasComponentSpacing: 32.0,
      calculatorButtonHeight: isTablet(context) ? 200.0 : 100.0,
      newsGridAspectRatio: isTablet(context) ? 1.1 : 0.93,
    );
  }
}
