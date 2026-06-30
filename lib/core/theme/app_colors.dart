import 'package:flutter/material.dart';

/// Système de couleurs FuelTrack — minimaliste & premium.
///
/// Direction : fiabilité, efficacité, maîtrise. Aucune couleur saturée RGB,
/// pas de néon, pas de glassmorphism, pas de dégradés voyants.
/// Palette = neutres (gris / blanc cassé) + bleu pétrole + vert foncé,
/// avec UNE seule couleur d'accent pour les actions importantes.
class AppColors {
  AppColors._();

  // --- Accent unique (actions importantes & valeurs clés) ---
  static const Color accent = Color(0xFF1C9E78); // vert maîtrisé
  static const Color accentPressed = Color(0xFF16805F);
  static const Color accentSoft = Color(0xFFE6F3EE); // fond tonal clair

  // --- Marque ---
  static const Color petrol = Color(0xFF11414B); // bleu pétrole
  static const Color petrolDeep = Color(0xFF0B2E36);
  static const Color forest = Color(0xFF1E5141); // vert foncé

  // --- Neutres (clair) ---
  static const Color ink = Color(0xFF0F1417); // texte principal
  static const Color slate700 = Color(0xFF3A464D);
  static const Color slate500 = Color(0xFF6B7780); // texte secondaire
  static const Color slate400 = Color(0xFF94A0A7); // texte tertiaire / icônes
  static const Color slate300 = Color(0xFFC3CACE);
  static const Color line = Color(0xFFE3E7E9); // bordures / séparateurs
  static const Color surfaceMuted = Color(0xFFEDF0F1); // fills légers
  static const Color bg = Color(0xFFF4F5F6); // fond app clair
  static const Color card = Color(0xFFFFFFFF);

  // --- Neutres (sombre, teintés pétrole) ---
  static const Color bgDark = Color(0xFF0B1416);
  static const Color cardDark = Color(0xFF121E22);
  static const Color surfaceMutedDark = Color(0xFF1A282E);
  static const Color lineDark = Color(0xFF243036);
  static const Color textDark = Color(0xFFF4F5F6);
  static const Color textDarkSecondary = Color(0xFF9AA7AE);

  // --- Sémantique (sobre, non saturée) ---
  static const Color positive = accent;
  static const Color warning = Color(0xFFB9772A);
  static const Color danger = Color(0xFFC04A33);
  static const Color info = petrol;
}
