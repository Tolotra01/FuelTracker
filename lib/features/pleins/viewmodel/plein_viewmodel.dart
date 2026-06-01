import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../data/local/database.dart';
import '../../../data/repositories/plein_repository.dart';
import '../../../providers/app_providers.dart';

/// Flux des pleins (avec consommation calculée) du véhicule actif.
final pleinsAvecConsoProvider =
    StreamProvider<List<PleinAvecConso>>((ref) {
  final vehicule = ref.watch(activeVehicleProvider);
  if (vehicule == null) return Stream.value([]);
  return ref.watch(pleinRepositoryProvider).watchAvecConso(vehicule.id);
});

/// Dernier plein du véhicule actif (pour préremplir l'odomètre/prix).
final dernierPleinProvider = FutureProvider<Plein?>((ref) {
  final vehicule = ref.watch(activeVehicleProvider);
  if (vehicule == null) return Future.value(null);
  ref.watch(pleinsAvecConsoProvider);
  return ref.read(pleinRepositoryProvider).dernierPlein(vehicule.id);
});

class PleinViewModel extends Notifier<void> {
  static const _uuid = Uuid();

  @override
  void build() {}

  Future<void> save({
    String? id,
    required String vehiculeId,
    required DateTime date,
    required double odometre,
    required double volume,
    required double prixUnitaire,
    required TypePlein typePlein,
    String? station,
    double? latitude,
    double? longitude,
    String? notes,
    String? photo,
  }) async {
    final repo = ref.read(pleinRepositoryProvider);
    await repo.upsert(PleinsCompanion(
      id: Value(id ?? _uuid.v4()),
      vehiculeId: Value(vehiculeId),
      date: Value(date),
      odometre: Value(odometre),
      volume: Value(volume),
      prixUnitaire: Value(prixUnitaire),
      // Prix total = volume × prix unitaire (calcul automatique, §6).
      prixTotal: Value(double.parse((volume * prixUnitaire).toStringAsFixed(2))),
      typePlein: Value(typePlein),
      station: Value(station),
      latitude: Value(latitude),
      longitude: Value(longitude),
      notes: Value(notes),
      photo: Value(photo),
    ));
  }

  Future<void> delete(String id) =>
      ref.read(pleinRepositoryProvider).delete(id);
}

final pleinViewModelProvider =
    NotifierProvider<PleinViewModel, void>(PleinViewModel.new);
