import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/services/image_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
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
  late final TextEditingController _capacite;
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
    _annee = TextEditingController(
        text: (v?.annee ?? DateTime.now().year).toString());
    _plaque = TextEditingController(text: v?.plaque ?? '');
    _kmInitial =
        TextEditingController(text: (v?.kmInitial ?? 0).toStringAsFixed(0));
    _capacite = TextEditingController(
        text: v?.capaciteReservoir != null
            ? v!.capaciteReservoir!.toStringAsFixed(0)
            : '');
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
    _capacite.dispose();
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
            kmInitial:
                double.tryParse(_kmInitial.text.replaceAll(',', '.')) ?? 0,
            capaciteReservoir: _capacite.text.trim().isEmpty
                ? null
                : double.tryParse(_capacite.text.replaceAll(',', '.')),
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
      appBar: AppBar(
        title: Text(_isEdit ? 'Modifier le véhicule' : 'Nouveau véhicule'),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              GestureDetector(
                onTap: _pickPhoto,
                child: _PhotoPicker(photo: _photo),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  children: [
                    _field(_marque, 'Marque',
                        icon: Icons.directions_car_outlined),
                    const SizedBox(height: 12),
                    _field(_modele, 'Modèle', icon: Icons.badge_outlined),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _field(_annee, 'Année',
                              icon: Icons.event_outlined, number: true),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(_plaque, 'Plaque',
                              icon: Icons.pin_outlined, required: false),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _field(_kmInitial, 'Km initial',
                              icon: Icons.speed_outlined, number: true),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(_capacite, 'Réservoir (L)',
                              icon: Icons.local_gas_station_outlined,
                              number: true,
                              required: false),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
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
                                    ? Colors.white
                                    : AppColors.slate500),
                            label: Text(t.label),
                            labelStyle: TextStyle(
                                color: _typeCarburant == t
                                    ? Colors.white
                                    : null),
                            selected: _typeCarburant == t,
                            onSelected: (_) =>
                                setState(() => _typeCarburant = t),
                          ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    SwitchListTile(
                      contentPadding: EdgeInsets.zero,
                      title: const Text('Véhicule par défaut'),
                      value: _parDefaut,
                      onChanged: (v) => setState(() => _parDefaut = v),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _isEdit ? 'Enregistrer' : 'Ajouter le véhicule',
                icon: Icons.check_rounded,
                loading: _saving,
                onPressed: _save,
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
        prefixIcon: icon != null ? Icon(icon, size: 20) : null,
      ),
      validator: required
          ? (v) => (v == null || v.trim().isEmpty) ? 'Requis' : null
          : null,
    );
  }
}

class _PhotoPicker extends StatelessWidget {
  const _PhotoPicker({this.photo});
  final String? photo;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final has = photo != null && File(photo!).existsSync();
    final secondary =
        isDark ? AppColors.textDarkSecondary : AppColors.slate500;
    return Container(
      height: 140,
      width: double.infinity,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceMutedDark : AppColors.surfaceMuted,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
            color: isDark ? AppColors.lineDark : AppColors.line),
        image: has
            ? DecorationImage(image: FileImage(File(photo!)), fit: BoxFit.cover)
            : null,
      ),
      child: has
          ? null
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.add_a_photo_outlined, color: secondary, size: 28),
                const SizedBox(height: 8),
                Text('Ajouter une photo',
                    style: TextStyle(color: secondary)),
              ],
            ),
    );
  }
}
