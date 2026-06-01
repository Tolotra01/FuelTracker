import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/local/database.dart';
import '../data/repositories/depense_repository.dart';
import '../data/repositories/maintenance_repository.dart';
import '../data/repositories/plein_repository.dart';
import '../data/repositories/settings_repository.dart';
import '../data/repositories/vehicle_repository.dart';

/// Base de données unique (singleton applicatif).
final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

// --- Repositories -----------------------------------------------------------

final vehicleRepositoryProvider = Provider<VehicleRepository>(
  (ref) => VehicleRepository(ref.watch(databaseProvider)),
);

final pleinRepositoryProvider = Provider<PleinRepository>(
  (ref) => PleinRepository(ref.watch(databaseProvider)),
);

final depenseRepositoryProvider = Provider<DepenseRepository>(
  (ref) => DepenseRepository(ref.watch(databaseProvider)),
);

final maintenanceRepositoryProvider = Provider<MaintenanceRepository>(
  (ref) => MaintenanceRepository(ref.watch(databaseProvider)),
);

final settingsRepositoryProvider = Provider<SettingsRepository>(
  (ref) => SettingsRepository(ref.watch(databaseProvider)),
);

// --- Réglages (flux global) -------------------------------------------------

final settingsStreamProvider = StreamProvider<Reglage>(
  (ref) => ref.watch(settingsRepositoryProvider).watch(),
);

// --- Liste des véhicules ----------------------------------------------------

final vehiclesStreamProvider = StreamProvider<List<Vehicule>>(
  (ref) => ref.watch(vehicleRepositoryProvider).watchAll(),
);

/// Identifiant du véhicule actuellement sélectionné dans l'app.
/// `null` => on retombe sur le véhicule par défaut / premier disponible.
class SelectedVehicleNotifier extends Notifier<String?> {
  @override
  String? build() => null;

  void select(String? id) => state = id;
}

final selectedVehicleIdProvider =
    NotifierProvider<SelectedVehicleNotifier, String?>(
  SelectedVehicleNotifier.new,
);

/// Véhicule effectivement actif (sélection explicite, sinon défaut, sinon 1er).
final activeVehicleProvider = Provider<Vehicule?>((ref) {
  final vehicles = ref.watch(vehiclesStreamProvider).value ?? [];
  if (vehicles.isEmpty) return null;
  final selectedId = ref.watch(selectedVehicleIdProvider);
  if (selectedId != null) {
    final match = vehicles.where((v) => v.id == selectedId).firstOrNull;
    if (match != null) return match;
  }
  return vehicles.where((v) => v.parDefaut).firstOrNull ?? vehicles.first;
});
