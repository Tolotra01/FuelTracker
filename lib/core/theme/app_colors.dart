import 'package:flutter/material.dart';

/// Palette de couleurs officielle FuelTrack (basée sur le logo).
class AppColors {
  AppColors._();

  // Couleurs principales du cahier des charges
  static const Color navyBlue = Color(0xFF0A2540); // Primaire
  static const Color emerald = Color(0xFF00D4A5); // Secondaire ("Fuel")
  static const Color orange = Color(0xFFFF6B35); // Accent ("Track")
  static const Color lightGray = Color(0xFFF4F6F9);
  static const Color darkGray = Color(0xFF1E2937);
  static const Color white = Color(0xFFFFFFFF);

  // Déclinaisons / nuances utiles pour le design 3D
  static const Color navyLight = Color(0xFF13335A);
  static const Color navyDeep = Color(0xFF061829);
  static const Color emeraldDark = Color(0xFF00A582);
  static const Color orangeDark = Color(0xFFD9531E);

  // Sémantique
  static const Color success = emerald;
  static const Color warning = Color(0xFFFFB020);
  static const Color danger = Color(0xFFFF4D5E);
  static const Color info = Color(0xFF3DA5FF);

  // Dégradés signature (design orienté 3D)
  static const LinearGradient brandGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [emerald, orange],
  );

  static const LinearGradient emeraldGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF1FE3B6), emeraldDark],
  );

  static const LinearGradient orangeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFF8A5C), orangeDark],
  );

  static const LinearGradient navyGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [navyLight, navyDeep],
  );

  // Surfaces verre (glassmorphism)
  static Color glassDark = white.withValues(alpha: 0.06);
  static Color glassBorderDark = white.withValues(alpha: 0.12);
  static Color glassLight = white.withValues(alpha: 0.65);
  static Color glassBorderLight = white.withValues(alpha: 0.8);
}
