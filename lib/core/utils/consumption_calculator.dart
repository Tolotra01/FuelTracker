import '../../data/local/database.dart';
import '../constants/enums.dart';

/// Résultat d'un calcul de consommation entre deux pleins.
class ConsumptionResult {
  const ConsumptionResult({
    required this.distance,
    required this.litresPour100km,
    required this.kmParLitre,
    required this.coutParKm,
  });

  final double distance;
  final double litresPour100km;
  final double kmParLitre;
  final double coutParKm;
}

/// Règles métier de calcul de consommation (cahier des charges, §6).
///
/// "La consommation est calculée uniquement entre deux pleins complets."
class ConsumptionCalculator {
  ConsumptionCalculator._();

  /// Calcule la consommation d'un plein [plein] par rapport au plein
  /// complet précédent [precedent]. Retourne null si non calculable.
  static ConsumptionResult? entrePleins(Plein plein, Plein? precedent) {
    if (precedent == null) return null;
    // On ne calcule qu'entre deux pleins complets.
    if (plein.typePlein != TypePlein.complet ||
        precedent.typePlein != TypePlein.complet) {
      return null;
    }
    final distance = plein.odometre - precedent.odometre;
    if (distance <= 0 || plein.volume <= 0) return null;

    return ConsumptionResult(
      distance: distance,
      litresPour100km: (plein.volume * 100) / distance,
      kmParLitre: distance / plein.volume,
      coutParKm: plein.prixTotal / distance,
    );
  }

  /// Consommation moyenne d'une liste de pleins (ordre indifférent),
  /// en L/100km. Retourne null si pas assez de données.
  static double? moyenneL100km(List<Plein> pleins) {
    final ordered = [...pleins]..sort((a, b) => a.odometre.compareTo(b.odometre));
    double totalVolume = 0;
    double totalDistance = 0;
    for (var i = 1; i < ordered.length; i++) {
      final r = entrePleins(ordered[i], ordered[i - 1]);
      if (r != null) {
        totalVolume += ordered[i].volume;
        totalDistance += r.distance;
      }
    }
    if (totalDistance <= 0) return null;
    return (totalVolume * 100) / totalDistance;
  }

  /// Détecte une anomalie : conso supérieure de plus de [seuilPct]%
  /// à la moyenne (cahier des charges : +20%).
  static bool estAnormale(double valeur, double moyenne, double seuilPct) {
    if (moyenne <= 0) return false;
    return valeur > moyenne * (1 + seuilPct / 100);
  }
}
