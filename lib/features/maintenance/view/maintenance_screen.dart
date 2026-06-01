import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/maintenance_viewmodel.dart';

class MaintenanceScreen extends ConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final vehicule = ref.watch(activeVehicleProvider);
    final maintenancesAsync = ref.watch(maintenancesProvider);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text('Entretien & rappels',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),
              ),
              Expanded(
                child: vehicule == null
                    ? EmptyState(
                        icon: Icons.directions_car_rounded,
                        title: 'Aucun véhicule',
                        message: 'Ajoutez un véhicule pour planifier l\'entretien.',
                        action: GradientButton(
                          label: 'Ajouter un véhicule',
                          icon: Icons.add_rounded,
                          expanded: false,
                          onPressed: () => context.push(Routes.vehicleForm),
                        ),
                      )
                    : maintenancesAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Erreur : $e')),
                        data: (items) {
                          if (items.isEmpty) {
                            return EmptyState(
                              icon: Icons.build_rounded,
                              title: 'Aucune maintenance',
                              message:
                                  'Planifiez vidange, pneus, freins… avec rappels par date ou kilométrage.',
                            );
                          }
                          return ListView.separated(
                            padding:
                                const EdgeInsets.fromLTRB(16, 8, 16, 140),
                            itemCount: items.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, i) =>
                                _MaintenanceCard(item: items[i]),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: vehicule == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.maintenanceForm),
              backgroundColor: AppColors.emerald,
              foregroundColor: AppColors.navyDeep,
              icon: const Icon(Icons.add_rounded),
              label: const Text('Entretien'),
            ),
    );
  }
}

class _MaintenanceCard extends ConsumerWidget {
  const _MaintenanceCard({required this.item});
  final Maintenance item;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final statut = item.statut;
    return GlassCard(
      onTap: () => context.push(Routes.maintenanceForm, extra: item),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: statut.color.withValues(alpha: 0.16),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Icon(item.type.icon, color: statut.color),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.type.label,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    if (item.notes != null && item.notes!.isNotEmpty)
                      Text(item.notes!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                decoration: BoxDecoration(
                  color: statut.color.withValues(alpha: 0.18),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(statut.icon, size: 13, color: statut.color),
                    const SizedBox(width: 4),
                    Text(statut.label,
                        style: TextStyle(
                            color: statut.color,
                            fontWeight: FontWeight.w600,
                            fontSize: 11)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              if (item.datePrevue != null)
                _info(context, Icons.event_rounded,
                    Formatters.relativeDate(item.datePrevue!)),
              if (item.kmPrevu != null) ...[
                const SizedBox(width: 12),
                _info(context, Icons.speed_rounded,
                    '${item.kmPrevu!.toStringAsFixed(0)} km'),
              ],
              const Spacer(),
              if (statut != StatutMaintenance.effectue)
                TextButton.icon(
                  onPressed: () => ref
                      .read(maintenanceViewModelProvider.notifier)
                      .marquerEffectue(item),
                  icon: const Icon(Icons.check_circle_rounded, size: 18),
                  label: const Text('Fait'),
                )
              else if (item.dateEffectue != null)
                Text('Le ${Formatters.date(item.dateEffectue!)}',
                    style: theme.textTheme.bodySmall),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(BuildContext context, IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: AppColors.emerald),
        const SizedBox(width: 4),
        Text(text, style: Theme.of(context).textTheme.bodySmall),
      ],
    );
  }
}
