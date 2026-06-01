import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';

final depensesProvider = StreamProvider<List<Depense>>((ref) {
  final vehicule = ref.watch(activeVehicleProvider);
  if (vehicule == null) return Stream.value([]);
  return ref.watch(depenseRepositoryProvider).watchByVehicle(vehicule.id);
});

class DepenseViewModel extends Notifier<void> {
  static const _uuid = Uuid();

  @override
  void build() {}

  Future<void> save({
    String? id,
    required String vehiculeId,
    required DateTime date,
    required double montant,
    required CategorieDepense categorie,
    String? description,
    String? photo,
  }) async {
    await ref.read(depenseRepositoryProvider).upsert(DepensesCompanion(
          id: Value(id ?? _uuid.v4()),
          vehiculeId: Value(vehiculeId),
          date: Value(date),
          montant: Value(montant),
          categorie: Value(categorie),
          description: Value(description),
          photo: Value(photo),
        ));
  }

  Future<void> delete(String id) =>
      ref.read(depenseRepositoryProvider).delete(id);
}

final depenseViewModelProvider =
    NotifierProvider<DepenseViewModel, void>(DepenseViewModel.new);
