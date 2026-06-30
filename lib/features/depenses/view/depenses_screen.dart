import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/router/app_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_card.dart';
import '../../../core/widgets/empty_state.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/depense_viewmodel.dart';

class DepensesScreen extends ConsumerWidget {
  const DepensesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final depensesAsync = ref.watch(depensesProvider);
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';

    return Scaffold(
      appBar: AppBar(title: const Text('Dépenses')),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(Routes.depenseForm),
        icon: const Icon(Icons.add_rounded),
        label: const Text('Dépense'),
      ),
      body: depensesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Erreur : $e')),
        data: (depenses) {
          if (depenses.isEmpty) {
            return const EmptyState(
              icon: Icons.account_balance_wallet_outlined,
              title: 'Aucune dépense',
              message:
                  'Suivez vos frais : assurance, péage, parking, réparations…',
            );
          }
          final total = depenses.fold<double>(0, (s, d) => s + d.montant);
          return ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 120),
            children: [
              AppCard(
                color: AppColors.petrol,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Total des dépenses',
                        style: TextStyle(color: Colors.white70)),
                    Text(Formatters.money(total, devise),
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              for (final d in depenses) ...[
                _DepenseCard(depense: d, devise: devise),
                const SizedBox(height: 12),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _DepenseCard extends ConsumerWidget {
  const _DepenseCard({required this.depense, required this.devise});
  final Depense depense;
  final String devise;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final cat = depense.categorie;
    final secondary = theme.brightness == Brightness.dark
        ? AppColors.textDarkSecondary
        : AppColors.slate500;
    final isDark = theme.brightness == Brightness.dark;

    return Dismissible(
      key: ValueKey(depense.id),
      direction: DismissDirection.endToStart,
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: AppColors.danger,
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Icon(Icons.delete_outline_rounded, color: Colors.white),
      ),
      onDismissed: (_) =>
          ref.read(depenseViewModelProvider.notifier).delete(depense.id),
      child: AppCard(
        onTap: () => context.push(Routes.depenseForm, extra: depense),
        child: Row(
          children: [
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color:
                    isDark ? AppColors.surfaceMutedDark : AppColors.surfaceMuted,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(cat.icon, color: AppColors.petrol, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cat.label,
                      style: theme.textTheme.titleSmall
                          ?.copyWith(fontWeight: FontWeight.w600)),
                  Text(
                    '${Formatters.date(depense.date)}${depense.description != null ? ' · ${depense.description}' : ''}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(color: secondary),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 8),
            Text(Formatters.money(depense.montant, devise),
                style: theme.textTheme.titleSmall
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ],
        ),
      ),
    );
  }
}
