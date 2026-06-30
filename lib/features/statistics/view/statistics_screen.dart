import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../core/widgets/kpi_tile.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/statistics_viewmodel.dart';

class StatisticsScreen extends ConsumerWidget {
  const StatisticsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicule = ref.watch(activeVehicleProvider);
    final stats = ref.watch(statisticsProvider);
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';
    final uniteDistance =
        ref.watch(settingsStreamProvider).value?.uniteDistance ?? 'km';

    return Scaffold(
      appBar: AppBar(title: const Text('Statistiques')),
      body: vehicule == null
          ? const EmptyState(
              icon: Icons.insights_outlined,
              title: 'Pas de statistiques',
              message:
                  'Ajoutez un véhicule et des pleins pour voir vos analyses.',
            )
          : (stats == null || stats.nbPleins == 0)
              ? const EmptyState(
                  icon: Icons.insights_outlined,
                  title: 'Données insuffisantes',
                  message:
                      'Enregistrez au moins deux pleins complets pour calculer la consommation.',
                )
              : ListView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                  children: [
                    if (stats.anomalies > 0) ...[
                      _AnomalyBanner(stats.anomalies),
                      const SizedBox(height: 12),
                    ],
                    GridView.count(
                      crossAxisCount: 2,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      mainAxisSpacing: 12,
                      crossAxisSpacing: 12,
                      childAspectRatio: 1.2,
                      children: [
                        KpiTile(
                          icon: Icons.speed_outlined,
                          accent: true,
                          value: stats.moyenneL100km != null
                              ? '${stats.moyenneL100km!.toStringAsFixed(1)} L'
                              : '—',
                          label: 'Conso moyenne /100 km',
                        ),
                        KpiTile(
                          icon: Icons.payments_outlined,
                          value: Formatters.money(stats.coutTotalGlobal, devise),
                          label: 'Coût total',
                        ),
                        KpiTile(
                          icon: Icons.route_outlined,
                          value:
                              Formatters.distance(stats.distanceTotale, uniteDistance),
                          label: 'Distance suivie',
                        ),
                        KpiTile(
                          icon: Icons.sell_outlined,
                          value: stats.coutParKm != null
                              ? Formatters.money(stats.coutParKm!, devise)
                              : '—',
                          label: 'Coût par km',
                        ),
                        KpiTile(
                          icon: Icons.ev_station_outlined,
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
                    ),
                    const SizedBox(height: 8),
                    if (stats.consoParMois.length >= 2) ...[
                      const SectionLabel('Consommation (L/100 km)'),
                      AppCard(
                        child: SizedBox(
                            height: 200, child: _ConsoLineChart(stats)),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (stats.coutParMois.isNotEmpty) ...[
                      const SectionLabel('Coûts par mois'),
                      AppCard(
                        child: SizedBox(
                            height: 200, child: _CoutBarChart(stats)),
                      ),
                      const SizedBox(height: 8),
                    ],
                    if (stats.repartitionDepenses.isNotEmpty) ...[
                      const SectionLabel('Répartition des coûts'),
                      AppCard(child: _RepartitionPie(stats, devise)),
                    ],
                  ],
                ),
    );
  }
}

class _AnomalyBanner extends StatelessWidget {
  const _AnomalyBanner(this.count);
  final int count;
  @override
  Widget build(BuildContext context) {
    return AppCard(
      color: AppColors.danger.withValues(alpha: 0.10),
      child: Row(
        children: [
          const Icon(Icons.warning_amber_rounded, color: AppColors.danger),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              '$count consommation(s) anormale(s) détectée(s) — au-dessus du seuil d\'alerte.',
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: AppColors.danger),
            ),
          ),
        ],
      ),
    );
  }
}

Color _axisColor(BuildContext c) =>
    Theme.of(c).brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;

Color _gridColor(BuildContext c) =>
    Theme.of(c).brightness == Brightness.dark
        ? AppColors.lineDark
        : AppColors.line;

class _ConsoLineChart extends StatelessWidget {
  const _ConsoLineChart(this.stats);
  final StatsData stats;
  @override
  Widget build(BuildContext context) {
    final pts = stats.consoParMois;
    final spots = [
      for (var i = 0; i < pts.length; i++) FlSpot(i.toDouble(), pts[i].valeur)
    ];
    final axis = _axisColor(context);
    return LineChart(
      LineChartData(
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: _gridColor(context), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              getTitlesWidget: (v, _) => Text(v.toStringAsFixed(0),
                  style: TextStyle(color: axis, fontSize: 10)),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              interval: 1,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= pts.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(Formatters.monthShort(pts[i].mois),
                      style: TextStyle(color: axis, fontSize: 10)),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          LineChartBarData(
            spots: spots,
            isCurved: true,
            color: AppColors.accent,
            barWidth: 3,
            dotData: FlDotData(
              show: true,
              getDotPainter: (s, pct, bar, idx) => FlDotCirclePainter(
                  radius: 3, color: AppColors.accent, strokeWidth: 0),
            ),
            belowBarData: BarAreaData(
              show: true,
              color: AppColors.accent.withValues(alpha: 0.10),
            ),
          ),
        ],
      ),
    );
  }
}

class _CoutBarChart extends StatelessWidget {
  const _CoutBarChart(this.stats);
  final StatsData stats;
  @override
  Widget build(BuildContext context) {
    final pts = stats.coutParMois;
    final maxVal =
        pts.map((e) => e.valeur).fold<double>(0, (a, b) => a > b ? a : b);
    final maxY = maxVal <= 0 ? 10.0 : maxVal * 1.25;
    final axis = _axisColor(context);
    return BarChart(
      BarChartData(
        maxY: maxY,
        alignment: BarChartAlignment.spaceAround,
        gridData: FlGridData(
          show: true,
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) =>
              FlLine(color: _gridColor(context), strokeWidth: 1),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles:
              const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (v, meta) {
                if (v == 0 || v >= maxY) return const SizedBox.shrink();
                return Text(Formatters.compact(v),
                    style: TextStyle(color: axis, fontSize: 10));
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 26,
              getTitlesWidget: (value, _) {
                final i = value.toInt();
                if (i < 0 || i >= pts.length) return const SizedBox.shrink();
                return Padding(
                  padding: const EdgeInsets.only(top: 6),
                  child: Text(Formatters.monthShort(pts[i].mois),
                      style: TextStyle(color: axis, fontSize: 10)),
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
                width: 14,
                borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(4)),
                color: AppColors.petrol,
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
    final secondary = _axisColor(context);

    return Column(
      children: [
        SizedBox(
          height: 170,
          child: PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: 46,
              sections: [
                for (final e in entries)
                  PieChartSectionData(
                    value: e.value,
                    color: e.key.color,
                    radius: 40,
                    showTitle: total > 0 && e.value / total > 0.10,
                    title: '${(e.value / total * 100).toStringAsFixed(0)}%',
                    titleStyle: const TextStyle(
                        color: Colors.white,
                        fontSize: 11,
                        fontWeight: FontWeight.w700),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16),
        Wrap(
          spacing: 14,
          runSpacing: 10,
          children: [
            for (final e in entries)
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                        color: e.key.color,
                        borderRadius: BorderRadius.circular(3)),
                  ),
                  const SizedBox(width: 6),
                  Text('${e.key.label} · ${Formatters.money(e.value, devise)}',
                      style: Theme.of(context)
                          .textTheme
                          .bodySmall
                          ?.copyWith(color: secondary)),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
