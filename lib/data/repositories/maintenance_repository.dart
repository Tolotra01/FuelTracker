import 'package:drift/drift.dart';

import '../../core/constants/enums.dart';
import '../local/database.dart';

class MaintenanceRepository {
  MaintenanceRepository(this._db);

  final AppDatabase _db;

  Stream<List<Maintenance>> watchByVehicle(String vehiculeId) {
    return (_db.select(_db.maintenances)
          ..where((t) => t.vehiculeId.equals(vehiculeId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.datePrevue),
          ]))
        .watch();
  }

  Future<List<Maintenance>> getByVehicle(String vehiculeId) {
    return (_db.select(_db.maintenances)
          ..where((t) => t.vehiculeId.equals(vehiculeId)))
        .get();
  }

  Future<List<Maintenance>> getToutes() =>
      _db.select(_db.maintenances).get();

  Future<void> upsert(MaintenancesCompanion m) =>
      _db.into(_db.maintenances).insertOnConflictUpdate(m);

  Future<void> delete(String id) =>
      (_db.delete(_db.maintenances)..where((t) => t.id.equals(id))).go();

  /// Recalcule les statuts "en retard" en fonction de la date et du km actuel.
  Future<void> rafraichirStatuts(String vehiculeId, double kmActuel) async {
    final items = await getByVehicle(vehiculeId);
    final now = DateTime.now();
    for (final m in items) {
      if (m.statut == StatutMaintenance.effectue) continue;
      final dateDepassee =
          m.datePrevue != null && m.datePrevue!.isBefore(now);
      final kmDepasse = m.kmPrevu != null && kmActuel >= m.kmPrevu!;
      final nouveau = (dateDepassee || kmDepasse)
          ? StatutMaintenance.enRetard
          : StatutMaintenance.planifie;
      if (nouveau != m.statut) {
        await (_db.update(_db.maintenances)..where((t) => t.id.equals(m.id)))
            .write(MaintenancesCompanion(statut: Value(nouveau)));
      }
    }
  }
}
