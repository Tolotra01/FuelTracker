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
import '../../../core/widgets/kpi_tile.dart';
import '../../../core/widgets/stat_ring.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../../maintenance/viewmodel/maintenance_viewmodel.dart';
import '../../pleins/viewmodel/plein_viewmodel.dart';
import '../../statistics/viewmodel/statistics_viewmodel.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehiclesStreamProvider).value ?? [];
    final vehicule = ref.watch(activeVehicleProvider);
    final settings = ref.watch(settingsStreamProvider).value;

    if (vehicule == null) {
      return Scaffold(
        body: SafeArea(
          child: EmptyState(
            icon: Icons.directions_car_outlined,
            title: 'Bienvenue sur FuelTrack',
            message:
                'Ajoutez votre premier véhicule pour suivre carburant, dépenses et entretien.',
            action: SizedBox(
              width: 240,
              child: PrimaryButton(
                label: 'Ajouter mon véhicule',
                icon: Icons.add_rounded,
                onPressed: () => context.push(Routes.vehicleForm),
              ),
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            _Header(
              nom: settings?.nom ?? 'Conducteur',
              vehicles: vehicles,
              active: vehicule,
            ),
            const SizedBox(height: 8),
            const _RingSection(),
            const SizedBox(height: 16),
            const _KpiSection(),
            const SizedBox(height: 8),
            const SectionLabel('Actions rapides'),
            Row(
              children: [
                Expanded(
                  child: PrimaryButton(
                    label: 'Plein',
                    icon: Icons.local_gas_station_outlined,
                    onPressed: () => context.push(Routes.pleinForm),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: SecondaryButton(
                    label: 'Dépense',
                    icon: Icons.add_card_outlined,
                    onPressed: () => context.push(Routes.depenseForm),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const _LastFillUp(),
            const _UpcomingMaintenance(),
          ],
        ),
      ),
    );
  }
}

class _Header extends ConsumerWidget {
  const _Header(
      {required this.nom, required this.vehicles, required this.active});
  final String nom;
  final List<Vehicule> vehicles;
  final Vehicule active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Bonjour $nom',
                  style: theme.textTheme.bodyMedium?.copyWith(color: secondary)),
              Text('Tableau de bord',
                  style: theme.textTheme.headlineSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        PopupMenuButton<String>(
          onSelected: (id) {
            if (id == '__manage__') {
              context.push(Routes.vehicles);
            } else {
              ref.read(selectedVehicleIdProvider.notifier).select(id);
            }
          },
          itemBuilder: (_) => [
            for (final v in vehicles)
              PopupMenuItem(
                value: v.id,
                child: Row(
                  children: [
                    Icon(v.typeCarburant.icon,
                        size: 18, color: AppColors.petrol),
                    const SizedBox(width: 8),
                    Text('${v.marque} ${v.modele}'),
                  ],
                ),
              ),
            const PopupMenuDivider(),
            const PopupMenuItem(
              value: '__manage__',
              child: Row(children: [
                Icon(Icons.tune_rounded, size: 18),
                SizedBox(width: 8),
                Text('Gérer les véhicules'),
              ]),
            ),
          ],
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 9),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.dark
                  ? AppColors.surfaceMutedDark
                  : AppColors.surfaceMuted,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.lineDark
                      : AppColors.line),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(active.typeCarburant.icon,
                    size: 16, color: AppColors.petrol),
                const SizedBox(width: 6),
                Text(active.marque,
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 13)),
                Icon(Icons.expand_more_rounded, size: 18, color: secondary),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RingSection extends ConsumerWidget {
  const _RingSection();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    final conso = stats?.moyenneL100km ?? 0;
    return AppCard(
      child: Center(
        child: StatRing(
          value: conso,
          maxValue: 15,
          valueLabel: conso > 0 ? conso.toStringAsFixed(1) : '—',
          unit: 'L / 100 km',
          caption: 'Consommation moyenne',
          size: 200,
        ),
      ),
    );
  }
}

class _KpiSection extends ConsumerWidget {
  const _KpiSection();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    final settings = ref.watch(settingsStreamProvider).value;
    final devise = settings?.devise ?? '€';
    final uniteDistance = settings?.uniteDistance ?? 'km';
    if (stats == null) return const SizedBox.shrink();

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.35,
      children: [
        KpiTile(
          icon: Icons.payments_outlined,
          value: Formatters.money(stats.coutTotalGlobal, devise),
          label: 'Coût total',
        ),
        KpiTile(
          icon: Icons.water_drop_outlined,
          value: '${Formatters.number(stats.volumeTotal, decimals: 0)} L',
          label: 'Litres consommés',
        ),
        KpiTile(
          icon: Icons.ev_station_outlined,
          accent: true,
          value: stats.autonomieEstimee != null
              ? '${stats.autonomieEstimee!.toStringAsFixed(0)} $uniteDistance'
              : '—',
          label: 'Autonomie estimée',
        ),
        KpiTile(
          icon: Icons.local_gas_station_outlined,
          value: '${stats.nbPleins}',
          label: 'Pleins enregistrés',
        ),
      ],
    );
  }
}

class _LastFillUp extends ConsumerWidget {
  const _LastFillUp();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final dernier = ref.watch(dernierPleinProvider).value;
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;
    if (dernier == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionLabel('Dernier plein'),
        AppCard(
          onTap: () => context.go(Routes.pleins),
          child: Row(
            children: [
              Container(
                height: 44,
                width: 44,
                decoration: BoxDecoration(
                  color: theme.brightness == Brightness.dark
                      ? AppColors.surfaceMutedDark
                      : AppColors.surfaceMuted,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(Icons.local_gas_station_outlined,
                    color: AppColors.petrol, size: 22),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Formatters.dateLong(dernier.date),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    Text(
                        '${Formatters.number(dernier.volume, decimals: 2)} L · ${dernier.odometre.toStringAsFixed(0)} km',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: secondary)),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(Formatters.money(dernier.prixTotal, devise),
                  style: theme.textTheme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w700)),
            ],
          ),
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

class _UpcomingMaintenance extends ConsumerWidget {
  const _UpcomingMaintenance();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final maintenances = ref.watch(maintenancesProvider).value ?? [];
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;
    final aVenir = maintenances
        .where((m) => m.statut != StatutMaintenance.effectue)
        .take(3)
        .toList();
    if (aVenir.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionLabel(
          'Entretien à venir',
          trailing: TextButton(
            onPressed: () => context.go(Routes.maintenance),
            child: const Text('Tout voir'),
          ),
        ),
        for (final m in aVenir) ...[
          AppCard(
            onTap: () => context.go(Routes.maintenance),
            padding: const EdgeInsets.all(14),
            child: Row(
              children: [
                Icon(m.type.icon, color: m.statut.color, size: 22),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(m.type.label, style: theme.textTheme.titleSmall),
                ),
                if (m.datePrevue != null)
                  Text(Formatters.relativeDate(m.datePrevue!),
                      style: theme.textTheme.bodySmall
                          ?.copyWith(color: secondary)),
              ],
            ),
          ),
          const SizedBox(height: 10),
        ],
      ],
    );
  }
}
