import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/constants/enums.dart';
import '../../../core/services/notification_service.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';

final maintenancesProvider = StreamProvider<List<Maintenance>>((ref) {
  final vehicule = ref.watch(activeVehicleProvider);
  if (vehicule == null) return Stream.value([]);
  return ref.watch(maintenanceRepositoryProvider).watchByVehicle(vehicule.id);
});

class MaintenanceViewModel extends Notifier<void> {
  static const _uuid = Uuid();

  @override
  void build() {}

  Future<void> save({
    String? id,
    required String vehiculeId,
    required TypeMaintenance type,
    double? kmPrevu,
    DateTime? datePrevue,
    StatutMaintenance statut = StatutMaintenance.planifie,
    String? notes,
    double? cout,
    DateTime? dateEffectue,
  }) async {
    final mId = id ?? _uuid.v4();
    await ref.read(maintenanceRepositoryProvider).upsert(MaintenancesCompanion(
          id: Value(mId),
          vehiculeId: Value(vehiculeId),
          type: Value(type),
          kmPrevu: Value(kmPrevu),
          datePrevue: Value(datePrevue),
          statut: Value(statut),
          notes: Value(notes),
          cout: Value(cout),
          dateEffectue: Value(dateEffectue),
        ));

    // Planifier un rappel (3 jours avant, sinon le jour même).
    final notifId = mId.hashCode & 0x7fffffff;
    await NotificationService.instance.cancel(notifId);
    if (statut != StatutMaintenance.effectue && datePrevue != null) {
      final rappel = datePrevue.subtract(const Duration(days: 3));
      await NotificationService.instance.scheduleReminder(
        id: notifId,
        title: 'Rappel d\'entretien — ${type.label}',
        body: 'Maintenance prévue le jour suivant. Pensez à la planifier.',
        date: rappel.isAfter(DateTime.now()) ? rappel : datePrevue,
      );
    }
  }

  Future<void> marquerEffectue(Maintenance m) async {
    await save(
      id: m.id,
      vehiculeId: m.vehiculeId,
      type: m.type,
      kmPrevu: m.kmPrevu,
      datePrevue: m.datePrevue,
      statut: StatutMaintenance.effectue,
      notes: m.notes,
      cout: m.cout,
      dateEffectue: DateTime.now(),
    );
  }

  Future<void> delete(String id) async {
    await NotificationService.instance.cancel(id.hashCode & 0x7fffffff);
    await ref.read(maintenanceRepositoryProvider).delete(id);
  }
}

final maintenanceViewModelProvider =
    NotifierProvider<MaintenanceViewModel, void>(MaintenanceViewModel.new);
