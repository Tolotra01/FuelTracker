import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/services/image_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_background.dart';
import '../../../core/widgets/glass_card.dart';
import '../../../core/widgets/gradient_button.dart';
import '../../../data/local/database.dart';
import '../viewmodel/vehicle_viewmodel.dart';

class VehicleFormScreen extends ConsumerStatefulWidget {
  const VehicleFormScreen({super.key, this.vehicule});
  final Vehicule? vehicule;

  @override
  ConsumerState<VehicleFormScreen> createState() => _VehicleFormScreenState();
}

class _VehicleFormScreenState extends ConsumerState<VehicleFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _marque;
  late final TextEditingController _modele;
  late final TextEditingController _annee;
  late final TextEditingController _plaque;
  late final TextEditingController _kmInitial;
  late TypeCarburant _typeCarburant;
  late bool _parDefaut;
  String? _photo;
  bool _saving = false;

  bool get _isEdit => widget.vehicule != null;

  @override
  void initState() {
    super.initState();
    final v = widget.vehicule;
    _marque = TextEditingController(text: v?.marque ?? '');
    _modele = TextEditingController(text: v?.modele ?? '');
    _annee =
        TextEditingController(text: (v?.annee ?? DateTime.now().year).toString());
    _plaque = TextEditingController(text: v?.plaque ?? '');
    _kmInitial =
        TextEditingController(text: (v?.kmInitial ?? 0).toStringAsFixed(0));
    _typeCarburant = v?.typeCarburant ?? TypeCarburant.essence;
    _parDefaut = v?.parDefaut ?? false;
    _photo = v?.photo;
  }

  @override
  void dispose() {
    _marque.dispose();
    _modele.dispose();
    _annee.dispose();
    _plaque.dispose();
    _kmInitial.dispose();
    super.dispose();
  }

  Future<void> _pickPhoto() async {
    final path = await ImageStorage.instance.pickAndStore();
    if (path != null) setState(() => _photo = path);
  }

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(vehicleViewModelProvider.notifier).save(
            id: widget.vehicule?.id,
            marque: _marque.text.trim(),
            modele: _modele.text.trim(),
            annee: int.tryParse(_annee.text) ?? DateTime.now().year,
            plaque: _plaque.text.trim().isEmpty ? null : _plaque.text.trim(),
            typeCarburant: _typeCarburant,
            kmInitial: double.tryParse(_kmInitial.text.replaceAll(',', '.')) ?? 0,
            photo: _photo,
            parDefaut: _parDefaut,
          );
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppBackground(
        child: SafeArea(
          child: Column(
            children: [
              _FormHeader(title: _isEdit ? 'Modifier le véhicule' : 'Nouveau véhicule'),
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        GestureDetector(
                          onTap: _pickPhoto,
                          child: _PhotoPicker(photo: _photo),
                        ),
                        const SizedBox(height: 20),
                        GlassCard(
                          child: Column(
                            children: [
                              _field(_marque, 'Marque',
                                  icon: Icons.directions_car_rounded),
                              const SizedBox(height: 14),
                              _field(_modele, 'Modèle',
                                  icon: Icons.badge_rounded),
                              const SizedBox(height: 14),
                              Row(
                                children: [
                                  Expanded(
                                    child: _field(_annee, 'Année',
                                        icon: Icons.calendar_today_rounded,
                                        number: true),
                                  ),
                                  const SizedBox(width: 12),
                                  Expanded(
                                    child: _field(_plaque, 'Plaque',
                                        icon: Icons.pin_rounded,
                                        required: false),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 14),
                              _field(_kmInitial, 'Kilométrage initial',
                                  icon: Icons.speed_rounded, number: true),
                            ],
                          ),
                        ),
                        const SizedBox(height: 16),
                        GlassCard(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Type de carburant',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontWeight: FontWeight.w600)),
                              const SizedBox(height: 12),
                              Wrap(
                                spacing: 8,
                                runSpacing: 8,
                                children: [
                                  for (final t in TypeCarburant.values)
                                    ChoiceChip(
                                      avatar: Icon(t.icon,
                                          size: 18,
                                          color: _typeCarburant == t
                                              ? AppColors.navyDeep
                                              : null),
                                      label: Text(t.label),
                                      selected: _typeCarburant == t,
                                      selectedColor: AppColors.emerald,
                                      onSelected: (_) =>
                                          setState(() => _typeCarburant = t),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              SwitchListTile(
                                contentPadding: EdgeInsets.zero,
                                title: const Text('Véhicule par défaut'),
                                value: _parDefaut,
                                activeThumbColor: AppColors.emerald,
                                onChanged: (v) =>
                                    setState(() => _parDefaut = v),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        GradientButton(
                          label: _isEdit ? 'Enregistrer' : 'Ajouter le véhicule',
                          icon: Icons.check_rounded,
                          loading: _saving,
                          onPressed: _save,
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

  Widget _field(
    TextEditingController controller,
    String label, {
    IconData? icon,
    bool number = false,
    bool required = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: number
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))]
          : null,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: icon != null ? Icon(icon) : null,
      ),
      validator: required
          ? (v) => (v == null || v.trim().isEmpty) ? 'Champ requis' : null
          : null,
    );
  }
}

class _FormHeader extends StatelessWidget {
  const _FormHeader({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
      child: Row(
        children: [
          IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(Icons.close_rounded)),
          Expanded(
            child: Text(title,
                style: Theme.of(context)
                    .textTheme
                    .titleLarge
                    ?.copyWith(fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({this.photo});
  final String? photo;

  @override
  Widget build(BuildContext context) {
    final has = photo != null && File(photo!).existsSync();
    return Container(
      height: 150,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: AppColors.navyGradient,
        image: has
            ? DecorationImage(image: FileImage(File(photo!)), fit: BoxFit.cover)
            : null,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.3),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: has
          ? null
          : const Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_rounded,
                    color: AppColors.emerald, size: 36),
                SizedBox(height: 8),
                Text('Ajouter une photo',
                    style: TextStyle(color: Colors.white70)),
              ],
            ),
    );
  }
}
