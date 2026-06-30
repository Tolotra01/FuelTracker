import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../providers/app_providers.dart';
import '../../statistics/viewmodel/statistics_viewmodel.dart';
import '../../pleins/viewmodel/plein_viewmodel.dart';
import '../export_service.dart';

class ExportScreen extends ConsumerStatefulWidget {
  const ExportScreen({super.key});

  @override
  ConsumerState<ExportScreen> createState() => _ExportScreenState();
}

class _ExportScreenState extends ConsumerState<ExportScreen> {
  bool _pdfLoading = false;
  bool _csvLoading = false;

  Future<void> _exportPdf() async {
    final vehicule = ref.read(activeVehicleProvider);
    final stats = ref.read(statisticsProvider);
    final pleins = ref.read(pleinsAvecConsoProvider).value ?? [];
    final devise = ref.read(settingsStreamProvider).value?.devise ?? '€';
    if (vehicule == null || stats == null) return;

    setState(() => _pdfLoading = true);
    try {
      final file = await ExportService.instance.exportPdf(
        vehicule: vehicule,
        stats: stats,
        pleins: pleins,
        devise: devise,
      );
      await ExportService.instance.share(
          file, 'Rapport FuelTrack — ${vehicule.marque} ${vehicule.modele}');
    } finally {
      if (mounted) setState(() => _pdfLoading = false);
    }
  }

  Future<void> _exportCsv() async {
    final vehicule = ref.read(activeVehicleProvider);
    if (vehicule == null) return;
    final devise = ref.read(settingsStreamProvider).value?.devise ?? '€';
    setState(() => _csvLoading = true);
    try {
      final pleins =
          await ref.read(pleinRepositoryProvider).getByVehicle(vehicule.id);
      final depenses =
          await ref.read(depenseRepositoryProvider).getByVehicle(vehicule.id);
      final maintenances = await ref
          .read(maintenanceRepositoryProvider)
          .getByVehicle(vehicule.id);
      final file = await ExportService.instance.exportCsv(
        vehicule: vehicule,
        pleins: pleins,
        depenses: depenses,
        maintenances: maintenances,
        devise: devise,
      );
      await ExportService.instance.share(file, 'Export CSV FuelTrack');
    } finally {
      if (mounted) setState(() => _csvLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicule = ref.watch(activeVehicleProvider);
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

    return Scaffold(
      appBar: AppBar(title: const Text('Exporter mes données')),
      body: vehicule == null
          ? const EmptyState(
              icon: Icons.ios_share_outlined,
              title: 'Aucune donnée',
              message: 'Ajoutez un véhicule et des pleins à exporter.',
            )
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardHeader(
                        icon: Icons.picture_as_pdf_outlined,
                        text:
                            'Rapport PDF avec statistiques et historique des pleins.',
                        secondary: secondary,
                      ),
                      const SizedBox(height: 16),
                      PrimaryButton(
                        label: 'Exporter en PDF',
                        icon: Icons.picture_as_pdf_outlined,
                        loading: _pdfLoading,
                        onPressed: _exportPdf,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                AppCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _CardHeader(
                        icon: Icons.table_chart_outlined,
                        text:
                            'Export CSV complet : pleins, dépenses et maintenances (Excel).',
                        secondary: secondary,
                      ),
                      const SizedBox(height: 16),
                      SecondaryButton(
                        label: 'Exporter en CSV',
                        icon: Icons.table_chart_outlined,
                        onPressed: _csvLoading ? null : _exportCsv,
                      ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }
}

class _CardHeader extends StatelessWidget {
  const _CardHeader(
      {required this.icon, required this.text, required this.secondary});
  final IconData icon;
  final String text;
  final Color secondary;
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Row(
      children: [
        Container(
          height: 44,
          width: 44,
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceMutedDark : AppColors.surfaceMuted,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: AppColors.petrol),
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Text(text,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: secondary)),
        ),
      ],
    );
  }
}
