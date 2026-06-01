import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../../core/utils/consumption_calculator.dart';
import '../local/database.dart';

/// Plein enrichi de sa consommation calculée (vue ViewModel).
class PleinAvecConso {
  const PleinAvecConso({required this.plein, this.consommation});

  final Plein plein;
  final ConsumptionResult? consommation;
}

class PleinRepository {
  PleinRepository(this._db);

  final AppDatabase _db;

  Stream<List<Plein>> watchByVehicle(String vehiculeId) {
    return (_db.select(_db.pleins)
          ..where((t) => t.vehiculeId.equals(vehiculeId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<Plein>> getByVehicle(String vehiculeId) {
    return (_db.select(_db.pleins)
          ..where((t) => t.vehiculeId.equals(vehiculeId))
          ..orderBy([(t) => OrderingTerm(expression: t.odometre)]))
        .get();
  }

  /// Pleins enrichis de leur consommation, triés par date décroissante.
  Stream<List<PleinAvecConso>> watchAvecConso(String vehiculeId) {
    return watchByVehicle(vehiculeId).map((pleins) {
      // tri par odomètre croissant pour le calcul
      final parOdo = [...pleins]
        ..sort((a, b) => a.odometre.compareTo(b.odometre));
      final map = <String, ConsumptionResult?>{};
      Plein? dernierComplet;
      for (final p in parOdo) {
        map[p.id] = ConsumptionCalculator.entrePleins(p, dernierComplet);
        if (p.typePlein == TypePlein.complet) dernierComplet = p;
      }
      return pleins
          .map((p) => PleinAvecConso(plein: p, consommation: map[p.id]))
          .toList();
    });
  }

  Future<Plein?> dernierPlein(String vehiculeId) {
    return (_db.select(_db.pleins)
          ..where((t) => t.vehiculeId.equals(vehiculeId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .getSingleOrNull();
  }

  Future<void> upsert(PleinsCompanion p) =>
      _db.into(_db.pleins).insertOnConflictUpdate(p);

  Future<void> delete(String id) =>
      (_db.delete(_db.pleins)..where((t) => t.id.equals(id))).go();
}
