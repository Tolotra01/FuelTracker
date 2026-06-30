import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/services/notification_service.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/kpi_tile.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/settings_viewmodel.dart';

class SettingsScreen extends ConsumerWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(settingsStreamProvider);
    final vm = ref.read(settingsViewModelProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: const Text('Réglages')),
      body: settings.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (r) => ListView(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
          children: [
            const SectionLabel('Gestion'),
            AppCard(
              padding: EdgeInsets.zero,
              child: Column(
                children: [
                  _navTile(context, Icons.directions_car_outlined,
                      'Mes véhicules', Routes.vehicles),
                  const Divider(height: 1, indent: 56),
                  _navTile(context, Icons.account_balance_wallet_outlined,
                      'Dépenses', Routes.depenses),
                  const Divider(height: 1, indent: 56),
                  _navTile(context, Icons.ios_share_outlined,
                      'Exporter mes données', Routes.export),
                ],
              ),
            ),
            const SizedBox(height: 8),

            const SectionLabel('Apparence'),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Thème'),
                  const SizedBox(height: 10),
                  SegmentedButton<int>(
                    showSelectedIcon: false,
                    segments: const [
                      ButtonSegment(value: 0, label: Text('Auto')),
                      ButtonSegment(value: 1, label: Text('Clair')),
                      ButtonSegment(value: 2, label: Text('Sombre')),
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
                    onChanged: vm.setGrandTexte,
                  ),
                  SwitchListTile(
                    contentPadding: EdgeInsets.zero,
                    title: const Text('Contraste élevé'),
                    value: r.contrasteEleve,
                    onChanged: vm.setContrasteEleve,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8),

            const SectionLabel('Unités & devise'),
            AppCard(
              child: Column(
                children: [
                  _choice(context, 'Devise', r.devise,
                      ['Ar', '€', '\$', 'FCFA', 'CHF', 'CAD'], vm.setDevise),
                  const Divider(height: 24),
                  _choice(context, 'Distance', r.uniteDistance, ['km', 'mi'],
                      vm.setUniteDistance),
                  const Divider(height: 24),
                  _choice(context, 'Volume', r.uniteVolume, ['L', 'gal'],
                      vm.setUniteVolume),
                ],
              ),
            ),
            const SizedBox(height: 8),

            const SectionLabel('Alertes intelligentes'),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      "Seuil d'anomalie de consommation : +${r.seuilAlerte.toStringAsFixed(0)} %"),
                  Slider(
                    value: r.seuilAlerte.clamp(5, 50),
                    min: 5,
                    max: 50,
                    divisions: 9,
                    label: '+${r.seuilAlerte.toStringAsFixed(0)} %',
                    onChanged: (v) => vm.setSeuilAlerte(v),
                  ),
                  ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: const Icon(Icons.notifications_outlined,
                        color: AppColors.petrol),
                    title: const Text('Activer les notifications'),
                    trailing: const Icon(Icons.chevron_right_rounded,
                        color: AppColors.slate400),
                    onTap: () async {
                      await NotificationService.instance.requestPermission();
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
            const SizedBox(height: 8),

            const SectionLabel('À propos'),
            AppCard(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.asset('assets/images/logo.jpg',
                            width: 44, height: 44, fit: BoxFit.cover),
                      ),
                      const SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('FuelTrack',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.copyWith(fontWeight: FontWeight.w600)),
                          Text('Version 1.0.0 · 100 % hors-ligne',
                              style: Theme.of(context).textTheme.bodySmall),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "Suivi de consommation, dépenses et entretien. Aucune donnée n'est envoyée sur Internet.",
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _navTile(
      BuildContext context, IconData icon, String title, String route) {
    return ListTile(
      leading: Icon(icon, color: AppColors.petrol),
      title: Text(title),
      trailing:
          const Icon(Icons.chevron_right_rounded, color: AppColors.slate400),
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
        const SizedBox(height: 10),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final o in options)
              ChoiceChip(
                label: Text(o),
                labelStyle:
                    TextStyle(color: current == o ? Colors.white : null),
                selected: current == o,
                onSelected: (_) => onSelect(o),
              ),
          ],
        ),
      ],
    );
  }
}
