import 'package:drift/drift.dart';

import '../local/database.dart';

class DepenseRepository {
  DepenseRepository(this._db);

  final AppDatabase _db;

  Stream<List<Depense>> watchByVehicle(String vehiculeId) {
    return (_db.select(_db.depenses)
          ..where((t) => t.vehiculeId.equals(vehiculeId))
          ..orderBy([
            (t) => OrderingTerm(expression: t.date, mode: OrderingMode.desc),
          ]))
        .watch();
  }

  Future<List<Depense>> getByVehicle(String vehiculeId) {
    return (_db.select(_db.depenses)
          ..where((t) => t.vehiculeId.equals(vehiculeId)))
        .get();
  }

  Future<void> upsert(DepensesCompanion d) =>
      _db.into(_db.depenses).insertOnConflictUpdate(d);

  Future<void> delete(String id) =>
      (_db.delete(_db.depenses)..where((t) => t.id.equals(id))).go();
}
