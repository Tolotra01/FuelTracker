import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/constants/enums.dart';
import '../../../core/utils/consumption_calculator.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/plein_repository.dart';
import '../../../providers/app_providers.dart';
import '../../depenses/viewmodel/depense_viewmodel.dart';
import '../../pleins/viewmodel/plein_viewmodel.dart';

/// Point mensuel pour les graphiques.
class MonthlyPoint {
  MonthlyPoint(this.mois, this.valeur);
  final DateTime mois;
  double valeur;
}

class StatsData {
  StatsData({
    required this.moyenneL100km,
    required this.coutTotalCarburant,
    required this.coutTotalDepenses,
    required this.coutParKm,
    required this.distanceTotale,
    required this.volumeTotal,
    required this.nbPleins,
    required this.consoParMois,
    required this.coutParMois,
    required this.repartitionDepenses,
    required this.anomalies,
  });

  final double? moyenneL100km;
  final double coutTotalCarburant;
  final double coutTotalDepenses;
  final double? coutParKm;
  final double distanceTotale;
  final double volumeTotal;
  final int nbPleins;
  final List<MonthlyPoint> consoParMois;
  final List<MonthlyPoint> coutParMois;
  final Map<CategorieDepense, double> repartitionDepenses;
  final int anomalies;

  double get coutTotalGlobal => coutTotalCarburant + coutTotalDepenses;
}

/// Provider de statistiques calculées pour le véhicule actif.
final statisticsProvider = Provider<StatsData?>((ref) {
  final vehicule = ref.watch(activeVehicleProvider);
  if (vehicule == null) return null;

  final pleinsData = ref.watch(pleinsAvecConsoProvider).value;
  final depenses = ref.watch(depensesProvider).value ?? [];
  final settings = ref.watch(settingsStreamProvider).value;
  final seuil = settings?.seuilAlerte ?? 20;

  if (pleinsData == null) return null;

  final pleins = pleinsData.map((e) => e.plein).toList();
  final moyenne = ConsumptionCalculator.moyenneL100km(pleins);

  double coutCarburant = 0;
  double volumeTotal = 0;
  for (final p in pleins) {
    coutCarburant += p.prixTotal;
    volumeTotal += p.volume;
  }

  double distanceTotale = 0;
  int anomalies = 0;
  for (final d in pleinsData) {
    final c = d.consommation;
    if (c != null) {
      distanceTotale += c.distance;
      if (moyenne != null &&
          ConsumptionCalculator.estAnormale(
              c.litresPour100km, moyenne, seuil)) {
        anomalies++;
      }
    }
  }

  final coutDepenses = depenses.fold<double>(0, (s, d) => s + d.montant);
  final coutParKm =
      distanceTotale > 0 ? (coutCarburant + coutDepenses) / distanceTotale : null;

  // Séries mensuelles (12 derniers mois)
  final consoParMois = _consoMensuelle(pleinsData);
  final coutParMois = _coutMensuel(pleins, depenses);

  // Répartition des dépenses par catégorie (+ carburant)
  final repartition = <CategorieDepense, double>{};
  for (final d in depenses) {
    repartition[d.categorie] = (repartition[d.categorie] ?? 0) + d.montant;
  }
  if (coutCarburant > 0) {
    repartition[CategorieDepense.carburant] =
        (repartition[CategorieDepense.carburant] ?? 0) + coutCarburant;
  }

  return StatsData(
    moyenneL100km: moyenne,
    coutTotalCarburant: coutCarburant,
    coutTotalDepenses: coutDepenses,
    coutParKm: coutParKm,
    distanceTotale: distanceTotale,
    volumeTotal: volumeTotal,
    nbPleins: pleins.length,
    consoParMois: consoParMois,
    coutParMois: coutParMois,
    repartitionDepenses: repartition,
    anomalies: anomalies,
  );
});

List<MonthlyPoint> _consoMensuelle(List<PleinAvecConso> data) {
  final map = <String, List<double>>{};
  final labels = <String, DateTime>{};
  for (final d in data) {
    final c = d.consommation;
    if (c == null) continue;
    final key = '${d.plein.date.year}-${d.plein.date.month}';
    labels[key] = DateTime(d.plein.date.year, d.plein.date.month);
    (map[key] ??= []).add(c.litresPour100km);
  }
  final points = labels.entries.map((e) {
    final vals = map[e.key]!;
    final avg = vals.reduce((a, b) => a + b) / vals.length;
    return MonthlyPoint(e.value, avg);
  }).toList()
    ..sort((a, b) => a.mois.compareTo(b.mois));
  return points.length > 12 ? points.sublist(points.length - 12) : points;
}

List<MonthlyPoint> _coutMensuel(List<Plein> pleins, List<Depense> depenses) {
  final map = <String, MonthlyPoint>{};
  void add(DateTime date, double montant) {
    final key = '${date.year}-${date.month}';
    final pt = map[key] ??= MonthlyPoint(DateTime(date.year, date.month), 0);
    pt.valeur += montant;
  }

  for (final p in pleins) {
    add(p.date, p.prixTotal);
  }
  for (final d in depenses) {
    add(d.date, d.montant);
  }
  final points = map.values.toList()
    ..sort((a, b) => a.mois.compareTo(b.mois));
  return points.length > 12 ? points.sublist(points.length - 12) : points;
}
