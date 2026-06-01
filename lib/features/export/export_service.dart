import 'dart:io';

import 'package:csv/csv.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:share_plus/share_plus.dart';

import '../../core/utils/formatters.dart';
import '../../data/local/database.dart';
import '../../data/repositories/plein_repository.dart';
import '../statistics/viewmodel/statistics_viewmodel.dart';

/// Service d'export local PDF & CSV (cahier des charges §4.1.6).
class ExportService {
  ExportService._();
  static final ExportService instance = ExportService._();

  Future<File> exportCsv({
    required Vehicule vehicule,
    required List<Plein> pleins,
    required List<Depense> depenses,
    required List<Maintenance> maintenances,
  }) async {
    final rows = <List<dynamic>>[];
    rows.add(['FuelTrack — Export complet']);
    rows.add(['Véhicule', '${vehicule.marque} ${vehicule.modele}', vehicule.annee]);
    rows.add([]);

    rows.add(['PLEINS']);
    rows.add([
      'Date', 'Odomètre', 'Volume (L)', 'Prix/L', 'Prix total',
      'Type', 'Station', 'Latitude', 'Longitude', 'Notes'
    ]);
    for (final pl in pleins) {
      rows.add([
        Formatters.date(pl.date),
        pl.odometre,
        pl.volume,
        pl.prixUnitaire,
        pl.prixTotal,
        pl.typePlein.label,
        pl.station ?? '',
        pl.latitude ?? '',
        pl.longitude ?? '',
        pl.notes ?? '',
      ]);
    }

    rows.add([]);
    rows.add(['DEPENSES']);
    rows.add(['Date', 'Catégorie', 'Montant', 'Description']);
    for (final d in depenses) {
      rows.add([
        Formatters.date(d.date),
        d.categorie.label,
        d.montant,
        d.description ?? '',
      ]);
    }

    rows.add([]);
    rows.add(['MAINTENANCES']);
    rows.add(['Type', 'Statut', 'Date prévue', 'Km prévu', 'Coût', 'Notes']);
    for (final m in maintenances) {
      rows.add([
        m.type.label,
        m.statut.label,
        m.datePrevue != null ? Formatters.date(m.datePrevue!) : '',
        m.kmPrevu ?? '',
        m.cout ?? '',
        m.notes ?? '',
      ]);
    }

    // Csv.excel() : délimiteur ';' + BOM UTF-8 (compatible Excel/accents).
    final csv = Csv.excel().encode(rows);
    final dir = await getApplicationDocumentsDirectory();
    final file = File(p.join(dir.path,
        'fueltrack_${vehicule.marque}_${DateTime.now().millisecondsSinceEpoch}.csv'));
    await file.writeAsString(csv);
    return file;
  }

  Future<File> exportPdf({
    required Vehicule vehicule,
    required StatsData stats,
    required List<PleinAvecConso> pleins,
    required String devise,
  }) async {
    final doc = pw.Document();
    final dateStr = Formatters.dateLong(DateTime.now());

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: const pw.EdgeInsets.all(28),
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Row(
              mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
              children: [
                pw.Text('FuelTrack — Rapport',
                    style: pw.TextStyle(
                        fontSize: 22, fontWeight: pw.FontWeight.bold)),
                pw.Text(dateStr),
              ],
            ),
          ),
          pw.Text('${vehicule.marque} ${vehicule.modele} (${vehicule.annee})',
              style: pw.TextStyle(
                  fontSize: 16, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 12),
          pw.Wrap(
            spacing: 16,
            runSpacing: 8,
            children: [
              _kpi('Conso moyenne',
                  stats.moyenneL100km != null
                      ? '${stats.moyenneL100km!.toStringAsFixed(1)} L/100km'
                      : '—'),
              _kpi('Coût total',
                  Formatters.money(stats.coutTotalGlobal, devise)),
              _kpi('Distance', '${stats.distanceTotale.toStringAsFixed(0)} km'),
              _kpi('Coût/km',
                  stats.coutParKm != null
                      ? Formatters.money(stats.coutParKm!, devise)
                      : '—'),
              _kpi('Nb pleins', '${stats.nbPleins}'),
              _kpi('Anomalies', '${stats.anomalies}'),
            ],
          ),
          pw.SizedBox(height: 20),
          pw.Text('Historique des pleins',
              style: pw.TextStyle(
                  fontSize: 14, fontWeight: pw.FontWeight.bold)),
          pw.SizedBox(height: 8),
          pw.TableHelper.fromTextArray(
            headerDecoration:
                const pw.BoxDecoration(color: PdfColor.fromInt(0xFF0A2540)),
            headerStyle: const pw.TextStyle(
                color: PdfColor.fromInt(0xFFFFFFFF), fontSize: 9),
            cellStyle: const pw.TextStyle(fontSize: 9),
            headers: ['Date', 'Odomètre', 'Volume', 'Prix total', 'L/100km'],
            data: [
              for (final d in pleins)
                [
                  Formatters.date(d.plein.date),
                  '${d.plein.odometre.toStringAsFixed(0)} km',
                  '${d.plein.volume.toStringAsFixed(2)} L',
                  Formatters.money(d.plein.prixTotal, devise),
                  d.consommation != null
                      ? d.consommation!.litresPour100km.toStringAsFixed(1)
                      : '—',
                ],
            ],
          ),
          pw.SizedBox(height: 16),
          pw.Text(
            'Document généré localement par FuelTrack — aucune donnée transmise sur Internet.',
            style: const pw.TextStyle(
                fontSize: 8, color: PdfColor.fromInt(0xFF888888)),
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
      width: 150,
      padding: const pw.EdgeInsets.all(8),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(color: const PdfColor.fromInt(0xFFCCCCCC)),
        borderRadius: pw.BorderRadius.circular(6),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text(label, style: const pw.TextStyle(fontSize: 9)),
          pw.Text(value,
              style: pw.TextStyle(
                  fontSize: 14, fontWeight: pw.FontWeight.bold)),
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
