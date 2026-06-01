import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
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
      await ExportService.instance
          .share(file, 'Rapport FuelTrack — ${vehicule.marque} ${vehicule.modele}');
    } finally {
      if (mounted) setState(() => _pdfLoading = false);
    }
  }

  Future<void> _exportCsv() async {
    final vehicule = ref.read(activeVehicleProvider);
    if (vehicule == null) return;
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

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
                child: Row(
                  children: [
                    IconButton(
                        onPressed: () => context.pop(),
                        icon: const Icon(Icons.arrow_back_rounded)),
                    Text('Exporter mes données',
                        style: theme.textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Expanded(
                child: vehicule == null
                    ? EmptyState(
                        icon: Icons.ios_share_rounded,
                        title: 'Aucune donnée',
                        message: 'Ajoutez un véhicule et des pleins à exporter.',
                      )
                    : ListView(
                        padding: const EdgeInsets.all(16),
                        children: [
                          GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: const LinearGradient(colors: [
                                          AppColors.danger,
                                          Color(0xFFB3303D)
                                        ]),
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                          Icons.picture_as_pdf_rounded,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                          'Rapport PDF mensuel avec statistiques et historique des pleins.',
                                          style: theme.textTheme.bodyMedium),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                GradientButton(
                                  label: 'Exporter en PDF',
                                  icon: Icons.picture_as_pdf_rounded,
                                  gradient: const LinearGradient(colors: [
                                    AppColors.danger,
                                    Color(0xFFB3303D)
                                  ]),
                                  loading: _pdfLoading,
                                  onPressed: _exportPdf,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          GlassCard(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.all(12),
                                      decoration: BoxDecoration(
                                        gradient: AppColors.emeraldGradient,
                                        borderRadius:
                                            BorderRadius.circular(14),
                                      ),
                                      child: const Icon(
                                          Icons.table_chart_rounded,
                                          color: Colors.white),
                                    ),
                                    const SizedBox(width: 14),
                                    Expanded(
                                      child: Text(
                                          'Export CSV complet : pleins, dépenses et maintenances (compatible Excel).',
                                          style: theme.textTheme.bodyMedium),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                GradientButton(
                                  label: 'Exporter en CSV',
                                  icon: Icons.table_chart_rounded,
                                  loading: _csvLoading,
                                  onPressed: _exportCsv,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
