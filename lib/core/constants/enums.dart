import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

/// Type de carburant d'un véhicule.
enum TypeCarburant {
  essence,
  diesel,
  gpl,
  electrique,
  hybride;

  String get label => switch (this) {
        TypeCarburant.essence => 'Essence',
        TypeCarburant.diesel => 'Diesel',
        TypeCarburant.gpl => 'GPL',
        TypeCarburant.electrique => 'Électrique',
        TypeCarburant.hybride => 'Hybride',
      };

  IconData get icon => switch (this) {
        TypeCarburant.essence => Icons.local_gas_station_rounded,
        TypeCarburant.diesel => Icons.local_gas_station_outlined,
        TypeCarburant.gpl => Icons.propane_tank_rounded,
        TypeCarburant.electrique => Icons.electric_bolt_rounded,
        TypeCarburant.hybride => Icons.eco_rounded,
      };

  /// Les véhicules électriques se mesurent en kWh.
  bool get estElectrique => this == TypeCarburant.electrique;
}

/// Plein complet ou partiel (impacte le calcul de consommation).
enum TypePlein {
  complet,
  partiel;

  String get label =>
      this == TypePlein.complet ? 'Plein complet' : 'Plein partiel';
}

/// Catégories de dépenses.
enum CategorieDepense {
  carburant,
  maintenance,
  assurance,
  peage,
  parking,
  reparation,
  autres;

  String get label => switch (this) {
        CategorieDepense.carburant => 'Carburant',
        CategorieDepense.maintenance => 'Maintenance',
        CategorieDepense.assurance => 'Assurance',
        CategorieDepense.peage => 'Péage',
        CategorieDepense.parking => 'Parking',
        CategorieDepense.reparation => 'Réparation',
        CategorieDepense.autres => 'Autres',
      };

  IconData get icon => switch (this) {
        CategorieDepense.carburant => Icons.local_gas_station_rounded,
        CategorieDepense.maintenance => Icons.build_rounded,
        CategorieDepense.assurance => Icons.shield_rounded,
        CategorieDepense.peage => Icons.toll_rounded,
        CategorieDepense.parking => Icons.local_parking_rounded,
        CategorieDepense.reparation => Icons.car_repair_rounded,
        CategorieDepense.autres => Icons.more_horiz_rounded,
      };

  Color get color => switch (this) {
        CategorieDepense.carburant => AppColors.orange,
        CategorieDepense.maintenance => AppColors.info,
        CategorieDepense.assurance => AppColors.emerald,
        CategorieDepense.peage => const Color(0xFFB47BFF),
        CategorieDepense.parking => const Color(0xFF59C2FF),
        CategorieDepense.reparation => AppColors.danger,
        CategorieDepense.autres => AppColors.warning,
      };
}

/// Types de maintenance courants.
enum TypeMaintenance {
  vidange,
  pneus,
  freins,
  filtres,
  courroie,
  batterie,
  controleTechnique,
  autres;

  String get label => switch (this) {
        TypeMaintenance.vidange => 'Vidange',
        TypeMaintenance.pneus => 'Pneus',
        TypeMaintenance.freins => 'Freins',
        TypeMaintenance.filtres => 'Filtres',
        TypeMaintenance.courroie => 'Courroie',
        TypeMaintenance.batterie => 'Batterie',
        TypeMaintenance.controleTechnique => 'Contrôle technique',
        TypeMaintenance.autres => 'Autres',
      };

  IconData get icon => switch (this) {
        TypeMaintenance.vidange => Icons.oil_barrel_rounded,
        TypeMaintenance.pneus => Icons.tire_repair_rounded,
        TypeMaintenance.freins => Icons.disc_full_rounded,
        TypeMaintenance.filtres => Icons.filter_alt_rounded,
        TypeMaintenance.courroie => Icons.settings_rounded,
        TypeMaintenance.batterie => Icons.battery_charging_full_rounded,
        TypeMaintenance.controleTechnique => Icons.fact_check_rounded,
        TypeMaintenance.autres => Icons.handyman_rounded,
      };
}

/// Statut d'une tâche de maintenance.
enum StatutMaintenance {
  planifie,
  effectue,
  enRetard;

  String get label => switch (this) {
        StatutMaintenance.planifie => 'Planifié',
        StatutMaintenance.effectue => 'Effectué',
        StatutMaintenance.enRetard => 'En retard',
      };

  Color get color => switch (this) {
        StatutMaintenance.planifie => AppColors.info,
        StatutMaintenance.effectue => AppColors.emerald,
        StatutMaintenance.enRetard => AppColors.danger,
      };

  IconData get icon => switch (this) {
        StatutMaintenance.planifie => Icons.schedule_rounded,
        StatutMaintenance.effectue => Icons.check_circle_rounded,
        StatutMaintenance.enRetard => Icons.warning_rounded,
      };
}
