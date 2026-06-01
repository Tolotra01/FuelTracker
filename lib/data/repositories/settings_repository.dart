import 'package:drift/drift.dart';

import '../local/database.dart';

class SettingsRepository {
  SettingsRepository(this._db);

  final AppDatabase _db;

  Stream<Reglage> watch() {
    return (_db.select(_db.reglages)..where((t) => t.id.equals(1)))
        .watchSingle();
  }

  Future<Reglage> get() async {
    final r = await (_db.select(_db.reglages)..where((t) => t.id.equals(1)))
        .getSingleOrNull();
    if (r != null) return r;
    await _db.into(_db.reglages).insert(
          const ReglagesCompanion(id: Value(1)),
          mode: InsertMode.insertOrIgnore,
        );
    return (_db.select(_db.reglages)..where((t) => t.id.equals(1)))
        .getSingle();
  }

  Future<void> update(ReglagesCompanion companion) async {
    await (_db.update(_db.reglages)..where((t) => t.id.equals(1)))
        .write(companion);
  }
}
