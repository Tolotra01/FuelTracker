import 'package:drift/drift.dart';

import '../local/database.dart';

/// Accès aux données Véhicules (CRUD + véhicule par défaut).
class VehicleRepository {
  VehicleRepository(this._db);

  final AppDatabase _db;

  Stream<List<Vehicule>> watchAll() {
    return (_db.select(_db.vehicules)
          ..orderBy([
            (t) => OrderingTerm(expression: t.parDefaut, mode: OrderingMode.desc),
            (t) => OrderingTerm(expression: t.dateAjout, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<Vehicule>> getAll() => _db.select(_db.vehicules).get();

  Future<Vehicule?> getById(String id) {
    return (_db.select(_db.vehicules)..where((t) => t.id.equals(id)))
        .getSingleOrNull();
  }

  Future<void> upsert(VehiculesCompanion v) async {
    await _db.into(_db.vehicules).insertOnConflictUpdate(v);
  }

  Future<void> delete(String id) async {
    await (_db.delete(_db.vehicules)..where((t) => t.id.equals(id))).go();
  }

  /// Définit un véhicule comme véhicule par défaut (et désactive les autres).
  Future<void> setDefault(String id) async {
    await _db.transaction(() async {
      await _db.update(_db.vehicules).write(
            const VehiculesCompanion(parDefaut: Value(false)),
          );
      await (_db.update(_db.vehicules)..where((t) => t.id.equals(id)))
          .write(const VehiculesCompanion(parDefaut: Value(true)));
    });
  }

  /// Kilométrage actuel = max(odomètre des pleins, km initial).
  Future<double> getKmActuel(Vehicule v) async {
    final maxOdo = await (_db.selectOnly(_db.pleins)
          ..addColumns([_db.pleins.odometre.max()])
          ..where(_db.pleins.vehiculeId.equals(v.id)))
        .map((row) => row.read(_db.pleins.odometre.max()))
        .getSingleOrNull();
    final km = maxOdo ?? v.kmInitial;
    return km < v.kmInitial ? v.kmInitial : km;
  }
}
