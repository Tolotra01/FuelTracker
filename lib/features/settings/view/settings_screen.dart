import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/settings_viewmodel.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsStreamProvider);
    final vm = ref.read(settingsViewModelProvider.notifier);

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: settings.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (e, _) => Center(child: Text('Erreur : $e')),
            data: (r) => ListView(
              padding: const EdgeInsets.fromLTRB(16, 8, 16, 140),
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 4, bottom: 12),
                  child: Text('Réglages',
                      style: theme.textTheme.headlineSmall
                          ?.copyWith(fontWeight: FontWeight.w700)),
                ),

                // Navigation
                const SectionHeader(title: 'Gestion', icon: Icons.tune_rounded),
                GlassCard(
                  padding: EdgeInsets.zero,
                  child: Column(
                    children: [
                      _navTile(context, Icons.directions_car_rounded,
                          'Mes véhicules', Routes.vehicles),
                      const Divider(height: 1),
                      _navTile(context, Icons.account_balance_wallet_rounded,
                          'Dépenses', Routes.depenses),
                      const Divider(height: 1),
                      _navTile(context, Icons.ios_share_rounded,
                          'Exporter mes données', Routes.export),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Apparence
                const SectionHeader(
                    title: 'Apparence', icon: Icons.palette_rounded),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Thème'),
                      const SizedBox(height: 10),
                      SegmentedButton<int>(
                        segments: const [
                          ButtonSegment(
                              value: 0,
                              label: Text('Auto'),
                              icon: Icon(Icons.brightness_auto_rounded)),
                          ButtonSegment(
                              value: 1,
                              label: Text('Clair'),
                              icon: Icon(Icons.light_mode_rounded)),
                          ButtonSegment(
                              value: 2,
                              label: Text('Sombre'),
                              icon: Icon(Icons.dark_mode_rounded)),
                        ],
                        selected: {r.themeMode},
                        onSelectionChanged: (s) => vm.setThemeMode(s.first),
                      ),
                      const Divider(height: 28),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Grand texte'),
                        subtitle: const Text('Accessibilité'),
                        value: r.grandTexte,
                        activeThumbColor: AppColors.emerald,
                        onChanged: vm.setGrandTexte,
                      ),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        title: const Text('Contraste élevé'),
                        value: r.contrasteEleve,
                        activeThumbColor: AppColors.emerald,
                        onChanged: vm.setContrasteEleve,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Unités
                const SectionHeader(
                    title: 'Unités & devise',
                    icon: Icons.straighten_rounded),
                GlassCard(
                  child: Column(
                    children: [
                      _choice(context, 'Devise', r.devise,
                          ['€', '\$', '£', 'MAD', 'CHF', 'CAD'],
                          vm.setDevise),
                      const Divider(height: 20),
                      _choice(context, 'Distance', r.uniteDistance,
                          ['km', 'mi'], vm.setUniteDistance),
                      const Divider(height: 20),
                      _choice(context, 'Volume', r.uniteVolume,
                          ['L', 'gal'], vm.setUniteVolume),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Alertes
                const SectionHeader(
                    title: 'Alertes intelligentes',
                    icon: Icons.notifications_active_rounded),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          'Seuil d\'anomalie de consommation : +${r.seuilAlerte.toStringAsFixed(0)}%'),
                      Slider(
                        value: r.seuilAlerte.clamp(5, 50),
                        min: 5,
                        max: 50,
                        divisions: 9,
                        activeColor: AppColors.emerald,
                        label: '+${r.seuilAlerte.toStringAsFixed(0)}%',
                        onChanged: (v) => vm.setSeuilAlerte(v),
                      ),
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(Icons.notifications_rounded,
                            color: AppColors.emerald),
                        title: const Text('Activer les notifications'),
                        trailing: const Icon(Icons.chevron_right_rounded),
                        onTap: () async {
                          await NotificationService.instance
                              .requestPermission();
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content:
                                      Text('Permission de notification demandée')),
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // À propos
                const SectionHeader(
                    title: 'À propos', icon: Icons.info_rounded),
                GlassCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset('assets/images/logo.jpg',
                                width: 48, height: 48, fit: BoxFit.cover),
                          ),
                          const SizedBox(width: 12),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('FuelTrack',
                                  style: theme.textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w700)),
                              Text('Version 1.0.0 • 100% hors-ligne',
                                  style: theme.textTheme.bodySmall),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Suivi de consommation de carburant, dépenses et maintenance. '
                        'Aucune donnée n\'est envoyée sur Internet — respect total de la vie privée.',
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _navTile(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.emerald),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right_rounded),
      onTap: () => context.push(route),
    );
  }

  Widget _choice(BuildContext context, String label, String current,
      List<String> options, void Function(String) onSelect) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label,
            style: Theme.of(context)
                .textTheme
                .bodyMedium
                ?.copyWith(fontWeight: FontWeight.w600)),
        const SizedBox(height: 8),
        Wrap(
          spacing: 6,
          runSpacing: 6,
          children: [
            for (final o in options)
              ChoiceChip(
                label: Text(o),
                selected: current == o,
                selectedColor: AppColors.emerald,
                onSelected: (_) => onSelect(o),
              ),
          ],
        ),
      ],
    );
  }
}
