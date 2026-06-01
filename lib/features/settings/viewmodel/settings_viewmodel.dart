import 'package:drift/drift.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../data/local/database.dart';
import '../../../providers/app_providers.dart';

class SettingsViewModel extends Notifier<void> {
  @override
  void build() {}

  Future<void> update(ReglagesCompanion companion) =>
      ref.read(settingsRepositoryProvider).update(companion);

  Future<void> setNom(String v) => update(ReglagesCompanion(nom: Value(v)));
  Future<void> setDevise(String v) =>
      update(ReglagesCompanion(devise: Value(v)));
  Future<void> setUniteDistance(String v) =>
      update(ReglagesCompanion(uniteDistance: Value(v)));
  Future<void> setUniteVolume(String v) =>
      update(ReglagesCompanion(uniteVolume: Value(v)));
  Future<void> setThemeMode(int v) =>
      update(ReglagesCompanion(themeMode: Value(v)));
  Future<void> setLangue(String v) =>
      update(ReglagesCompanion(langue: Value(v)));
  Future<void> setSeuilAlerte(double v) =>
      update(ReglagesCompanion(seuilAlerte: Value(v)));
  Future<void> setGrandTexte(bool v) =>
      update(ReglagesCompanion(grandTexte: Value(v)));
  Future<void> setContrasteEleve(bool v) =>
      update(ReglagesCompanion(contrasteEleve: Value(v)));
}

final settingsViewModelProvider =
    NotifierProvider<SettingsViewModel, void>(SettingsViewModel.new);
