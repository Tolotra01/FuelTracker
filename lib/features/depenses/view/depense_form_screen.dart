import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/services/image_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/depense_viewmodel.dart';

class DepenseFormScreen extends ConsumerStatefulWidget {
  const DepenseFormScreen({super.key, this.depense});
  final Depense? depense;

  @override
  ConsumerState<DepenseFormScreen> createState() => _DepenseFormScreenState();
}

class _DepenseFormScreenState extends ConsumerState<DepenseFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _montant;
  late final TextEditingController _description;
  late DateTime _date;
  late CategorieDepense _categorie;
  String? _photo;
  bool _saving = false;

  bool get _isEdit => widget.depense != null;

  @override
  void initState() {
    super.initState();
    final d = widget.depense;
    _montant = TextEditingController(
        text: d != null ? d.montant.toStringAsFixed(2) : '');
    _description = TextEditingController(text: d?.description ?? '');
    _date = d?.date ?? DateTime.now();
    _categorie = d?.categorie ?? CategorieDepense.assurance;
    _photo = d?.photo;
  }

  @override
  void dispose() {
    _montant.dispose();
    _description.dispose();
    super.dispose();
  }

  Future<void> _save(String vehiculeId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(depenseViewModelProvider.notifier).save(
            id: widget.depense?.id,
            vehiculeId: vehiculeId,
            date: _date,
            montant: double.parse(_montant.text.replaceAll(',', '.')),
            categorie: _categorie,
            description: _description.text.trim().isEmpty
                ? null
                : _description.text.trim(),
            photo: _photo,
          );
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final vehicule = ref.watch(activeVehicleProvider);
    if (vehicule == null) {
      return const Scaffold(
        body: Center(child: Text('Ajoutez un véhicule au préalable.')),
      );
    }

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
                        icon: const Icon(Icons.close_rounded)),
                    Text(_isEdit ? 'Modifier la dépense' : 'Nouvelle dépense',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700)),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Catégorie',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final c in CategorieDepense.values)
                                    ChoiceChip(
                                      avatar: Icon(c.icon,
                                          size: 18,
                                          color: _categorie == c
                                              ? Colors.white
                                              : c.color),
                                      label: Text(c.label),
                                      selected: _categorie == c,
                                      selectedColor: c.color,
                                      labelStyle: TextStyle(
                                        color: _categorie == c
                                            ? Colors.white
                                            : null,
                                      ),
                                      onSelected: (_) =>
                                          setState(() => _categorie = c),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GlassCard(
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _date,
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime.now()
                                        .add(const Duration(days: 1)),
                                  );
                                  if (picked != null) {
                                    setState(() => _date = picked);
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.calendar_today_rounded,
                                        color: AppColors.emerald),
                                    const SizedBox(width: 12),
                                    const Text('Date'),
                                    const Spacer(),
                                    Text(Formatters.date(_date),
                                        style: const TextStyle(
                                            fontWeight: FontWeight.w600)),
                                  ],
                                ),
                              ),
                              const Divider(height: 24),
                              TextFormField(
                                controller: _montant,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.,]'))
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Montant',
                                  prefixIcon: Icon(Icons.payments_rounded),
                                ),
                                validator: (v) {
                                  if (v == null || v.trim().isEmpty) {
                                    return 'Requis';
                                  }
                                  if (double.tryParse(
                                          v.replaceAll(',', '.')) ==
                                      null) {
                                    return 'Montant invalide';
                                  }
                                  return null;
                                },
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _description,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  labelText: 'Description (facultatif)',
                                  prefixIcon: Icon(Icons.notes_rounded),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GlassCard(
                          onTap: () async {
                            final path =
                                await ImageStorage.instance.pickAndStore();
                            if (path != null) setState(() => _photo = path);
                          },
                          child: Row(
                            children: [
                              const Icon(Icons.photo_camera_rounded,
                                  color: AppColors.emerald),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Text(_photo == null
                                    ? 'Ajouter une photo (facultatif)'
                                    : 'Photo ajoutée ✓'),
                              ),
                              const Icon(Icons.chevron_right_rounded),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        GradientButton(
                          label: _isEdit ? 'Enregistrer' : 'Ajouter la dépense',
                          icon: Icons.check_rounded,
                          loading: _saving,
                          onPressed: () => _save(vehicule.id),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
