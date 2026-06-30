import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
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
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

    return Scaffold(
      appBar: AppBar(
        titleSpacing: 20,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Journal des pleins'),
            if (vehicule != null)
              Text('${vehicule.marque} ${vehicule.modele}',
                  style:
                      theme.textTheme.bodySmall?.copyWith(color: secondary)),
          ],
        ),
      ),
      floatingActionButton: vehicule == null
          ? null
          : FloatingActionButton.extended(
              onPressed: () => context.push(Routes.pleinForm),
              icon: const Icon(Icons.add_rounded),
              label: const Text('Plein'),
            ),
      body: vehicule == null
          ? EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Aucun véhicule',
              message: 'Ajoutez un véhicule pour enregistrer vos pleins.',
              action: SizedBox(
                width: 220,
                child: PrimaryButton(
                  label: 'Ajouter un véhicule',
                  icon: Icons.add_rounded,
                  onPressed: () => context.push(Routes.vehicleForm),
                ),
              ),
            )
          : pleinsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Center(child: Text('Erreur : $e')),
              data: (pleins) {
                if (pleins.isEmpty) {
                  return const EmptyState(
                    icon: Icons.local_gas_station_outlined,
                    title: 'Aucun plein enregistré',
                    message:
                        'Touchez « Plein » pour ajouter votre premier plein.',
                  );
                }
                return ListView.separated(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
                  itemCount: pleins.length,
                  separatorBuilder: (_, _) => const SizedBox(height: 12),
                  itemBuilder: (_, i) =>
                      _PleinCard(data: pleins[i], devise: devise),
                );
              },
            ),
    );
  }
}

class _PleinCard extends StatelessWidget {
  const _PleinCard({required this.data, required this.devise});
  final PleinAvecConso data;
  final String devise;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final p = data.plein;
    final conso = data.consommation;
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

    return AppCard(
      onTap: () => context.push(Routes.pleinForm, extra: p),
      child: Column(
        children: [
          Row(
            children: [
              _LeadingIcon(),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(Formatters.dateLong(p.date),
                        style: theme.textTheme.titleSmall
                            ?.copyWith(fontWeight: FontWeight.w600)),
                    const SizedBox(height: 2),
                    Text(
                      '${Formatters.number(p.volume, decimals: 2)} L · ${p.station ?? 'Station'}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style:
                          theme.textTheme.bodySmall?.copyWith(color: secondary),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(Formatters.money(p.prixTotal, devise),
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  Text('${Formatters.money(p.prixUnitaire, devise)}/L',
                      style:
                          theme.textTheme.bodySmall?.copyWith(color: secondary)),
                ],
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              _Tag(icon: Icons.speed_outlined, text: '${p.odometre.toStringAsFixed(0)} km'),
              const SizedBox(width: 8),
              _Tag(
                icon: Icons.local_gas_station_outlined,
                text: p.typePlein.label,
              ),
              const Spacer(),
              if (conso != null)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: AppColors.accentSoft,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${conso.litresPour100km.toStringAsFixed(1)} L/100',
                    style: const TextStyle(
                        color: AppColors.accentPressed,
                        fontWeight: FontWeight.w700,
                        fontSize: 12),
                  ),
                )
              else
                Text('—',
                    style:
                        theme.textTheme.bodySmall?.copyWith(color: secondary)),
            ],
          ),
        ],
      ),
    );
  }
}

class _LeadingIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      height: 44,
      width: 44,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceMutedDark : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const Icon(Icons.local_gas_station_outlined,
          color: AppColors.petrol, size: 22),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.icon, required this.text});
  final IconData icon;
  final String text;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final secondary =
        isDark ? AppColors.textDarkSecondary : AppColors.slate500;
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
