import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/consumption_gauge.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/stat_card.dart';
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
    final devise = settings?.devise ?? '€';

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: vehicule == null
              ? _EmptyDashboard()
              : CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _TopBar(
                        nom: settings?.nom ?? 'Conducteur',
                        vehicles: vehicles,
                        active: vehicule,
                      ),
                    ),
                    SliverToBoxAdapter(child: _GaugeSection(devise: devise)),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate([
                          const _QuickStats(),
                          const SizedBox(height: 8),
                          const SectionHeader(
                              title: 'Actions rapides',
                              icon: Icons.bolt_rounded),
                          Row(
                            children: [
                              Expanded(
                                child: GradientButton(
                                  label: 'Plein',
                                  icon: Icons.local_gas_station_rounded,
                                  gradient: AppColors.orangeGradient,
                                  onPressed: () =>
                                      context.push(Routes.pleinForm),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: GradientButton(
                                  label: 'Dépense',
                                  icon: Icons.add_card_rounded,
                                  onPressed: () =>
                                      context.push(Routes.depenseForm),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          const _LastFillUp(),
                          const SizedBox(height: 20),
                          const _UpcomingMaintenance(),
                        ]),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}

class _EmptyDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EmptyState(
      icon: Icons.directions_car_filled_rounded,
      title: 'Bienvenue sur FuelTrack',
      message:
          'Ajoutez votre premier véhicule pour suivre carburant, dépenses et entretien.',
      action: GradientButton(
        label: 'Ajouter mon véhicule',
        icon: Icons.add_rounded,
        expanded: false,
        onPressed: () => context.push(Routes.vehicleForm),
      ),
    );
  }
}

class _TopBar extends ConsumerWidget {
  const _TopBar(
      {required this.nom, required this.vehicles, required this.active});
  final String nom;
  final List<Vehicule> vehicles;
  final Vehicule active;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 16, 4),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset('assets/images/logo.jpg',
                width: 44, height: 44, fit: BoxFit.cover),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Bonjour $nom 👋',
                    style: theme.textTheme.bodySmall),
                Text('Tableau de bord',
                    style: theme.textTheme.titleLarge
                        ?.copyWith(fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          // Sélecteur de véhicule
          PopupMenuButton<String>(
            onSelected: (id) {
              if (id == '__add__') {
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
                          size: 18, color: AppColors.emerald),
                      const SizedBox(width: 8),
                      Text('${v.marque} ${v.modele}'),
                    ],
                  ),
                ),
              const PopupMenuDivider(),
              const PopupMenuItem(
                value: '__add__',
                child: Row(children: [
                  Icon(Icons.add_rounded, size: 18),
                  SizedBox(width: 8),
                  Text('Gérer les véhicules'),
                ]),
              ),
            ],
            onCanceled: () {},
            child: Container(
              padding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: AppColors.navyGradient,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(
                    color: Colors.white.withValues(alpha: 0.12)),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(active.typeCarburant.icon,
                      size: 16, color: AppColors.emerald),
                  const SizedBox(width: 6),
                  Text(active.marque,
                      style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 12)),
                  const Icon(Icons.expand_more_rounded,
                      color: Colors.white, size: 18),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _GaugeSection extends ConsumerWidget {
  const _GaugeSection({required this.devise});
  final String devise;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    final conso = stats?.moyenneL100km ?? 0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Center(
        child: ConsumptionGauge(
          value: conso,
          // échelle réaliste : 15 L/100km en plein.
          maxValue: 15,
          unit: 'L / 100 km',
          label: 'CONSOMMATION MOYENNE',
          size: 220,
        ),
      ),
    );
  }
}

class _QuickStats extends ConsumerWidget {
  const _QuickStats();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final stats = ref.watch(statisticsProvider);
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';
    if (stats == null) return const SizedBox.shrink();
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        StatCard(
          icon: Icons.payments_rounded,
          value: Formatters.money(stats.coutTotalGlobal, devise),
          label: 'Dépenses totales',
          gradient: AppColors.orangeGradient,
        ),
        StatCard(
          icon: Icons.local_gas_station_rounded,
          value: '${stats.nbPleins}',
          label: 'Pleins enregistrés',
          gradient: AppColors.emeraldGradient,
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
    if (dernier == null) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SectionHeader(
            title: 'Dernier plein', icon: Icons.history_rounded),
        GlassCard(
          onTap: () => context.go(Routes.pleins),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.orangeGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.local_gas_station_rounded,
                    color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Formatters.dateLong(dernier.date),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    Text(
                        '${Formatters.number(dernier.volume, decimals: 2)} L • ${dernier.odometre.toStringAsFixed(0)} km',
                        style: theme.textTheme.bodySmall),
                  ],
                ),
              ),
              Text(Formatters.money(dernier.prixTotal, devise),
                  style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700, color: AppColors.orange)),
            ],
          ),
        ),
      ],
    );
  }
}

class _UpcomingMaintenance extends ConsumerWidget {
  const _UpcomingMaintenance();
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final maintenances =
        ref.watch(maintenancesProvider).value ?? [];
    final aVenir = maintenances
        .where((m) => m.statut != StatutMaintenance.effectue)
        .take(3)
        .toList();
    if (aVenir.isEmpty) return const SizedBox.shrink();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionHeader(
          title: 'Entretien à venir',
          icon: Icons.build_rounded,
          action: TextButton(
            onPressed: () => context.go(Routes.maintenance),
            child: const Text('Tout voir'),
          ),
        ),
        ...aVenir.map((m) => Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: GlassCard(
                onTap: () => context.go(Routes.maintenance),
                padding: const EdgeInsets.all(14),
                child: Row(
                  children: [
                    Icon(m.type.icon, color: m.statut.color),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(m.type.label,
                          style: theme.textTheme.titleSmall),
                    ),
                    if (m.datePrevue != null)
                      Text(Formatters.relativeDate(m.datePrevue!),
                          style: theme.textTheme.bodySmall
                              ?.copyWith(color: m.statut.color)),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}
