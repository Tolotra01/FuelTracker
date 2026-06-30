import 'package:intl/intl.dart';

/// Helpers de formatage (dates, montants, unités).
class Formatters {
  Formatters._();

  static final DateFormat _date = DateFormat('dd/MM/yyyy', 'fr_FR');
  static final DateFormat _dateLong = DateFormat('dd MMM yyyy', 'fr_FR');
  static final DateFormat _dateTime = DateFormat('dd/MM/yyyy HH:mm', 'fr_FR');
  static final DateFormat _month = DateFormat('MMM yyyy', 'fr_FR');
  static final DateFormat _monthShort = DateFormat('MMM', 'fr_FR');

  static String date(DateTime d) => _date.format(d);
  static String dateLong(DateTime d) => _dateLong.format(d);
  static String dateTime(DateTime d) => _dateTime.format(d);
  static String month(DateTime d) => _month.format(d);
  static String monthShort(DateTime d) => _monthShort.format(d);

  static String money(num value, String devise) {
    // L'Ariary (Ar) ne s'écrit pas avec de décimales et se place après le montant.
    final sansDecimales = devise == 'Ar' || devise == 'FCFA';
    final f = NumberFormat.currency(
      locale: 'fr_FR',
      symbol: '', // on place le symbole nous-mêmes
      decimalDigits: sansDecimales ? 0 : 2,
    );
    final montant = f.format(value).trim();
    return '$montant $devise';
  }

  /// Format compact pour les axes de graphiques (1 200 → 1,2k).
  static String compact(num value) {
    final v = value.abs();
    if (v >= 1000000) return '${(value / 1000000).toStringAsFixed(1)}M';
    if (v >= 1000) return '${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k';
    return value.toStringAsFixed(0);
  }

  static String number(num value, {int decimals = 1}) {
    final f = NumberFormat.decimalPatternDigits(
      locale: 'fr_FR',
      decimalDigits: decimals,
    );
    return f.format(value);
  }

  static String distance(num value, String unite) =>
      '${number(value, decimals: 0)} $unite';

  static String volume(num value, String unite) =>
      '${number(value, decimals: 2)} $unite';

  /// Différence relative en jours par rapport à aujourd'hui (lisible).
  static String relativeDate(DateTime d) {
    final now = DateTime.now();
    final diff = DateTime(d.year, d.month, d.day)
        .difference(DateTime(now.year, now.month, now.day))
        .inDays;
    if (diff == 0) return "Aujourd'hui";
    if (diff == 1) return 'Demain';
    if (diff == -1) return 'Hier';
    if (diff > 0) return 'Dans $diff jours';
    return 'Il y a ${-diff} jours';
  }
}
