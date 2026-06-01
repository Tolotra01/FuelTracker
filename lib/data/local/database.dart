import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import '../../core/constants/enums.dart';

part 'database.g.dart';

// ---------------------------------------------------------------------------
// TABLES (modèle issu du diagramme de classes UML)
// ---------------------------------------------------------------------------

class Vehicules extends Table {
  TextColumn get id => text()();
  TextColumn get marque => text()();
  TextColumn get modele => text()();
  IntColumn get annee => integer()();
  TextColumn get plaque => text().nullable()();
  IntColumn get typeCarburant => intEnum<TypeCarburant>()();
  RealColumn get kmInitial => real().withDefault(const Constant(0))();
  TextColumn get photo => text().nullable()();
  DateTimeColumn get dateAjout => dateTime()();
  BoolColumn get parDefaut => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

class Pleins extends Table {
  TextColumn get id => text()();
  TextColumn get vehiculeId =>
      text().references(Vehicules, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  RealColumn get odometre => real()();
  RealColumn get volume => real()();
  RealColumn get prixUnitaire => real()();
  RealColumn get prixTotal => real()();
  TextColumn get station => text().nullable()();
  RealColumn get latitude => real().nullable()();
  RealColumn get longitude => real().nullable()();
  TextColumn get notes => text().nullable()();
  TextColumn get photo => text().nullable()();
  IntColumn get typePlein =>
      intEnum<TypePlein>().withDefault(const Constant(0))();

  @override
  Set<Column> get primaryKey => {id};
}

class Depenses extends Table {
  TextColumn get id => text()();
  TextColumn get vehiculeId =>
      text().references(Vehicules, #id, onDelete: KeyAction.cascade)();
  DateTimeColumn get date => dateTime()();
  RealColumn get montant => real()();
  IntColumn get categorie => intEnum<CategorieDepense>()();
  TextColumn get description => text().nullable()();
  TextColumn get photo => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

class Maintenances extends Table {
  TextColumn get id => text()();
  TextColumn get vehiculeId =>
      text().references(Vehicules, #id, onDelete: KeyAction.cascade)();
  IntColumn get type => intEnum<TypeMaintenance>()();
  RealColumn get kmPrevu => real().nullable()();
  DateTimeColumn get datePrevue => dateTime().nullable()();
  IntColumn get statut =>
      intEnum<StatutMaintenance>().withDefault(const Constant(0))();
  TextColumn get notes => text().nullable()();
  DateTimeColumn get dateEffectue => dateTime().nullable()();
  RealColumn get cout => real().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

/// Réglages de l'application (Utilisateur unique — app offline mono-profil).
class Reglages extends Table {
  IntColumn get id => integer().withDefault(const Constant(1))();
  TextColumn get nom => text().withDefault(const Constant('Conducteur'))();
  TextColumn get email => text().nullable()();
  TextColumn get devise => text().withDefault(const Constant('€'))();
  TextColumn get uniteDistance =>
      text().withDefault(const Constant('km'))();
  TextColumn get uniteVolume => text().withDefault(const Constant('L'))();
  // 0 = système, 1 = clair, 2 = sombre
  IntColumn get themeMode => integer().withDefault(const Constant(2))();
  TextColumn get langue => text().withDefault(const Constant('fr'))();
  RealColumn get seuilAlerte => real().withDefault(const Constant(20))();
  BoolColumn get grandTexte => boolean().withDefault(const Constant(false))();
  BoolColumn get contrasteEleve =>
      boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {id};
}

// ---------------------------------------------------------------------------
// DATABASE
// ---------------------------------------------------------------------------

@DriftDatabase(
  tables: [Vehicules, Pleins, Depenses, Maintenances, Reglages],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_open());

  AppDatabase.forTesting(super.executor);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (m) async {
          await m.createAll();
          // Réglages par défaut
          await into(reglages).insert(
            const ReglagesCompanion(id: Value(1)),
            mode: InsertMode.insertOrIgnore,
          );
        },
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
          final count = await (select(reglages)..limit(1)).get();
          if (count.isEmpty) {
            await into(reglages).insert(
              const ReglagesCompanion(id: Value(1)),
              mode: InsertMode.insertOrIgnore,
            );
          }
        },
      );

  static QueryExecutor _open() {
    return driftDatabase(name: 'fueltrack');
  }
}
