import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/consumption_calculator.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../data/repositories/plein_repository.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/plein_viewmodel.dart';

class PleinsScreen extends ConsumerWidget {
  const PleinsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final vehicule = ref.watch(activeVehicleProvider);
    final pleinsAsync = ref.watch(pleinsAvecConsoProvider);
    final settings = ref.watch(settingsStreamProvider).value;
    final devise = settings?.devise ?? '€';

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Journal des pleins',
                              style: theme.textTheme.headlineSmall
                                  ?.copyWith(fontWeight: FontWeight.w700)),
                          if (vehicule != null)
                            Text('${vehicule.marque} ${vehicule.modele}',
                                style: theme.textTheme.bodySmall),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: vehicule == null
                    ? EmptyState(
                        icon: Icons.directions_car_rounded,
                        title: 'Aucun véhicule',
                        message: 'Ajoutez un véhicule pour enregistrer vos pleins.',
                        action: GradientButton(
                          label: 'Ajouter un véhicule',
                          icon: Icons.add_rounded,
                          expanded: false,
                          onPressed: () => context.push(Routes.vehicleForm),
                        ),
                      )
                    : pleinsAsync.when(
                        loading: () =>
                            const Center(child: CircularProgressIndicator()),
                        error: (e, _) => Center(child: Text('Erreur : $e')),
                        data: (pleins) {
                          if (pleins.isEmpty) {
                            return EmptyState(
                              icon: Icons.local_gas_station_rounded,
                              title: 'Aucun plein enregistré',
                              message:
                                  'Touchez le bouton + pour ajouter votre premier plein.',
                            );
                          }
                          return ListView.separated(
                            padding:
                                const EdgeInsets.fromLTRB(16, 8, 16, 140),
                            itemCount: pleins.length,
                            separatorBuilder: (_, _) =>
                                const SizedBox(height: 12),
                            itemBuilder: (_, i) => _PleinCard(
                              data: pleins[i],
                              devise: devise,
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PleinCard extends ConsumerWidget {
  const _PleinCard({required this.data, required this.devise});
  final PleinAvecConso data;
  final String devise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final p = data.plein;
    final conso = data.consommation;

    return GlassCard(
      onTap: () => context.push(Routes.pleinForm, extra: p),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  gradient: AppColors.orangeGradient,
                  borderRadius: BorderRadius.circular(14),
                ),
                child:
                    const Icon(Icons.local_gas_station_rounded, color: Colors.white),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Formatters.dateLong(p.date),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    Text(
                      '${Formatters.number(p.volume, decimals: 2)} L • ${p.station ?? 'Station'}',
                      style: theme.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Formatters.money(p.prixTotal, devise),
                      style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          color: AppColors.orange)),
                  Text('${Formatters.money(p.prixUnitaire, devise)}/L',
                      style: theme.textTheme.bodySmall),
                ],
              ),
            ],
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              _Pill(
                icon: Icons.speed_rounded,
                text: '${p.odometre.toStringAsFixed(0)} km',
              ),
              const SizedBox(width: 8),
              if (p.typePlein.label.isNotEmpty)
                _Pill(
                  icon: Icons.local_gas_station_outlined,
                  text: p.typePlein.label,
                ),
              const Spacer(),
              if (conso != null)
                _ConsoBadge(conso: conso)
              else
                Text('—',
                    style: theme.textTheme.bodySmall
                        ?.copyWith(color: Colors.grey)),
            ],
          ),
        ],
      ),
    );
  }
}

class _Pill extends StatelessWidget {
  const _Pill({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 13),
          const SizedBox(width: 4),
          Text(text, style: Theme.of(context).textTheme.labelSmall),
        ],
      ),
    );
  }
}

class _ConsoBadge extends StatelessWidget {
  const _ConsoBadge({required this.conso});
  final ConsumptionResult conso;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        gradient: AppColors.emeraldGradient,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        '${conso.litresPour100km.toStringAsFixed(1)} L/100',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.w700, fontSize: 12),
      ),
    );
  }
}
