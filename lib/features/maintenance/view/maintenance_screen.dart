import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/maintenance_viewmodel.dart';

class MaintenanceScreen extends ConsumerWidget {
  const MaintenanceScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicule = ref.watch(activeVehicleProvider);
    final maintenancesAsync = ref.watch(maintenancesProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Entretien')),
      floatingActionButton: vehicule == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.maintenanceForm),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Entretien'),
            ),
      body: vehicule == null
          ? EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Aucun véhicule',
              message: "Ajoutez un véhicule pour planifier l'entretien.",
              action: SizedBox(
                width: 220,
                child: PrimaryButton(
                  label: 'Ajouter un véhicule',
                  icon: Icons.add_rounded,
                  onPressed: () => context.push(Routes.vehicleForm),
                ),
              ),
            )
          : maintenancesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erreur : $e')),
              data: (items) {
                if (items.isEmpty) {
                  return EmptyState(
                    icon: Icons.build_outlined,
                    title: 'Aucune maintenance',
                    message:
                        'Planifiez vidange, pneus, freins… avec rappels par date ou kilométrage.',
                    action: SizedBox(
                      width: 270,
                      child: PrimaryButton(
                        label: 'Planifier un entretien',
                        icon: Icons.add_rounded,
                        onPressed: () => context.push(Routes.maintenanceForm),
                      ),
                    ),
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  itemCount: items.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) => _MaintenanceCard(item: items[i]),
                );
              },
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
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;
    final isDark = theme.brightness == Brightness.dark;

    return AppCard(
      onTap: () => context.push(Routes.maintenanceForm, extra: item),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: isDark
                      ? AppColors.surfaceMutedDark
                      : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(item.type.icon, color: AppColors.petrol, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(item.type.label,
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    if (item.notes != null && item.notes!.isNotEmpty)
                      Text(item.notes!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: secondary)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _StatusBadge(statut: statut),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              if (item.datePrevue != null)
                _info(context, Icons.event_outlined,
                    Formatters.relativeDate(item.datePrevue!)),
              if (item.kmPrevu != null) ...[
                const SizedBox(width: 12),
                _info(context, Icons.speed_outlined,
                    '${item.kmPrevu!.toStringAsFixed(0)} km'),
              ],
              const Spacer(),
              if (statut != StatutMaintenance.effectue)
                TextButton.icon(
                  onPressed: () => ref
                      .read(maintenanceViewModelProvider.notifier)
                      .marquerEffectue(item),
                  icon: const Icon(Icons.check_circle_outline_rounded, size: 18),
                  label: const Text('Marquer fait'),
                )
              else if (item.dateEffectue != null)
                Text('Fait le ${Formatters.date(item.dateEffectue!)}',
                    style:
                        theme.textTheme.bodySmall?.copyWith(color: secondary)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _info(BuildContext context, IconData icon, String text) {
    final secondary = Theme.of(context).brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 14, color: secondary),
        const SizedBox(width: 4),
        Text(text,
            style: Theme.of(context)
                .textTheme
                .labelSmall
                ?.copyWith(color: secondary)),
      ],
    );
  }
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.statut});
  final StatutMaintenance statut;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: statut.color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(8),
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
    );
  }
}
