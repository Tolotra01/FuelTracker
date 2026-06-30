import 'dart:io';

import 'package:csv/csv.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../core/utils/formatters.dart';
import '../../data/local/database.dart';
import '../../data/repositories/plein_repository.dart';
import '../statistics/viewmodel/statistics_viewmodel.dart';

/// Service d'export local PDF & CSV (100 % hors-ligne).
class ExportService {
  ExportService._();
  static final ExportService instance = ExportService._();

  pw.ThemeData? _pdfTheme;

  /// Charge une police Unicode embarquée pour le PDF (accents, devises…).
  Future<pw.ThemeData> _loadPdfTheme() async {
    if (_pdfTheme != null) return _pdfTheme!;
    final base = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Regular.ttf'));
    final bold = pw.Font.ttf(await rootBundle.load('assets/fonts/Roboto-Bold.ttf'));
    _pdfTheme = pw.ThemeData.withFont(base: base, bold: bold);
    return _pdfTheme!;
  }

  // ---------------------------------------------------------------------------
  // CSV
  // ---------------------------------------------------------------------------

  Future<File> exportCsv({
    required Vehicule vehicule,
    required List<Plein> pleins,
    required List<Depense> depenses,
    required List<Maintenance> maintenances,
    required String devise,
  }) async {
    String n(num v, {int dec = 2}) => Formatters.number(v, decimals: dec);
    String money(num v) => Formatters.money(v, devise);

    final rows = <List<dynamic>>[];

    // En-tête
    rows.add(['FuelTrack', 'Export des données']);
    rows.add(['Véhicule', '${vehicule.marque} ${vehicule.modele}']);
    rows.add(['Année', vehicule.annee.toString()]);
    rows.add(['Carburant', vehicule.typeCarburant.label]);
    rows.add(['Exporté le', Formatters.dateTime(DateTime.now())]);
    rows.add([]);

    // Pleins (triés par date)
    final pleinsTries = [...pleins]..sort((a, b) => b.date.compareTo(a.date));
    rows.add(['PLEINS (${pleinsTries.length})']);
    rows.add([
      'Date',
      'Odomètre (km)',
      'Volume (L)',
      'Prix/L',
      'Prix total',
      'Type',
      'Station',
      'Notes',
    ]);
    for (final pl in pleinsTries) {
      rows.add([
        Formatters.date(pl.date),
        n(pl.odometre, dec: 0),
        n(pl.volume),
        money(pl.prixUnitaire),
        money(pl.prixTotal),
        pl.typePlein.label,
        pl.station ?? '',
        pl.notes ?? '',
      ]);
    }
    rows.add([]);

    // Dépenses
    final depTries = [...depenses]..sort((a, b) => b.date.compareTo(a.date));
    final totalDep = depTries.fold<double>(0, (s, d) => s + d.montant);
    rows.add(['DÉPENSES (${depTries.length})']);
    rows.add(['Date', 'Catégorie', 'Montant', 'Description']);
    for (final d in depTries) {
      rows.add([
        Formatters.date(d.date),
        d.categorie.label,
        money(d.montant),
        d.description ?? '',
      ]);
    }
    rows.add(['', 'Total', money(totalDep), '']);
    rows.add([]);

    // Maintenances
    rows.add(['ENTRETIEN (${maintenances.length})']);
    rows.add(['Type', 'Statut', 'Date prévue', 'Km prévu', 'Coût', 'Notes']);
    for (final m in maintenances) {
      rows.add([
        m.type.label,
        m.statut.label,
        m.datePrevue != null ? Formatters.date(m.datePrevue!) : '',
        m.kmPrevu != null ? n(m.kmPrevu!, dec: 0) : '',
        m.cout != null ? money(m.cout!) : '',
        m.notes ?? '',
      ]);
    }

    // Csv.excel() : délimiteur ';' + BOM UTF-8 (Excel FR + accents).
    final csv = Csv.excel().encode(rows);
    final dir = await getApplicationDocumentsDirectory();
    final safeName = vehicule.marque.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '');
    final file = File(p.join(dir.path,
        'fueltrack_${safeName}_${DateTime.now().millisecondsSinceEpoch}.csv'));
    await file.writeAsString(csv);
    return file;
  }

  // ---------------------------------------------------------------------------
  // PDF
  // ---------------------------------------------------------------------------

  Future<File> exportPdf({
    required Vehicule vehicule,
    required StatsData stats,
    required List<PleinAvecConso> pleins,
    required String devise,
  }) async {
    final theme = await _loadPdfTheme();
    final doc = pw.Document(theme: theme);
    final dateStr = Formatters.dateLong(DateTime.now());
    const petrol = PdfColor.fromInt(0xFF11414B);
    const grey = PdfColor.fromInt(0xFF6B7780);

    final pleinsTries = [...pleins]
      ..sort((a, b) => b.plein.date.compareTo(a.plein.date));

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => [
          pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            crossAxisAlignment: pw.CrossAxisAlignment.end,
            children: [
              pw.Text('FuelTrack',
                  style: pw.TextStyle(
                      fontSize: 24,
                      fontWeight: pw.FontWeight.bold,
                      color: petrol)),
              pw.Text('Rapport — $dateStr',
                  style: const pw.TextStyle(fontSize: 10, color: grey)),
            ],
          ),
          pw.Divider(color: petrol, thickness: 1.5),
          pw.SizedBox(height: 6),
          pw.Text('${vehicule.marque} ${vehicule.modele} (${vehicule.annee})',
              style: pw.TextStyle(fontSize: 15, fontWeight: pw.FontWeight.bold)),
          pw.Text(vehicule.typeCarburant.label,
              style: const pw.TextStyle(fontSize: 10, color: grey)),
          pw.SizedBox(height: 16),
          pw.Wrap(
            spacing: 10,
            runSpacing: 10,
            children: [
              _kpi('Conso moyenne',
                  stats.moyenneL100km != null
                      ? '${stats.moyenneL100km!.toStringAsFixed(1)} L/100km'
                      : '-'),
              _kpi('Coût total', Formatters.money(stats.coutTotalGlobal, devise)),
              _kpi('Distance',
                  '${Formatters.number(stats.distanceTotale, decimals: 0)} km'),
              _kpi('Coût/km',
                  stats.coutParKm != null
                      ? Formatters.money(stats.coutParKm!, devise)
                      : '-'),
              _kpi('Autonomie est.',
                  stats.autonomieEstimee != null
                      ? '${stats.autonomieEstimee!.toStringAsFixed(0)} km'
                      : '-'),
              _kpi('Nb pleins', '${stats.nbPleins}'),
            ],
          ),
          pw.SizedBox(height: 22),
          pw.Text('Historique des pleins',
              style: pw.TextStyle(fontSize: 13, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headerDecoration: const pw.BoxDecoration(color: petrol),
            headerStyle: pw.TextStyle(
                color: const PdfColor.fromInt(0xFFFFFFFF),
                fontSize: 9,
                fontWeight: pw.FontWeight.bold),
            cellStyle: const pw.TextStyle(fontSize: 9),
            cellAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
            },
            headerAlignments: {
              0: pw.Alignment.centerLeft,
              1: pw.Alignment.centerRight,
              2: pw.Alignment.centerRight,
              3: pw.Alignment.centerRight,
              4: pw.Alignment.centerRight,
            },
            oddRowDecoration:
                const pw.BoxDecoration(color: PdfColor.fromInt(0xFFF2F4F5)),
            headers: ['Date', 'Odomètre', 'Volume', 'Prix total', 'L/100km'],
            data: [
              for (final d in pleinsTries)
                [
                  Formatters.date(d.plein.date),
                  '${Formatters.number(d.plein.odometre, decimals: 0)} km',
                  '${Formatters.number(d.plein.volume)} L',
                  Formatters.money(d.plein.prixTotal, devise),
                  d.consommation != null
                      ? d.consommation!.litresPour100km.toStringAsFixed(1)
                      : '-',
                ],
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Document généré localement par FuelTrack — aucune donnée transmise sur Internet.',
            style: const pw.TextStyle(fontSize: 8, color: grey),
          ),
        ],
      ),
    );

    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path,
        'fueltrack_rapport_${DateTime.now().millisecondsSinceEpoch}.pdf'));
    await file.writeAsBytes(await doc.save());
    return file;
  }

  pw.Widget _kpi(String label, String value) {
    return pw.Container(
      width: 158,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: const PdfColor.fromInt(0xFFE3E7E9)),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label,
              style: const pw.TextStyle(
                  fontSize: 9, color: PdfColor.fromInt(0xFF6B7780))),
          pw.SizedBox(height: 2),
          pw.Text(value,
              style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        ],
      ),
    );
  }

  Future<void> share(File file, String text) async {
    await SharePlus.instance.share(
      ShareParams(files: [XFile(file.path)], text: text),
    );
  }
}
