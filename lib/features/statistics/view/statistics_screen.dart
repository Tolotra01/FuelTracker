import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/section_header.dart';
import '../../../core/widgets/stat_card.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/statistics_viewmodel.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final vehicule = ref.watch(activeVehicleProvider);
    final stats = ref.watch(statisticsProvider);
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';
    final uniteDistance =
        ref.watch(settingsStreamProvider).value?.uniteDistance ?? 'km';

    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: vehicule == null
              ? EmptyState(
                  icon: Icons.bar_chart_rounded,
                  title: 'Pas de statistiques',
                  message: 'Ajoutez un véhicule et des pleins pour voir vos analyses.',
                )
              : CustomScrollView(
                  slivers: [
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 8, 20, 8),
                      sliver: SliverToBoxAdapter(
                        child: Text('Statistiques',
                            style: theme.textTheme.headlineSmall
                                ?.copyWith(fontWeight: FontWeight.w700)),
                      ),
                    ),
                    if (stats == null || stats.nbPleins == 0)
                      SliverFillRemaining(
                        hasScrollBody: false,
                        child: EmptyState(
                          icon: Icons.insights_rounded,
                          title: 'Données insuffisantes',
                          message:
                              'Enregistrez au moins deux pleins complets pour calculer la consommation.',
                        ),
                      )
                    else
                      SliverPadding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 140),
                        sliver: SliverList(
                          delegate: SliverChildListDelegate([
                            if (stats.anomalies > 0) _AnomalyBanner(stats.anomalies),
                            GridView.count(
                              crossAxisCount: 2,
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 1.35,
                              children: [
                                StatCard(
                                  icon: Icons.speed_rounded,
                                  value: stats.moyenneL100km != null
                                      ? '${stats.moyenneL100km!.toStringAsFixed(1)} L'
                                      : '—',
                                  label: 'Conso moyenne /100km',
                                  gradient: AppColors.emeraldGradient,
                                ),
                                StatCard(
                                  icon: Icons.payments_rounded,
                                  value: Formatters.money(
                                      stats.coutTotalGlobal, devise),
                                  label: 'Coût total',
                                  gradient: AppColors.orangeGradient,
                                ),
                                StatCard(
                                  icon: Icons.route_rounded,
                                  value: Formatters.distance(
                                      stats.distanceTotale, uniteDistance),
                                  label: 'Distance suivie',
                                  gradient: const LinearGradient(colors: [
                                    AppColors.info,
                                    Color(0xFF2A6FB0)
                                  ]),
                                ),
                                StatCard(
                                  icon: Icons.attach_money_rounded,
                                  value: stats.coutParKm != null
                                      ? Formatters.money(
                                          stats.coutParKm!, devise)
                                      : '—',
                                  label: 'Coût par km',
                                  gradient: const LinearGradient(colors: [
                                    Color(0xFFB47BFF),
                                    Color(0xFF7E51C9)
                                  ]),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            if (stats.consoParMois.length >= 2) ...[
                              const SectionHeader(
                                  title: 'Consommation (L/100km)',
                                  icon: Icons.show_chart_rounded),
                              GlassCard(
                                height: 240,
                                child: _ConsoLineChart(stats),
                              ),
                              const SizedBox(height: 20),
                            ],
                            if (stats.coutParMois.isNotEmpty) ...[
                              const SectionHeader(
                                  title: 'Coûts par mois',
                                  icon: Icons.bar_chart_rounded),
                              GlassCard(
                                height: 240,
                                child: _CoutBarChart(stats, devise),
                              ),
                              const SizedBox(height: 20),
                            ],
                            if (stats.repartitionDepenses.isNotEmpty) ...[
                              const SectionHeader(
                                  title: 'Répartition des coûts',
                                  icon: Icons.pie_chart_rounded),
                              GlassCard(
                                child: _RepartitionPie(stats, devise),
                              ),
                            ],
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

class _AnomalyBanner extends StatelessWidget {
  const _AnomalyBanner(this.count);
  final int count;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: GlassCard(
        gradient: const LinearGradient(
            colors: [AppColors.danger, Color(0xFFB3303D)]),
        child: Row(
          children: [
            const Icon(Icons.warning_amber_rounded, color: Colors.white),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                '$count consommation(s) anormale(s) détectée(s) (+20% au-dessus de la moyenne).',
                style: const TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConsoLineChart extends StatelessWidget {
  const _ConsoLineChart(this.stats);
  final StatsData stats;
  @override
  Widget build(BuildContext context) {
    final pts = stats.consoParMois;
    final spots = [
      for (var i = 0; i < pts.length; i++) FlSpot(i.toDouble(), pts[i].valeur)
    ];
    return LineChart(
      LineChartData(
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
              sideTitles: SideTitles(
                  showTitles: true, reservedSize: 34, interval: 2)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= pts.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(Formatters.monthShort(pts[i].mois),
                      style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            gradient: AppColors.brandGradient,
            barWidth: 4,
            dotData: const FlDotData(show: true),
            belowBarData: BarAreaData(
              show: true,
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  AppColors.emerald.withValues(alpha: 0.3),
                  AppColors.emerald.withValues(alpha: 0.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoutBarChart extends StatelessWidget {
  const _CoutBarChart(this.stats, this.devise);
  final StatsData stats;
  final String devise;
  @override
  Widget build(BuildContext context) {
    final pts = stats.coutParMois;
    final maxY = pts.isEmpty
        ? 10.0
        : pts.map((e) => e.valeur).reduce((a, b) => a > b ? a : b) * 1.25;
    return BarChart(
      BarChartData(
        maxY: maxY,
        gridData: FlGridData(show: true, drawVerticalLine: false),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: true, reservedSize: 40)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= pts.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(Formatters.monthShort(pts[i].mois),
                      style: const TextStyle(fontSize: 10)),
                );
              },
            ),
          ),
        ),
        barGroups: [
          for (var i = 0; i < pts.length; i++)
            BarChartGroupData(x: i, barRods: [
              BarChartRodData(
                toY: pts[i].valeur,
                width: 16,
                borderRadius: BorderRadius.circular(6),
                gradient: AppColors.orangeGradient,
              ),
            ]),
        ],
      ),
    );
  }
}

class _RepartitionPie extends StatelessWidget {
  const _RepartitionPie(this.stats, this.devise);
  final StatsData stats;
  final String devise;
  @override
  Widget build(BuildContext context) {
    final entries = stats.repartitionDepenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final total = entries.fold<double>(0, (s, e) => s + e.value);

    return Column(
      children: [
        SizedBox(
          height: 180,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 44,
              sections: [
                for (final e in entries)
                  PieChartSectionData(
                    value: e.value,
                    color: e.key.color,
                    radius: 50,
                    showTitle: total > 0 && e.value / total > 0.08,
                    title: '${(e.value / total * 100).toStringAsFixed(0)}%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.bold),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 8,
          children: [
            for (final e in entries)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 12,
                    height: 12,
                    decoration: BoxDecoration(
                        color: e.key.color,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  const SizedBox(width: 6),
                  Text('${e.key.label} • ${Formatters.money(e.value, devise)}',
                      style: Theme.of(context).textTheme.bodySmall),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
