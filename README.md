# 🚗 FuelTrack

Application mobile **100% hors-ligne** de suivi de consommation de carburant, de dépenses et de maintenance pour véhicules personnels.

![Flutter](https://img.shields.io/badge/Flutter-3.44-02569B?logo=flutter)
![Dart](https://img.shields.io/badge/Dart-3.12-0175C2?logo=dart)
![Architecture](https://img.shields.io/badge/Architecture-MVVM-00D4A5)
![Offline](https://img.shields.io/badge/100%25-Offline-FF6B35)

---

## ✨ Fonctionnalités

- **Gestion multi-véhicules** — ajout / modification / suppression, véhicule par défaut, photo, type de carburant (Essence, Diesel, GPL, Électrique, Hybride).
- **Journal des pleins** — pleins complets ou partiels, prix total calculé automatiquement (`volume × prix/L`), GPS, photo du reçu, calcul auto de la consommation (L/100km, km/L, coût/km).
- **Suivi des dépenses** — catégories (carburant, maintenance, assurance, péage, parking, réparation, autres) avec photo et description.
- **Maintenance & rappels** — tâches d'entretien avec rappels par date ou kilométrage, statuts Planifié / Effectué / En retard, **notifications locales**.
- **Statistiques & graphiques** — consommation moyenne, coûts mensuels, répartition par catégorie (fl_chart), **détection automatique d'anomalies** (+20 % au-dessus de la moyenne).
- **Export** — rapport **PDF** et **CSV** complet (compatible Excel), partageables.
- **Réglages** — thème clair/sombre/auto (Dark Mode prioritaire), devise, unités (km/mi, L/gal), seuil d'alerte, accessibilité (grand texte, contraste élevé).

---

## 🎨 Design

- **Material 3** + **Dark Mode** prioritaire.
- **Design orienté 3D** : cartes en verre dépoli (glassmorphism), ombres profondes, dégradés, jauge de consommation animée, barre de navigation flottante.
- Palette officielle issue du logo :

| Couleur | HEX | Usage |
|---|---|---|
| Navy Blue | `#0A2540` | Fond principal, navigation |
| Emerald Green | `#00D4A5` | Actions, succès, « Fuel » |
| Energy Orange | `#FF6B35` | Alertes, pleins, coûts, « Track » |

---

## 🏗️ Architecture (MVVM)

Organisation **Feature-First** avec séparation stricte Model / ViewModel / View :

```
lib/
├── main.dart                  # Point d'entrée (init intl, notifications)
├── app.dart                   # MaterialApp.router + thèmes
├── core/                      # Socle technique transverse
│   ├── theme/                 # Couleurs + thèmes Material 3
│   ├── constants/             # Énumérations métier
│   ├── utils/                 # Formatters, calcul de consommation
│   ├── services/              # Notifications, stockage d'images
│   ├── widgets/               # Widgets 3D réutilisables (GlassCard, jauge…)
│   └── router/                # GoRouter
├── data/                      # ── MODEL ──
│   ├── local/                 # Base Drift (SQLite) + tables
│   └── repositories/          # Accès aux données
├── providers/                 # Injection de dépendances (Riverpod)
└── features/                  # Une feature = view/ + viewmodel/
    ├── dashboard/  vehicles/  pleins/  depenses/
    ├── maintenance/  statistics/  settings/  export/
    └── shell/                 # Coquille de navigation (bottom bar)
```

- **View** : écrans et widgets (`ConsumerWidget` / `ConsumerStatefulWidget`).
- **ViewModel** : `Notifier` Riverpod exposant l'état et les actions (ex. `PleinViewModel`, `VehicleViewModel`).
- **Model** : base Drift + repositories.

### Stack technique

| Domaine | Technologie |
|---|---|
| Framework | Flutter 3.44 / Dart 3.12 |
| Base de données locale | **Drift** (SQLite) — 100 % offline |
| State management | **Riverpod 3** (MVVM) |
| Navigation | **GoRouter** |
| Graphiques | **fl_chart** |
| Notifications | **flutter_local_notifications** + timezone |
| GPS | **geolocator** |
| Export | **pdf** / **printing** + **csv** |
| Photos | **image_picker** + système de fichiers de l'app |

> **Aucune dépendance serveur.** Toutes les données restent sur l'appareil.

---

## 🚀 Installation & exécution (Android Studio + émulateur Pixel 9)

### 1. Prérequis

- [Flutter SDK 3.44+](https://docs.flutter.dev/get-started/install) (`flutter --version` doit fonctionner).
- [Android Studio](https://developer.android.com/studio) avec :
  - **Android SDK** (API 34/35),
  - **Plugin Flutter** (et Dart) : *Settings → Plugins → Marketplace → « Flutter » → Install*, puis redémarrer.

### 2. Ouvrir le projet

1. Lancer **Android Studio** → *Open* → sélectionner le dossier `D:\FUEL-TRACKER`.
2. Attendre la fin de l'indexation. Android Studio détecte un projet Flutter.

### 3. Créer / lancer l'émulateur Pixel 9

1. *Tools → Device Manager* (ou l'icône du gestionnaire de périphériques).
2. *Create Device* → catégorie **Phone** → **Pixel 9** → *Next*.
3. Choisir une image système récente (**API 34 ou 35**, x86_64). La télécharger si besoin → *Next* → *Finish*.
4. Démarrer le Pixel 9 avec le bouton ▶ du Device Manager.

### 4. Récupérer les dépendances et générer le code

Dans un terminal (onglet *Terminal* d'Android Studio), à la racine du projet :

```bash
flutter pub get
dart run build_runner build      # génère le code Drift (database.g.dart)
```

> Le fichier généré `lib/data/local/database.g.dart` est nécessaire à la compilation.
> Relancez cette commande après toute modification des tables Drift.

### 5. Lancer l'application

- **Via Android Studio** : sélectionner le périphérique **Pixel 9** dans la barre d'outils, puis cliquer sur ▶ *Run* (`main.dart`).
- **Via le terminal** :

```bash
flutter devices            # vérifier que le Pixel 9 est listé
flutter run                # lance l'app sur l'émulateur sélectionné
```

### 6. (Optionnel) Générer un APK

```bash
flutter build apk --debug          # APK de debug
# Résultat : build/app/outputs/flutter-apk/app-debug.apk
```

---

## 🔐 Permissions Android

Déclarées dans `android/app/src/main/AndroidManifest.xml` :

- `ACCESS_FINE_LOCATION` / `ACCESS_COARSE_LOCATION` — capture GPS facultative d'un plein.
- `POST_NOTIFICATIONS` — rappels de maintenance.
- `CAMERA` — photo de reçu / véhicule.

Ces permissions sont demandées **à l'usage**. Aucune donnée n'est transmise sur Internet.

> ⚙️ `minSdk` est fixé à **23** et le *core library desugaring* est activé
> (`android/app/build.gradle.kts`) car requis par les notifications locales.

---

## 🧪 Tests

```bash
flutter test
```

Inclut un test de la règle métier de détection d'anomalie de consommation.

---

## 📦 Règles métier (cahier des charges)

- La consommation n'est calculée **qu'entre deux pleins complets**.
- `Prix total = volume × prix unitaire` (calcul automatique).
- Alerte si la consommation dépasse de **+20 %** la moyenne (seuil configurable).

---

## 🛠️ Dépannage

**L'app « se coupe » / `Lost connection to device` au lancement** : sur certains
émulateurs récents/expérimentaux (ex. image **API 37 / pages 16 Ko**, `gphone16k`),
le moteur de rendu **Impeller** provoque une déconnexion de la session de débogage
au démarrage. Impeller est donc **désactivé** au profit de **Skia** via
`android/app/src/main/AndroidManifest.xml` :

```xml
<meta-data android:name="io.flutter.embedding.android.EnableImpeller" android:value="false" />
```

> Le premier affichage avec Skia peut être un peu plus lent (compilation de shaders),
> puis les lancements suivants sont rapides.

**Pour une stabilité maximale**, utilise un AVD **Pixel 9 sur une image système
stable** (API 35, *Google APIs*, x86_64) plutôt qu'une image preview :
*Device Manager → Create Device → Pixel 9 → choisir API 35*.



 📂 Données

La base SQLite (`fueltrack`) et les photos sont stockées dans le dossier privé de
l'application. Un export `.csv` / `.pdf` permet de sauvegarder ou partager les données.



FuelTrack — généré par Tolotra Nomenjanahary.
