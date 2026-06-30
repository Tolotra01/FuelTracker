import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:geolocator/geolocator.dart';
import 'package:go_router/go_router.dart';

import '../../../core/constants/enums.dart';
import '../../../core/services/image_storage.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/utils/formatters.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_card.dart';
import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';
import '../viewmodel/plein_viewmodel.dart';

class PleinFormScreen extends ConsumerStatefulWidget {
  const PleinFormScreen({super.key, this.plein});
  final Plein? plein;

  @override
  ConsumerState<PleinFormScreen> createState() => _PleinFormScreenState();
}

class _PleinFormScreenState extends ConsumerState<PleinFormScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _odometre;
  late final TextEditingController _volume;
  late final TextEditingController _prixUnitaire;
  late final TextEditingController _station;
  late final TextEditingController _notes;
  late DateTime _date;
  late TypePlein _typePlein;
  double? _lat;
  double? _lng;
  String? _photo;
  bool _saving = false;
  bool _gpsLoading = false;
  bool _prefilled = false;

  bool get _isEdit => widget.plein != null;

  @override
  void initState() {
    super.initState();
    final p = widget.plein;
    _odometre = TextEditingController(
        text: p != null ? p.odometre.toStringAsFixed(0) : '');
    _volume = TextEditingController(
        text: p != null ? p.volume.toStringAsFixed(2) : '');
    _prixUnitaire = TextEditingController(
        text: p != null ? p.prixUnitaire.toStringAsFixed(3) : '');
    _station = TextEditingController(text: p?.station ?? '');
    _notes = TextEditingController(text: p?.notes ?? '');
    _date = p?.date ?? DateTime.now();
    _typePlein = p?.typePlein ?? TypePlein.complet;
    _lat = p?.latitude;
    _lng = p?.longitude;
    _photo = p?.photo;
    _volume.addListener(_recalc);
    _prixUnitaire.addListener(_recalc);
  }

  @override
  void dispose() {
    _odometre.dispose();
    _volume.dispose();
    _prixUnitaire.dispose();
    _station.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _recalc() => setState(() {});

  double get _total {
    final v = double.tryParse(_volume.text.replaceAll(',', '.')) ?? 0;
    final pu = double.tryParse(_prixUnitaire.text.replaceAll(',', '.')) ?? 0;
    return v * pu;
  }

  Future<void> _pickPhoto() async {
    final path = await ImageStorage.instance.pickAndStore();
    if (path != null) setState(() => _photo = path);
  }

  Future<void> _captureGps() async {
    setState(() => _gpsLoading = true);
    try {
      var permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
      }
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Permission de localisation refusée')));
        }
        return;
      }
      final pos = await Geolocator.getCurrentPosition();
      setState(() {
        _lat = pos.latitude;
        _lng = pos.longitude;
      });
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text('Impossible de récupérer la position')));
      }
    } finally {
      if (mounted) setState(() => _gpsLoading = false);
    }
  }

  Future<void> _pickDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _date,
      firstDate: DateTime(2000),
      lastDate: DateTime.now().add(const Duration(days: 1)),
    );
    if (picked != null) setState(() => _date = picked);
  }

  Future<void> _save(String vehiculeId) async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    try {
      await ref.read(pleinViewModelProvider.notifier).save(
            id: widget.plein?.id,
            vehiculeId: vehiculeId,
            date: _date,
            odometre: double.parse(_odometre.text.replaceAll(',', '.')),
            volume: double.parse(_volume.text.replaceAll(',', '.')),
            prixUnitaire:
                double.parse(_prixUnitaire.text.replaceAll(',', '.')),
            typePlein: _typePlein,
            station:
                _station.text.trim().isEmpty ? null : _station.text.trim(),
            latitude: _lat,
            longitude: _lng,
            notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
            photo: _photo,
          );
      if (mounted) context.pop();
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final vehicule = ref.watch(activeVehicleProvider);
    final devise = ref.watch(settingsStreamProvider).value?.devise ?? '€';

    if (!_isEdit && !_prefilled) {
      final dernier = ref.watch(dernierPleinProvider).value;
      if (dernier != null && _odometre.text.isEmpty) {
        _odometre.text = dernier.odometre.toStringAsFixed(0);
        if (_prixUnitaire.text.isEmpty) {
          _prixUnitaire.text = dernier.prixUnitaire.toStringAsFixed(3);
        }
        _prefilled = true;
      }
    }

    if (vehicule == null) {
      return Scaffold(
        appBar: AppBar(),
        body: const Center(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Text("Ajoutez d'abord un véhicule pour enregistrer un plein.",
                textAlign: TextAlign.center),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(_isEdit ? 'Modifier le plein' : 'Nouveau plein'),
        leading: IconButton(
            onPressed: () => context.pop(),
            icon: const Icon(Icons.close_rounded)),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 32),
            children: [
              // Prix total — mis en avant (hiérarchie forte), sobre.
              AppCard(
                color: AppColors.petrol,
                child: Column(
                  children: [
                    Text('Prix total (calcul automatique)',
                        style: theme.textTheme.bodySmall
                            ?.copyWith(color: Colors.white70)),
                    const SizedBox(height: 4),
                    Text(
                      Formatters.money(_total, devise),
                      style: theme.textTheme.displaySmall?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: -1,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                child: Column(
                  children: [
                    _DateTile(date: _date, onTap: _pickDate),
                    const Divider(height: 24),
                    _field(_odometre, 'Odomètre (km)',
                        icon: Icons.speed_outlined, number: true),
                    const SizedBox(height: 12),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: _field(_volume, 'Volume (L)',
                              icon: Icons.water_drop_outlined, number: true),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _field(_prixUnitaire, 'Prix/L',
                              icon: Icons.sell_outlined, number: true),
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
                    SegmentedButton<TypePlein>(
                      segments: const [
                        ButtonSegment(
                            value: TypePlein.complet,
                            label: Text('Complet'),
                            icon: Icon(Icons.battery_full_rounded, size: 18)),
                        ButtonSegment(
                            value: TypePlein.partiel,
                            label: Text('Partiel'),
                            icon: Icon(Icons.battery_3_bar_rounded, size: 18)),
                      ],
                      selected: {_typePlein},
                      onSelectionChanged: (s) =>
                          setState(() => _typePlein = s.first),
                    ),
                    const SizedBox(height: 14),
                    _field(_station, 'Station',
                        icon: Icons.place_outlined, required: false),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            _lat != null
                                ? 'GPS : ${_lat!.toStringAsFixed(4)}, ${_lng!.toStringAsFixed(4)}'
                                : 'Aucune position',
                            style: theme.textTheme.bodySmall,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: _gpsLoading ? null : _captureGps,
                          icon: _gpsLoading
                              ? const SizedBox(
                                  width: 16,
                                  height: 16,
                                  child:
                                      CircularProgressIndicator(strokeWidth: 2))
                              : const Icon(Icons.my_location_outlined, size: 18),
                          label: const Text('GPS'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    _field(_notes, 'Notes',
                        icon: Icons.notes_outlined,
                        required: false,
                        lines: 2),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              AppCard(
                onTap: _pickPhoto,
                child: Row(
                  children: [
                    const Icon(Icons.receipt_long_outlined,
                        color: AppColors.petrol),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(_photo == null
                          ? 'Ajouter la photo du reçu'
                          : 'Photo du reçu ajoutée'),
                    ),
                    const Icon(Icons.chevron_right_rounded,
                        color: AppColors.slate400),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              PrimaryButton(
                label: _isEdit ? 'Enregistrer' : 'Ajouter le plein',
                icon: Icons.check_rounded,
                loading: _saving,
                onPressed: () => _save(vehicule.id),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController c,
    String label, {
    IconData? icon,
    bool number = false,
    bool required = true,
    int lines = 1,
  }) {
    return TextFormField(
      controller: c,
      maxLines: lines,
      keyboardType: number
          ? const TextInputType.numberWithOptions(decimal: true)
          : TextInputType.text,
      inputFormatters: number
          ? [FilteringTextInputFormatter.allow(RegExp(r'[0-9.,]'))]
          : null,
      decoration: InputDecoration(
          labelText: label,
          prefixIcon: icon != null ? Icon(icon, size: 20) : null),
      validator: required
          ? (v) {
              if (v == null || v.trim().isEmpty) return 'Requis';
              if (number && double.tryParse(v.replaceAll(',', '.')) == null) {
                return 'Nombre invalide';
              }
              return null;
            }
          : null,
    );
  }
}

class _DateTile extends StatelessWidget {
  const _DateTile({required this.date, required this.onTap});
  final DateTime date;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Row(
        children: [
          const Icon(Icons.event_outlined, color: AppColors.petrol, size: 20),
          const SizedBox(width: 12),
          const Text('Date'),
          const Spacer(),
          Text(Formatters.date(date),
              style: const TextStyle(fontWeight: FontWeight.w600)),
          const Icon(Icons.chevron_right_rounded, color: AppColors.slate400),
        ],
      ),
    );
  }
}
