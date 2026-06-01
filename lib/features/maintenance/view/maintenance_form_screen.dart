import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/maintenance_viewmodel.dart';

class MaintenanceFormScreen extends ConsumerStatefulWidget {
  const MaintenanceFormScreen({super.key, this.maintenance});
  final Maintenance? maintenance;

  @override
  ConsumerState<MaintenanceFormScreen> createState() =>
      _MaintenanceFormScreenState();
}

class _MaintenanceFormScreenState
    extends ConsumerState<MaintenanceFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _km;
  late final TextEditingController _cout;
  late final TextEditingController _notes;
  late TypeMaintenance _type;
  DateTime? _datePrevue;
  bool _saving = false;

  bool get _isEdit => widget.maintenance != null;

  @override
  void initState() {
    super.initState();
    final m = widget.maintenance;
    _km = TextEditingController(
        text: m?.kmPrevu != null ? m!.kmPrevu!.toStringAsFixed(0) : '');
    _cout = TextEditingController(
        text: m?.cout != null ? m!.cout!.toStringAsFixed(2) : '');
    _notes = TextEditingController(text: m?.notes ?? '');
    _type = m?.type ?? TypeMaintenance.vidange;
    _datePrevue = m?.datePrevue;
  }

  @override
  void dispose() {
    _km.dispose();
    _cout.dispose();
    _notes.dispose();
    super.dispose();
  }

  Future<void> _save(String vehiculeId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(maintenanceViewModelProvider.notifier).save(
            id: widget.maintenance?.id,
            vehiculeId: vehiculeId,
            type: _type,
            kmPrevu: _km.text.trim().isEmpty
                ? null
                : double.tryParse(_km.text.replaceAll(',', '.')),
            datePrevue: _datePrevue,
            statut: widget.maintenance?.statut ?? StatutMaintenance.planifie,
            notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
            cout: _cout.text.trim().isEmpty
                ? null
                : double.tryParse(_cout.text.replaceAll(',', '.')),
            dateEffectue: widget.maintenance?.dateEffectue,
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
          body: Center(child: Text('Ajoutez un véhicule au préalable.')));
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
                    Text(_isEdit ? 'Modifier l\'entretien' : 'Nouvel entretien',
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
                              Text('Type de maintenance',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final t in TypeMaintenance.values)
                                    ChoiceChip(
                                      avatar: Icon(t.icon,
                                          size: 18,
                                          color: _type == t
                                              ? AppColors.navyDeep
                                              : null),
                                      label: Text(t.label),
                                      selected: _type == t,
                                      selectedColor: AppColors.emerald,
                                      onSelected: (_) =>
                                          setState(() => _type = t),
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
                              Text(
                                'Définissez un rappel par date et/ou kilométrage',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                              const SizedBox(height: 12),
                              InkWell(
                                onTap: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate:
                                        _datePrevue ?? DateTime.now(),
                                    firstDate: DateTime(2000),
                                    lastDate: DateTime(2100),
                                  );
                                  if (picked != null) {
                                    setState(() => _datePrevue = picked);
                                  }
                                },
                                child: Row(
                                  children: [
                                    const Icon(Icons.event_rounded,
                                        color: AppColors.emerald),
                                    const SizedBox(width: 12),
                                    const Text('Date prévue'),
                                    const Spacer(),
                                    Text(
                                      _datePrevue != null
                                          ? Formatters.date(_datePrevue!)
                                          : 'Choisir',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.w600),
                                    ),
                                    if (_datePrevue != null)
                                      IconButton(
                                        icon: const Icon(Icons.clear_rounded,
                                            size: 18),
                                        onPressed: () =>
                                            setState(() => _datePrevue = null),
                                      ),
                                  ],
                                ),
                              ),
                              const Divider(height: 24),
                              TextFormField(
                                controller: _km,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.,]'))
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Kilométrage prévu (facultatif)',
                                  prefixIcon: Icon(Icons.speed_rounded),
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _cout,
                                keyboardType:
                                    const TextInputType.numberWithOptions(
                                        decimal: true),
                                inputFormatters: [
                                  FilteringTextInputFormatter.allow(
                                      RegExp(r'[0-9.,]'))
                                ],
                                decoration: const InputDecoration(
                                  labelText: 'Coût estimé (facultatif)',
                                  prefixIcon: Icon(Icons.payments_rounded),
                                ),
                              ),
                              const SizedBox(height: 14),
                              TextFormField(
                                controller: _notes,
                                maxLines: 2,
                                decoration: const InputDecoration(
                                  labelText: 'Notes (facultatif)',
                                  prefixIcon: Icon(Icons.notes_rounded),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        GradientButton(
                          label: _isEdit ? 'Enregistrer' : 'Planifier',
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
