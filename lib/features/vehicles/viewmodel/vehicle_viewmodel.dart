import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';

/// ViewModel (MVVM) pour la gestion des véhicules.
class VehicleViewModel extends Notifier<void> {
  static const _uuid = Uuid();

  @override
  void build() {}

  Future<void> save({
    String? id,
    required String marque,
    required String modele,
    required int annee,
    String? plaque,
    required TypeCarburant typeCarburant,
    required double kmInitial,
    double? capaciteReservoir,
    String? photo,
    bool parDefaut = false,
  }) async {
    final repo = ref.read(vehicleRepositoryProvider);
    final isNew = id == null;
    final vehicleId = id ?? _uuid.v4();

    await repo.upsert(VehiculesCompanion(
      id: Value(vehicleId),
      marque: Value(marque),
      modele: Value(modele),
      annee: Value(annee),
      plaque: Value(plaque),
      typeCarburant: Value(typeCarburant),
      kmInitial: Value(kmInitial),
      capaciteReservoir: Value(capaciteReservoir),
      photo: Value(photo),
      dateAjout: isNew ? Value(DateTime.now()) : const Value.absent(),
      parDefaut: Value(parDefaut),
    ));

    // Premier véhicule => devient le véhicule par défaut.
    final all = await repo.getAll();
    if (parDefaut || all.length == 1) {
      await repo.setDefault(vehicleId);
    }
    ref.read(selectedVehicleIdProvider.notifier).select(vehicleId);
  }

  Future<void> delete(String id) async {
    await ref.read(vehicleRepositoryProvider).delete(id);
  }

  Future<void> setDefault(String id) async {
    await ref.read(vehicleRepositoryProvider).setDefault(id);
  }
}

final vehicleViewModelProvider =
    NotifierProvider<VehicleViewModel, void>(VehicleViewModel.new);

/// Km actuel d'un véhicule (FutureProvider family).
final kmActuelProvider =
    FutureProvider.family<double, Vehicule>((ref, vehicule) async {
  // Recalcule quand les pleins changent.
  ref.watch(pleinRepositoryProvider).watchByVehicle(vehicule.id);
  return ref.read(vehicleRepositoryProvider).getKmActuel(vehicule);
});
