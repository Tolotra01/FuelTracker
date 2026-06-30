# 📖 Guide d'utilisation — FuelTrack

Ce guide explique **page par page** et **champ par champ** comment fonctionne
l'application FuelTrack : à quoi sert chaque écran, ce que fait chaque champ,
ce qui se passe après la saisie, et les calculs effectués. Un **exemple réel
chiffré** est déroulé du début à la fin, et un **résumé** clôt le document.

> 🎯 **À quoi sert l'app ?** FuelTrack permet à un automobiliste de **suivre sa
> consommation de carburant, ses dépenses et l'entretien de son/ses véhicule(s)**,
> entièrement **hors-ligne**. Elle calcule automatiquement la consommation
> (L/100 km), le coût au kilomètre, détecte les consommations anormales, et
> génère des statistiques et des rapports exportables.

---

## 🧭 Navigation générale

L'app a une **barre de navigation flottante** en bas avec **5 onglets** :

| Onglet | Icône | Rôle |
|---|---|---|
| **Accueil** | 🏠 | Tableau de bord : résumé, jauge de conso, actions rapides |
| **Pleins** | ⛽ | Journal de tous les pleins de carburant |
| **Stats** | 📊 | Graphiques et statistiques |
| **Entretien** | 🔧 | Maintenances planifiées et rappels |
| **Réglages** | ⚙️ | Paramètres, véhicules, dépenses, export |

Un bouton flottant **+** (orange) apparaît sur **Accueil** et **Pleins** pour
ajouter rapidement un plein.

> ⚠️ **Première chose à faire :** tant qu'aucun véhicule n'existe, la plupart des
> écrans affichent « Ajoutez un véhicule ». **Il faut créer un véhicule d'abord.**

---

## 1. 🚗 Gestion des véhicules

### Où ?
Accueil → sélecteur de véhicule (en haut à droite) → **Gérer les véhicules**,
ou Réglages → **Mes véhicules**.

### Liste des véhicules
Chaque carte montre : marque + modèle, badge **« Défaut »** si c'est le véhicule
principal, type de carburant, année, et **kilométrage au compteur**.
Menu **⋮** : *Définir par défaut*, *Modifier*, *Supprimer*.

### Formulaire « Nouveau véhicule » — champs

| Champ | Obligatoire | Rôle / Ce qui se passe |
|---|---|---|
| **Photo** | Non | Photo du véhicule (galerie). Stockée localement. |
| **Marque** | ✅ Oui | Ex. *Peugeot*. Identifie le véhicule. |
| **Modèle** | ✅ Oui | Ex. *208*. |
| **Année** | ✅ Oui | Année de mise en circulation. |
| **Plaque** | Non | Immatriculation (informatif). |
| **Kilométrage initial** | ✅ Oui | Compteur de départ. Sert de **base** au km actuel. |
| **Type de carburant** | ✅ Oui | Essence, Diesel, GPL, **Électrique**, Hybride. |
| **Véhicule par défaut** | interrupteur | Définit le véhicule actif au démarrage. |

### Ce qui se passe après enregistrement
- Le **premier véhicule créé devient automatiquement le véhicule par défaut**.
- Le véhicule devient le **véhicule actif** (toutes les autres pages parlent de lui).
- **Kilométrage au compteur** = `max(kilométrage initial, plus grand odomètre saisi dans les pleins)`. Tant qu'il n'y a pas de plein, c'est le km initial.

> 💡 On peut gérer **plusieurs véhicules** et basculer entre eux via le sélecteur
> en haut du tableau de bord. Toutes les données (pleins, dépenses, entretien,
> stats) sont **propres à chaque véhicule**.

---

## 2. ⛽ Journal des pleins

### Où ?
Onglet **Pleins**, ou bouton **+** flottant, ou Accueil → bouton **Plein**.

### Liste des pleins
Chaque carte affiche : date, volume, station, **prix total**, prix/L, odomètre,
type de plein, et un **badge vert de consommation** (ex. `6.3 L/100`) si elle a
pu être calculée (voir règle plus bas). Un tiret `—` signifie « non calculable »
(premier plein, ou plein partiel).

### Formulaire « Nouveau plein » — champs

| Champ | Obligatoire | Rôle / Ce qui se passe |
|---|---|---|
| **Prix total** | (auto) | **Calculé automatiquement** = `Volume × Prix/L`. Affiché en grand, en temps réel. |
| **Date** | ✅ | Date du plein (sélecteur). |
| **Odomètre (km)** | ✅ | Kilométrage au moment du plein. **Pré-rempli** avec l'odomètre du dernier plein. |
| **Volume (L)** | ✅ | Litres mis dans le réservoir. |
| **Prix/L** | ✅ | Prix unitaire du carburant. **Pré-rempli** avec le dernier prix utilisé. |
| **Type** | ✅ | **Complet** ou **Partiel** (voir règle de calcul). |
| **Station** | Non | Nom de la station (ex. *Total Antananarivo*). |
| **GPS** | Non | Bouton *Capturer GPS* → enregistre latitude/longitude actuelles. |
| **Notes** | Non | Remarque libre. |
| **Photo du reçu** | Non | Photo du ticket, stockée localement. |

### Calcul automatique au moment de la saisie
- Dès que tu remplis **Volume** et **Prix/L**, le **Prix total se met à jour en direct**.
  Exemple : `40 L × 1,80 €/L` → **72,00 €**.

### Calcul de la consommation (après enregistrement)
La consommation d'un plein est calculée **par rapport au plein complet précédent** :

```
distance   = odomètre du plein − odomètre du plein complet précédent
L/100 km   = (Volume × 100) ÷ distance
km/L       = distance ÷ Volume
coût/km    = Prix total ÷ distance
```

> 📏 **Règle métier importante :** la consommation n'est calculée **qu'entre deux
> pleins COMPLETS**. Un **plein partiel** n'a pas de badge de conso (le réservoir
> n'étant pas rempli, le volume ne reflète pas la distance parcourue). Le premier
> plein n'a jamais de conso (pas de référence avant lui).

---

## 3. 💸 Suivi des dépenses

### Où ?
Réglages → **Dépenses**, ou Accueil → bouton **Dépense**.

### Liste des dépenses
- Une carte **« Total des dépenses »** en haut (somme de toutes les dépenses du véhicule).
- Chaque dépense : icône colorée par catégorie, catégorie, date, description, montant.
- **Glisser vers la gauche** sur une carte = **supprimer**.

### Formulaire « Nouvelle dépense » — champs

| Champ | Obligatoire | Rôle |
|---|---|---|
| **Catégorie** | ✅ | Carburant, Maintenance, Assurance, Péage, Parking, Réparation, Autres. Chaque catégorie a sa couleur. |
| **Date** | ✅ | Date de la dépense. |
| **Montant** | ✅ | Coût (dans la devise choisie). |
| **Description** | Non | Détail (ex. *Assurance annuelle*). |
| **Photo** | Non | Justificatif/facture. |

### Ce qui se passe après
- La dépense s'ajoute au **total** et alimente le **graphique de répartition** des
  Statistiques (camembert), ainsi que le **coût total** du tableau de bord.

---

## 4. 🔧 Entretien & rappels

### Où ?
Onglet **Entretien**, bouton **+ Entretien**.

### Liste des maintenances
Chaque carte montre : type (vidange…), notes, **badge de statut** coloré, échéance
(date relative type « Dans 12 jours ») et/ou km prévu, et un bouton **« Fait »**.

**Statuts possibles :**
| Statut | Couleur | Signification |
|---|---|---|
| **Planifié** | bleu | Prévu, échéance pas encore atteinte |
| **Effectué** | vert | Terminé (après avoir appuyé sur « Fait ») |
| **En retard** | rouge | Date dépassée **ou** kilométrage prévu atteint |

### Formulaire « Nouvel entretien » — champs

| Champ | Obligatoire | Rôle / Ce qui se passe |
|---|---|---|
| **Type** | ✅ | Vidange, Pneus, Freins, Filtres, Courroie, Batterie, Contrôle technique, Autres. |
| **Date prévue** | Non* | Échéance par date. Déclenche un **rappel notification**. |
| **Kilométrage prévu** | Non* | Échéance par km. Passe « En retard » quand le compteur l'atteint. |
| **Coût estimé** | Non | Budget prévu. |
| **Notes** | Non | Détails. |

\* Au moins une échéance (date ou km) est recommandée pour que le rappel serve.

### Ce qui se passe après
- Si une **date prévue** est définie, une **notification locale** est programmée
  **3 jours avant** (ou le jour même si c'est plus proche).
- Le statut bascule **automatiquement en « En retard »** quand la date est passée
  ou que le kilométrage du véhicule atteint le km prévu.
- Bouton **« Fait »** → statut **Effectué** + date de réalisation enregistrée +
  le rappel est annulé.

---

## 5. 📊 Statistiques

### Où ?
Onglet **Stats**.

> Il faut **au moins 2 pleins complets** pour que la consommation soit calculée et
> que les graphiques apparaissent.

### Contenu
- **Bandeau d'alerte rouge** si des **consommations anormales** sont détectées
  (voir règle ci-dessous).
- **4 cartes de synthèse :**
  - **Conso moyenne** (L/100 km) sur l'ensemble des pleins complets,
  - **Coût total** (carburant + dépenses),
  - **Distance suivie** (somme des distances entre pleins complets),
  - **Coût par km**.
- **Courbe** : consommation moyenne par mois.
- **Histogramme** : coûts par mois (pleins + dépenses).
- **Camembert** : répartition des coûts par catégorie (carburant inclus).

### Détection d'anomalie
```
Une conso est "anormale" si :  valeur > moyenne × (1 + seuil/100)
```
Le **seuil par défaut est +20 %** (réglable dans les Réglages, de 5 % à 50 %).
Exemple : moyenne 6,3 L/100 km, seuil 20 % → toute conso **> 7,6 L/100 km** est signalée.

---

## 6. ⚙️ Réglages

### Sections
**Gestion** : raccourcis vers *Mes véhicules*, *Dépenses*, *Exporter mes données*.

**Apparence :**
| Réglage | Effet |
|---|---|
| **Thème** | Auto (système) / Clair / **Sombre** (par défaut). |
| **Grand texte** | Agrandit la police (accessibilité). |
| **Contraste élevé** | Option d'accessibilité. |

**Unités & devise :**
| Réglage | Options |
|---|---|
| **Devise** | € / $ / £ / MAD / CHF / CAD — utilisée partout pour les montants. |
| **Distance** | km / mi. |
| **Volume** | L / gal. |

**Alertes intelligentes :**
- **Seuil d'anomalie** (curseur 5 %–50 %) : sensibilité de la détection de surconsommation.
- **Activer les notifications** : demande l'autorisation système pour les rappels.

**À propos :** logo, version, mention 100 % hors-ligne.

---

## 7. 📤 Export des données

### Où ?
Réglages → **Exporter mes données**.

- **Exporter en PDF** : génère un **rapport** (synthèse des stats + historique des
  pleins du véhicule actif) puis ouvre le menu de partage.
- **Exporter en CSV** : exporte **tout** (pleins, dépenses, maintenances) dans un
  fichier compatible **Excel** (séparateur `;` + accents préservés), puis partage.

> Les fichiers sont créés localement, puis tu choisis où les envoyer (mail, Drive…).

---

## 🧪 Exemple réel, de bout en bout

Scénario : suivi d'une **Peugeot 208 essence**.

### Étape 1 — Créer le véhicule
- Marque **Peugeot**, Modèle **208**, Année **2020**, Carburant **Essence**,
  **Kilométrage initial : 50 000**. → Devient le véhicule par défaut.
- *Résultat :* le tableau de bord affiche « 50 000 km au compteur ».

### Étape 2 — Premier plein (référence)
- Date **01/05/2026**, Odomètre **50 000**, Volume **40 L**, Prix/L **1,80 €**, Type **Complet**.
- *Calcul auto :* Prix total = `40 × 1,80` = **72,00 €**.
- *Conso :* aucune (c'est le premier plein, pas de référence). Badge `—`.

### Étape 3 — Deuxième plein (la conso apparaît)
- Date **12/05/2026**, Odomètre **50 600**, Volume **38 L**, Prix/L **1,85 €**, Type **Complet**.
- *Calcul auto :* Prix total = `38 × 1,85` = **70,30 €**.
- *Calcul de la conso (par rapport au plein du 01/05) :*
  - distance = `50 600 − 50 000` = **600 km**
  - **L/100 km** = `(38 × 100) ÷ 600` = **6,33 L/100 km** ✅ (badge vert)
  - km/L = `600 ÷ 38` = **15,8 km/L**
  - coût/km = `70,30 ÷ 600` = **0,12 €/km**

### Étape 4 — Une dépense
- Catégorie **Assurance**, Montant **300 €**, Description *« Assurance annuelle »*.
- *Résultat :* Total dépenses = **300 €** ; apparaît dans le camembert des stats.

### Étape 5 — Un entretien
- Type **Vidange**, **Km prévu : 55 000**, Date prévue **01/08/2026**.
- *Résultat :* statut **Planifié**, rappel programmé pour le **29/07/2026** (3 j avant).
  Quand le compteur atteindra 55 000 km, il passera **En retard** automatiquement.

### Étape 6 — Lire les statistiques
- Conso moyenne ≈ **6,33 L/100 km**
- Coût total = carburant (`72,00 + 70,30` = 142,30 €) + dépenses (300 €) = **442,30 €**
- Distance suivie = **600 km**, coût/km ≈ **0,12 €**
- *Anomalie ?* seuil 20 % → limite = `6,33 × 1,20` ≈ **7,6 L/100 km**. Tant que les
  pleins restent sous 7,6, aucune alerte. Un plein à 8,5 L/100 km déclencherait le
  **bandeau rouge**.

### Étape 7 — Exporter
- **PDF** → rapport prêt à partager ; **CSV** → ouverture dans Excel.

---

## ✅ Résumé — Fonctionnalités & utilité

**FuelTrack** est une application mobile **100 % hors-ligne** de **suivi de
consommation de carburant, de dépenses et d'entretien** d'un ou plusieurs véhicules.

**Ce qu'elle permet :**
1. **Gérer plusieurs véhicules** (marque, modèle, carburant, photo, véhicule par défaut).
2. **Enregistrer les pleins** avec **calcul automatique** du prix total et de la
   **consommation** (L/100 km, km/L, coût/km), gestion des **pleins complets/partiels**,
   GPS et photo du reçu.
3. **Suivre toutes les dépenses** par catégorie (assurance, péage, réparation…).
4. **Planifier l'entretien** avec **rappels** par date ou kilométrage et statuts
   automatiques (Planifié / Effectué / En retard) + **notifications**.
5. **Visualiser des statistiques** : conso moyenne, coûts mensuels, répartition,
   distance, coût/km, et **détection automatique des surconsommations** (seuil réglable).
6. **Exporter** ses données en **PDF** (rapport) et **CSV** (Excel).
7. **Personnaliser** : thème clair/sombre, devise, unités, accessibilité, multi-véhicules.

**Règles de calcul clés :**
- `Prix total = Volume × Prix/L`
- Consommation calculée **uniquement entre deux pleins complets**
- Alerte si conso **> moyenne + seuil %** (20 % par défaut)

**En résumé :** FuelTrack aide à **mieux maîtriser son budget auto** et à **ne plus
oublier un entretien**, avec des chiffres fiables et des alertes intelligentes, le
tout **sans connexion Internet** et dans le respect de la vie privée.
