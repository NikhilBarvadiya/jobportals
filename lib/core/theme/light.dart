import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0xFF3DC2C7),
  onPrimary: Color(0xFFFFFFFF),
  primaryContainer: Color(0xFF6FF6FD),
  onPrimaryContainer: Color(0xFF002021),
  secondary: Color(0xFF001F40),
  onSecondary: Color(0xFFFFFFFF),
  secondaryContainer: Color(0xFFCCE8E9),
  onSecondaryContainer: Color(0xFF041F20),
  tertiary: Color(0xFF4E5F7D),
  onTertiary: Color(0xFFFFFFFF),
  tertiaryContainer: Color(0xFFD5E3FF),
  onTertiaryContainer: Color(0xFF071C36),
  error: Color(0xFFBA1A1A),
  errorContainer: Color(0xFFFFDAD6),
  onError: Color(0xFFFFFFFF),
  onErrorContainer: Color(0xFF410002),
  background: Color(0xFFFAFDFC),
  onBackground: Color(0xFF191C1C),
  surface: Color(0xFFFAFDFC),
  onSurface: Color(0xFF191C1C),
  surfaceVariant: Color(0xFFDAE4E5),
  onSurfaceVariant: Color(0xFF3F4949),
  outline: Color(0xFF6F7979),
  onInverseSurface: Color(0xFFEFF1F1),
  inverseSurface: Color(0xFF2D3131),
  inversePrimary: Color(0xFF4CD9E0),
  shadow: Color(0xFF000000),
  surfaceTint: Color(0xFF00696D),
  outlineVariant: Color(0xFFBEC8C9),
  scrim: Color(0xFF000000),
);

dynamic cardTheme = CardTheme(
  elevation: 2,
  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
  clipBehavior: Clip.antiAlias,
  surfaceTintColor: Colors.white,
  shadowColor: lightColorScheme.inverseSurface,
);

dynamic appBarTheme = AppBarTheme(
  elevation: 0,
  centerTitle: false,
  backgroundColor: lightColorScheme.primary,
  foregroundColor: Colors.white,
);

dynamic dialogTheme = const DialogTheme(elevation: 0);

ThemeData themeData = ThemeData(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: GoogleFonts.poppinsTextTheme(),
  cardTheme: cardTheme,
  appBarTheme: appBarTheme,
  dialogTheme: dialogTheme,
  visualDensity: VisualDensity.adaptivePlatformDensity,
);
