import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../providers/app_providers.dart';
import '../../../data/local/database.dart';
import '../viewmodel/vehicle_viewmodel.dart';

class VehiclesScreen extends ConsumerWidget {
  const VehiclesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehiclesAsync = ref.watch(vehiclesStreamProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mes véhicules')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.vehicleForm),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Véhicule'),
      ),
      body: vehiclesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (vehicles) {
          if (vehicles.isEmpty) {
            return EmptyState(
              icon: Icons.directions_car_outlined,
              title: 'Aucun véhicule',
              message: 'Ajoutez votre premier véhicule pour commencer le suivi.',
              action: SizedBox(
                width: 220,
                child: PrimaryButton(
                  label: 'Ajouter un véhicule',
                  icon: Icons.add_rounded,
                  onPressed: () => context.push(Routes.vehicleForm),
                ),
              ),
            );
          }
          return ListView.separated(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            itemCount: vehicles.length,
            separatorBuilder: (_, _) => const SizedBox(height: 12),
            itemBuilder: (_, i) => _VehicleCard(vehicule: vehicles[i]),
          );
        },
      ),
    );
  }
}

class _VehicleCard extends ConsumerWidget {
  const _VehicleCard({required this.vehicule});
  final Vehicule vehicule;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final kmAsync = ref.watch(kmActuelProvider(vehicule));
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

    return AppCard(
      onTap: () => context.push(Routes.vehicleForm, extra: vehicule),
      child: Row(
        children: [
          _Avatar(vehicule: vehicule),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        '${vehicule.marque} ${vehicule.modele}',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w600),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (vehicule.parDefaut) ...[
                      const SizedBox(width: 8),
                      _DefaultBadge(),
                    ],
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '${vehicule.typeCarburant.label} • ${vehicule.annee}',
                  style: theme.textTheme.bodySmall?.copyWith(color: secondary),
                ),
                const SizedBox(height: 2),
                kmAsync.when(
                  loading: () => const SizedBox.shrink(),
                  error: (_, _) => const SizedBox.shrink(),
                  data: (km) => Text(
                    '${km.toStringAsFixed(0)} km au compteur',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: AppColors.accent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded, color: secondary),
            onSelected: (value) async {
              final vm = ref.read(vehicleViewModelProvider.notifier);
              if (value == 'default') {
                await vm.setDefault(vehicule.id);
              } else if (value == 'edit') {
                if (context.mounted) {
                  context.push(Routes.vehicleForm, extra: vehicule);
                }
              } else if (value == 'delete') {
                final ok = await _confirmDelete(context);
                if (ok) await vm.delete(vehicule.id);
              }
            },
            itemBuilder: (_) => [
              if (!vehicule.parDefaut)
                const PopupMenuItem(
                    value: 'default', child: Text('Définir par défaut')),
              const PopupMenuItem(value: 'edit', child: Text('Modifier')),
              const PopupMenuItem(value: 'delete', child: Text('Supprimer')),
            ],
          ),
        ],
      ),
    );
  }

  Future<bool> _confirmDelete(BuildContext context) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Supprimer le véhicule ?'),
        content: const Text(
            'Tous les pleins, dépenses et maintenances associés seront aussi supprimés.'),
        actions: [
          TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Annuler')),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Supprimer'),
          ),
        ],
      ),
    );
    return result ?? false;
  }
}

class _DefaultBadge extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(8),
      ),
      child: const Text('Défaut',
          style: TextStyle(
              color: AppColors.accentPressed,
              fontSize: 11,
              fontWeight: FontWeight.w600)),
    );
  }
}

class _Avatar extends StatelessWidget {
  const _Avatar({required this.vehicule});
  final Vehicule vehicule;

  @override
  Widget build(BuildContext context) {
    final photo = vehicule.photo;
    if (photo != null && File(photo).existsSync()) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(12),
        child:
            Image.file(File(photo), width: 52, height: 52, fit: BoxFit.cover),
      );
    }
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceMutedDark : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(vehicule.typeCarburant.icon, color: AppColors.petrol),
    );
  }
}
