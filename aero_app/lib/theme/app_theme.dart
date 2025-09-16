import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light() {
    const seed = Color(0xFF1E88E5);
    final cs = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.light);
    return ThemeData(
      colorScheme: cs,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: cs.surface,
        hintStyle: TextStyle(color: cs.onSurfaceVariant),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        indicatorColor: cs.primary.withOpacity(0.12),
        iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(color: s.contains(WidgetState.selected) ? cs.primary : cs.onSurfaceVariant)),
        labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
              color: s.contains(WidgetState.selected) ? cs.primary : cs.onSurfaceVariant,
              fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
            )),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(cs.outlineVariant),
        thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? cs.onPrimary : cs.surface),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 4,
        inactiveTrackColor: cs.outlineVariant,
        activeTrackColor: cs.primary,
        thumbColor: cs.primary,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        tileColor: cs.surface,
        iconColor: cs.primary,
      ),
    );
  }

  static ThemeData dark() {
    const seed = Color(0xFF90CAF9);
    final cs = ColorScheme.fromSeed(seedColor: seed, brightness: Brightness.dark);
    return ThemeData(
      colorScheme: cs,
      useMaterial3: true,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: const AppBarTheme(centerTitle: false),
      cardTheme: CardThemeData(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: const OutlineInputBorder(),
        filled: true,
        fillColor: cs.surface,
        hintStyle: TextStyle(color: cs.onSurfaceVariant),
      ),
      navigationBarTheme: NavigationBarThemeData(
        elevation: 0,
        indicatorColor: cs.primary.withOpacity(0.18),
        iconTheme: WidgetStateProperty.resolveWith((s) => IconThemeData(color: s.contains(WidgetState.selected) ? cs.primary : cs.onSurfaceVariant)),
        labelTextStyle: WidgetStateProperty.resolveWith((s) => TextStyle(
              color: s.contains(WidgetState.selected) ? cs.primary : cs.onSurfaceVariant,
              fontWeight: s.contains(WidgetState.selected) ? FontWeight.w600 : FontWeight.w500,
            )),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        ),
      ),
      switchTheme: SwitchThemeData(
        trackOutlineColor: WidgetStatePropertyAll(cs.outlineVariant),
        thumbColor: WidgetStateProperty.resolveWith((s) => s.contains(WidgetState.selected) ? cs.onPrimary : cs.surface),
      ),
      sliderTheme: SliderThemeData(
        trackHeight: 4,
        inactiveTrackColor: cs.outlineVariant,
        activeTrackColor: cs.primary,
        thumbColor: cs.primary,
      ),
      listTileTheme: ListTileThemeData(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        tileColor: cs.surface,
        iconColor: cs.primary,
      ),
    );
  }
}


