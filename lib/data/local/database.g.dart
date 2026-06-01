// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $VehiculesTable extends Vehicules
    with TableInfo<$VehiculesTable, Vehicule> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $VehiculesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marqueMeta = const VerificationMeta('marque');
  @override
  late final GeneratedColumn<String> marque = GeneratedColumn<String>(
    'marque',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeleMeta = const VerificationMeta('modele');
  @override
  late final GeneratedColumn<String> modele = GeneratedColumn<String>(
    'modele',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _anneeMeta = const VerificationMeta('annee');
  @override
  late final GeneratedColumn<int> annee = GeneratedColumn<int>(
    'annee',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _plaqueMeta = const VerificationMeta('plaque');
  @override
  late final GeneratedColumn<String> plaque = GeneratedColumn<String>(
    'plaque',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TypeCarburant, int>
  typeCarburant = GeneratedColumn<int>(
    'type_carburant',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  ).withConverter<TypeCarburant>($VehiculesTable.$convertertypeCarburant);
  static const VerificationMeta _kmInitialMeta = const VerificationMeta(
    'kmInitial',
  );
  @override
  late final GeneratedColumn<double> kmInitial = GeneratedColumn<double>(
    'km_initial',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateAjoutMeta = const VerificationMeta(
    'dateAjout',
  );
  @override
  late final GeneratedColumn<DateTime> dateAjout = GeneratedColumn<DateTime>(
    'date_ajout',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _parDefautMeta = const VerificationMeta(
    'parDefaut',
  );
  @override
  late final GeneratedColumn<bool> parDefaut = GeneratedColumn<bool>(
    'par_defaut',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("par_defaut" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    marque,
    modele,
    annee,
    plaque,
    typeCarburant,
    kmInitial,
    photo,
    dateAjout,
    parDefaut,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'vehicules';
  @override
  VerificationContext validateIntegrity(
    Insertable<Vehicule> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('marque')) {
      context.handle(
        _marqueMeta,
        marque.isAcceptableOrUnknown(data['marque']!, _marqueMeta),
      );
    } else if (isInserting) {
      context.missing(_marqueMeta);
    }
    if (data.containsKey('modele')) {
      context.handle(
        _modeleMeta,
        modele.isAcceptableOrUnknown(data['modele']!, _modeleMeta),
      );
    } else if (isInserting) {
      context.missing(_modeleMeta);
    }
    if (data.containsKey('annee')) {
      context.handle(
        _anneeMeta,
        annee.isAcceptableOrUnknown(data['annee']!, _anneeMeta),
      );
    } else if (isInserting) {
      context.missing(_anneeMeta);
    }
    if (data.containsKey('plaque')) {
      context.handle(
        _plaqueMeta,
        plaque.isAcceptableOrUnknown(data['plaque']!, _plaqueMeta),
      );
    }
    if (data.containsKey('km_initial')) {
      context.handle(
        _kmInitialMeta,
        kmInitial.isAcceptableOrUnknown(data['km_initial']!, _kmInitialMeta),
      );
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    if (data.containsKey('date_ajout')) {
      context.handle(
        _dateAjoutMeta,
        dateAjout.isAcceptableOrUnknown(data['date_ajout']!, _dateAjoutMeta),
      );
    } else if (isInserting) {
      context.missing(_dateAjoutMeta);
    }
    if (data.containsKey('par_defaut')) {
      context.handle(
        _parDefautMeta,
        parDefaut.isAcceptableOrUnknown(data['par_defaut']!, _parDefautMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Vehicule map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Vehicule(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      marque: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marque'],
      )!,
      modele: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modele'],
      )!,
      annee: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}annee'],
      )!,
      plaque: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}plaque'],
      ),
      typeCarburant: $VehiculesTable.$convertertypeCarburant.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type_carburant'],
        )!,
      ),
      kmInitial: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}km_initial'],
      )!,
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
      dateAjout: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_ajout'],
      )!,
      parDefaut: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}par_defaut'],
      )!,
    );
  }

  @override
  $VehiculesTable createAlias(String alias) {
    return $VehiculesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TypeCarburant, int, int> $convertertypeCarburant =
      const EnumIndexConverter<TypeCarburant>(TypeCarburant.values);
}

class Vehicule extends DataClass implements Insertable<Vehicule> {
  final String id;
  final String marque;
  final String modele;
  final int annee;
  final String? plaque;
  final TypeCarburant typeCarburant;
  final double kmInitial;
  final String? photo;
  final DateTime dateAjout;
  final bool parDefaut;
  const Vehicule({
    required this.id,
    required this.marque,
    required this.modele,
    required this.annee,
    this.plaque,
    required this.typeCarburant,
    required this.kmInitial,
    this.photo,
    required this.dateAjout,
    required this.parDefaut,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['marque'] = Variable<String>(marque);
    map['modele'] = Variable<String>(modele);
    map['annee'] = Variable<int>(annee);
    if (!nullToAbsent || plaque != null) {
      map['plaque'] = Variable<String>(plaque);
    }
    {
      map['type_carburant'] = Variable<int>(
        $VehiculesTable.$convertertypeCarburant.toSql(typeCarburant),
      );
    }
    map['km_initial'] = Variable<double>(kmInitial);
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    map['date_ajout'] = Variable<DateTime>(dateAjout);
    map['par_defaut'] = Variable<bool>(parDefaut);
    return map;
  }

  VehiculesCompanion toCompanion(bool nullToAbsent) {
    return VehiculesCompanion(
      id: Value(id),
      marque: Value(marque),
      modele: Value(modele),
      annee: Value(annee),
      plaque: plaque == null && nullToAbsent
          ? const Value.absent()
          : Value(plaque),
      typeCarburant: Value(typeCarburant),
      kmInitial: Value(kmInitial),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
      dateAjout: Value(dateAjout),
      parDefaut: Value(parDefaut),
    );
  }

  factory Vehicule.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Vehicule(
      id: serializer.fromJson<String>(json['id']),
      marque: serializer.fromJson<String>(json['marque']),
      modele: serializer.fromJson<String>(json['modele']),
      annee: serializer.fromJson<int>(json['annee']),
      plaque: serializer.fromJson<String?>(json['plaque']),
      typeCarburant: $VehiculesTable.$convertertypeCarburant.fromJson(
        serializer.fromJson<int>(json['typeCarburant']),
      ),
      kmInitial: serializer.fromJson<double>(json['kmInitial']),
      photo: serializer.fromJson<String?>(json['photo']),
      dateAjout: serializer.fromJson<DateTime>(json['dateAjout']),
      parDefaut: serializer.fromJson<bool>(json['parDefaut']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'marque': serializer.toJson<String>(marque),
      'modele': serializer.toJson<String>(modele),
      'annee': serializer.toJson<int>(annee),
      'plaque': serializer.toJson<String?>(plaque),
      'typeCarburant': serializer.toJson<int>(
        $VehiculesTable.$convertertypeCarburant.toJson(typeCarburant),
      ),
      'kmInitial': serializer.toJson<double>(kmInitial),
      'photo': serializer.toJson<String?>(photo),
      'dateAjout': serializer.toJson<DateTime>(dateAjout),
      'parDefaut': serializer.toJson<bool>(parDefaut),
    };
  }

  Vehicule copyWith({
    String? id,
    String? marque,
    String? modele,
    int? annee,
    Value<String?> plaque = const Value.absent(),
    TypeCarburant? typeCarburant,
    double? kmInitial,
    Value<String?> photo = const Value.absent(),
    DateTime? dateAjout,
    bool? parDefaut,
  }) => Vehicule(
    id: id ?? this.id,
    marque: marque ?? this.marque,
    modele: modele ?? this.modele,
    annee: annee ?? this.annee,
    plaque: plaque.present ? plaque.value : this.plaque,
    typeCarburant: typeCarburant ?? this.typeCarburant,
    kmInitial: kmInitial ?? this.kmInitial,
    photo: photo.present ? photo.value : this.photo,
    dateAjout: dateAjout ?? this.dateAjout,
    parDefaut: parDefaut ?? this.parDefaut,
  );
  Vehicule copyWithCompanion(VehiculesCompanion data) {
    return Vehicule(
      id: data.id.present ? data.id.value : this.id,
      marque: data.marque.present ? data.marque.value : this.marque,
      modele: data.modele.present ? data.modele.value : this.modele,
      annee: data.annee.present ? data.annee.value : this.annee,
      plaque: data.plaque.present ? data.plaque.value : this.plaque,
      typeCarburant: data.typeCarburant.present
          ? data.typeCarburant.value
          : this.typeCarburant,
      kmInitial: data.kmInitial.present ? data.kmInitial.value : this.kmInitial,
      photo: data.photo.present ? data.photo.value : this.photo,
      dateAjout: data.dateAjout.present ? data.dateAjout.value : this.dateAjout,
      parDefaut: data.parDefaut.present ? data.parDefaut.value : this.parDefaut,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Vehicule(')
          ..write('id: $id, ')
          ..write('marque: $marque, ')
          ..write('modele: $modele, ')
          ..write('annee: $annee, ')
          ..write('plaque: $plaque, ')
          ..write('typeCarburant: $typeCarburant, ')
          ..write('kmInitial: $kmInitial, ')
          ..write('photo: $photo, ')
          ..write('dateAjout: $dateAjout, ')
          ..write('parDefaut: $parDefaut')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    marque,
    modele,
    annee,
    plaque,
    typeCarburant,
    kmInitial,
    photo,
    dateAjout,
    parDefaut,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Vehicule &&
          other.id == this.id &&
          other.marque == this.marque &&
          other.modele == this.modele &&
          other.annee == this.annee &&
          other.plaque == this.plaque &&
          other.typeCarburant == this.typeCarburant &&
          other.kmInitial == this.kmInitial &&
          other.photo == this.photo &&
          other.dateAjout == this.dateAjout &&
          other.parDefaut == this.parDefaut);
}

class VehiculesCompanion extends UpdateCompanion<Vehicule> {
  final Value<String> id;
  final Value<String> marque;
  final Value<String> modele;
  final Value<int> annee;
  final Value<String?> plaque;
  final Value<TypeCarburant> typeCarburant;
  final Value<double> kmInitial;
  final Value<String?> photo;
  final Value<DateTime> dateAjout;
  final Value<bool> parDefaut;
  final Value<int> rowid;
  const VehiculesCompanion({
    this.id = const Value.absent(),
    this.marque = const Value.absent(),
    this.modele = const Value.absent(),
    this.annee = const Value.absent(),
    this.plaque = const Value.absent(),
    this.typeCarburant = const Value.absent(),
    this.kmInitial = const Value.absent(),
    this.photo = const Value.absent(),
    this.dateAjout = const Value.absent(),
    this.parDefaut = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  VehiculesCompanion.insert({
    required String id,
    required String marque,
    required String modele,
    required int annee,
    this.plaque = const Value.absent(),
    required TypeCarburant typeCarburant,
    this.kmInitial = const Value.absent(),
    this.photo = const Value.absent(),
    required DateTime dateAjout,
    this.parDefaut = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       marque = Value(marque),
       modele = Value(modele),
       annee = Value(annee),
       typeCarburant = Value(typeCarburant),
       dateAjout = Value(dateAjout);
  static Insertable<Vehicule> custom({
    Expression<String>? id,
    Expression<String>? marque,
    Expression<String>? modele,
    Expression<int>? annee,
    Expression<String>? plaque,
    Expression<int>? typeCarburant,
    Expression<double>? kmInitial,
    Expression<String>? photo,
    Expression<DateTime>? dateAjout,
    Expression<bool>? parDefaut,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (marque != null) 'marque': marque,
      if (modele != null) 'modele': modele,
      if (annee != null) 'annee': annee,
      if (plaque != null) 'plaque': plaque,
      if (typeCarburant != null) 'type_carburant': typeCarburant,
      if (kmInitial != null) 'km_initial': kmInitial,
      if (photo != null) 'photo': photo,
      if (dateAjout != null) 'date_ajout': dateAjout,
      if (parDefaut != null) 'par_defaut': parDefaut,
      if (rowid != null) 'rowid': rowid,
    });
  }

  VehiculesCompanion copyWith({
    Value<String>? id,
    Value<String>? marque,
    Value<String>? modele,
    Value<int>? annee,
    Value<String?>? plaque,
    Value<TypeCarburant>? typeCarburant,
    Value<double>? kmInitial,
    Value<String?>? photo,
    Value<DateTime>? dateAjout,
    Value<bool>? parDefaut,
    Value<int>? rowid,
  }) {
    return VehiculesCompanion(
      id: id ?? this.id,
      marque: marque ?? this.marque,
      modele: modele ?? this.modele,
      annee: annee ?? this.annee,
      plaque: plaque ?? this.plaque,
      typeCarburant: typeCarburant ?? this.typeCarburant,
      kmInitial: kmInitial ?? this.kmInitial,
      photo: photo ?? this.photo,
      dateAjout: dateAjout ?? this.dateAjout,
      parDefaut: parDefaut ?? this.parDefaut,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (marque.present) {
      map['marque'] = Variable<String>(marque.value);
    }
    if (modele.present) {
      map['modele'] = Variable<String>(modele.value);
    }
    if (annee.present) {
      map['annee'] = Variable<int>(annee.value);
    }
    if (plaque.present) {
      map['plaque'] = Variable<String>(plaque.value);
    }
    if (typeCarburant.present) {
      map['type_carburant'] = Variable<int>(
        $VehiculesTable.$convertertypeCarburant.toSql(typeCarburant.value),
      );
    }
    if (kmInitial.present) {
      map['km_initial'] = Variable<double>(kmInitial.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (dateAjout.present) {
      map['date_ajout'] = Variable<DateTime>(dateAjout.value);
    }
    if (parDefaut.present) {
      map['par_defaut'] = Variable<bool>(parDefaut.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('VehiculesCompanion(')
          ..write('id: $id, ')
          ..write('marque: $marque, ')
          ..write('modele: $modele, ')
          ..write('annee: $annee, ')
          ..write('plaque: $plaque, ')
          ..write('typeCarburant: $typeCarburant, ')
          ..write('kmInitial: $kmInitial, ')
          ..write('photo: $photo, ')
          ..write('dateAjout: $dateAjout, ')
          ..write('parDefaut: $parDefaut, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PleinsTable extends Pleins with TableInfo<$PleinsTable, Plein> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PleinsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehiculeIdMeta = const VerificationMeta(
    'vehiculeId',
  );
  @override
  late final GeneratedColumn<String> vehiculeId = GeneratedColumn<String>(
    'vehicule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicules (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _odometreMeta = const VerificationMeta(
    'odometre',
  );
  @override
  late final GeneratedColumn<double> odometre = GeneratedColumn<double>(
    'odometre',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _volumeMeta = const VerificationMeta('volume');
  @override
  late final GeneratedColumn<double> volume = GeneratedColumn<double>(
    'volume',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prixUnitaireMeta = const VerificationMeta(
    'prixUnitaire',
  );
  @override
  late final GeneratedColumn<double> prixUnitaire = GeneratedColumn<double>(
    'prix_unitaire',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _prixTotalMeta = const VerificationMeta(
    'prixTotal',
  );
  @override
  late final GeneratedColumn<double> prixTotal = GeneratedColumn<double>(
    'prix_total',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stationMeta = const VerificationMeta(
    'station',
  );
  @override
  late final GeneratedColumn<String> station = GeneratedColumn<String>(
    'station',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _latitudeMeta = const VerificationMeta(
    'latitude',
  );
  @override
  late final GeneratedColumn<double> latitude = GeneratedColumn<double>(
    'latitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _longitudeMeta = const VerificationMeta(
    'longitude',
  );
  @override
  late final GeneratedColumn<double> longitude = GeneratedColumn<double>(
    'longitude',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TypePlein, int> typePlein =
      GeneratedColumn<int>(
        'type_plein',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<TypePlein>($PleinsTable.$convertertypePlein);
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehiculeId,
    date,
    odometre,
    volume,
    prixUnitaire,
    prixTotal,
    station,
    latitude,
    longitude,
    notes,
    photo,
    typePlein,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'pleins';
  @override
  VerificationContext validateIntegrity(
    Insertable<Plein> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicule_id')) {
      context.handle(
        _vehiculeIdMeta,
        vehiculeId.isAcceptableOrUnknown(data['vehicule_id']!, _vehiculeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehiculeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('odometre')) {
      context.handle(
        _odometreMeta,
        odometre.isAcceptableOrUnknown(data['odometre']!, _odometreMeta),
      );
    } else if (isInserting) {
      context.missing(_odometreMeta);
    }
    if (data.containsKey('volume')) {
      context.handle(
        _volumeMeta,
        volume.isAcceptableOrUnknown(data['volume']!, _volumeMeta),
      );
    } else if (isInserting) {
      context.missing(_volumeMeta);
    }
    if (data.containsKey('prix_unitaire')) {
      context.handle(
        _prixUnitaireMeta,
        prixUnitaire.isAcceptableOrUnknown(
          data['prix_unitaire']!,
          _prixUnitaireMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_prixUnitaireMeta);
    }
    if (data.containsKey('prix_total')) {
      context.handle(
        _prixTotalMeta,
        prixTotal.isAcceptableOrUnknown(data['prix_total']!, _prixTotalMeta),
      );
    } else if (isInserting) {
      context.missing(_prixTotalMeta);
    }
    if (data.containsKey('station')) {
      context.handle(
        _stationMeta,
        station.isAcceptableOrUnknown(data['station']!, _stationMeta),
      );
    }
    if (data.containsKey('latitude')) {
      context.handle(
        _latitudeMeta,
        latitude.isAcceptableOrUnknown(data['latitude']!, _latitudeMeta),
      );
    }
    if (data.containsKey('longitude')) {
      context.handle(
        _longitudeMeta,
        longitude.isAcceptableOrUnknown(data['longitude']!, _longitudeMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Plein map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Plein(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehiculeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicule_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      odometre: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}odometre'],
      )!,
      volume: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}volume'],
      )!,
      prixUnitaire: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix_unitaire'],
      )!,
      prixTotal: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}prix_total'],
      )!,
      station: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}station'],
      ),
      latitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}latitude'],
      ),
      longitude: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}longitude'],
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
      typePlein: $PleinsTable.$convertertypePlein.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type_plein'],
        )!,
      ),
    );
  }

  @override
  $PleinsTable createAlias(String alias) {
    return $PleinsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TypePlein, int, int> $convertertypePlein =
      const EnumIndexConverter<TypePlein>(TypePlein.values);
}

class Plein extends DataClass implements Insertable<Plein> {
  final String id;
  final String vehiculeId;
  final DateTime date;
  final double odometre;
  final double volume;
  final double prixUnitaire;
  final double prixTotal;
  final String? station;
  final double? latitude;
  final double? longitude;
  final String? notes;
  final String? photo;
  final TypePlein typePlein;
  const Plein({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.odometre,
    required this.volume,
    required this.prixUnitaire,
    required this.prixTotal,
    this.station,
    this.latitude,
    this.longitude,
    this.notes,
    this.photo,
    required this.typePlein,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicule_id'] = Variable<String>(vehiculeId);
    map['date'] = Variable<DateTime>(date);
    map['odometre'] = Variable<double>(odometre);
    map['volume'] = Variable<double>(volume);
    map['prix_unitaire'] = Variable<double>(prixUnitaire);
    map['prix_total'] = Variable<double>(prixTotal);
    if (!nullToAbsent || station != null) {
      map['station'] = Variable<String>(station);
    }
    if (!nullToAbsent || latitude != null) {
      map['latitude'] = Variable<double>(latitude);
    }
    if (!nullToAbsent || longitude != null) {
      map['longitude'] = Variable<double>(longitude);
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    {
      map['type_plein'] = Variable<int>(
        $PleinsTable.$convertertypePlein.toSql(typePlein),
      );
    }
    return map;
  }

  PleinsCompanion toCompanion(bool nullToAbsent) {
    return PleinsCompanion(
      id: Value(id),
      vehiculeId: Value(vehiculeId),
      date: Value(date),
      odometre: Value(odometre),
      volume: Value(volume),
      prixUnitaire: Value(prixUnitaire),
      prixTotal: Value(prixTotal),
      station: station == null && nullToAbsent
          ? const Value.absent()
          : Value(station),
      latitude: latitude == null && nullToAbsent
          ? const Value.absent()
          : Value(latitude),
      longitude: longitude == null && nullToAbsent
          ? const Value.absent()
          : Value(longitude),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
      typePlein: Value(typePlein),
    );
  }

  factory Plein.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Plein(
      id: serializer.fromJson<String>(json['id']),
      vehiculeId: serializer.fromJson<String>(json['vehiculeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      odometre: serializer.fromJson<double>(json['odometre']),
      volume: serializer.fromJson<double>(json['volume']),
      prixUnitaire: serializer.fromJson<double>(json['prixUnitaire']),
      prixTotal: serializer.fromJson<double>(json['prixTotal']),
      station: serializer.fromJson<String?>(json['station']),
      latitude: serializer.fromJson<double?>(json['latitude']),
      longitude: serializer.fromJson<double?>(json['longitude']),
      notes: serializer.fromJson<String?>(json['notes']),
      photo: serializer.fromJson<String?>(json['photo']),
      typePlein: $PleinsTable.$convertertypePlein.fromJson(
        serializer.fromJson<int>(json['typePlein']),
      ),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehiculeId': serializer.toJson<String>(vehiculeId),
      'date': serializer.toJson<DateTime>(date),
      'odometre': serializer.toJson<double>(odometre),
      'volume': serializer.toJson<double>(volume),
      'prixUnitaire': serializer.toJson<double>(prixUnitaire),
      'prixTotal': serializer.toJson<double>(prixTotal),
      'station': serializer.toJson<String?>(station),
      'latitude': serializer.toJson<double?>(latitude),
      'longitude': serializer.toJson<double?>(longitude),
      'notes': serializer.toJson<String?>(notes),
      'photo': serializer.toJson<String?>(photo),
      'typePlein': serializer.toJson<int>(
        $PleinsTable.$convertertypePlein.toJson(typePlein),
      ),
    };
  }

  Plein copyWith({
    String? id,
    String? vehiculeId,
    DateTime? date,
    double? odometre,
    double? volume,
    double? prixUnitaire,
    double? prixTotal,
    Value<String?> station = const Value.absent(),
    Value<double?> latitude = const Value.absent(),
    Value<double?> longitude = const Value.absent(),
    Value<String?> notes = const Value.absent(),
    Value<String?> photo = const Value.absent(),
    TypePlein? typePlein,
  }) => Plein(
    id: id ?? this.id,
    vehiculeId: vehiculeId ?? this.vehiculeId,
    date: date ?? this.date,
    odometre: odometre ?? this.odometre,
    volume: volume ?? this.volume,
    prixUnitaire: prixUnitaire ?? this.prixUnitaire,
    prixTotal: prixTotal ?? this.prixTotal,
    station: station.present ? station.value : this.station,
    latitude: latitude.present ? latitude.value : this.latitude,
    longitude: longitude.present ? longitude.value : this.longitude,
    notes: notes.present ? notes.value : this.notes,
    photo: photo.present ? photo.value : this.photo,
    typePlein: typePlein ?? this.typePlein,
  );
  Plein copyWithCompanion(PleinsCompanion data) {
    return Plein(
      id: data.id.present ? data.id.value : this.id,
      vehiculeId: data.vehiculeId.present
          ? data.vehiculeId.value
          : this.vehiculeId,
      date: data.date.present ? data.date.value : this.date,
      odometre: data.odometre.present ? data.odometre.value : this.odometre,
      volume: data.volume.present ? data.volume.value : this.volume,
      prixUnitaire: data.prixUnitaire.present
          ? data.prixUnitaire.value
          : this.prixUnitaire,
      prixTotal: data.prixTotal.present ? data.prixTotal.value : this.prixTotal,
      station: data.station.present ? data.station.value : this.station,
      latitude: data.latitude.present ? data.latitude.value : this.latitude,
      longitude: data.longitude.present ? data.longitude.value : this.longitude,
      notes: data.notes.present ? data.notes.value : this.notes,
      photo: data.photo.present ? data.photo.value : this.photo,
      typePlein: data.typePlein.present ? data.typePlein.value : this.typePlein,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Plein(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('date: $date, ')
          ..write('odometre: $odometre, ')
          ..write('volume: $volume, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('prixTotal: $prixTotal, ')
          ..write('station: $station, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('photo: $photo, ')
          ..write('typePlein: $typePlein')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehiculeId,
    date,
    odometre,
    volume,
    prixUnitaire,
    prixTotal,
    station,
    latitude,
    longitude,
    notes,
    photo,
    typePlein,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Plein &&
          other.id == this.id &&
          other.vehiculeId == this.vehiculeId &&
          other.date == this.date &&
          other.odometre == this.odometre &&
          other.volume == this.volume &&
          other.prixUnitaire == this.prixUnitaire &&
          other.prixTotal == this.prixTotal &&
          other.station == this.station &&
          other.latitude == this.latitude &&
          other.longitude == this.longitude &&
          other.notes == this.notes &&
          other.photo == this.photo &&
          other.typePlein == this.typePlein);
}

class PleinsCompanion extends UpdateCompanion<Plein> {
  final Value<String> id;
  final Value<String> vehiculeId;
  final Value<DateTime> date;
  final Value<double> odometre;
  final Value<double> volume;
  final Value<double> prixUnitaire;
  final Value<double> prixTotal;
  final Value<String?> station;
  final Value<double?> latitude;
  final Value<double?> longitude;
  final Value<String?> notes;
  final Value<String?> photo;
  final Value<TypePlein> typePlein;
  final Value<int> rowid;
  const PleinsCompanion({
    this.id = const Value.absent(),
    this.vehiculeId = const Value.absent(),
    this.date = const Value.absent(),
    this.odometre = const Value.absent(),
    this.volume = const Value.absent(),
    this.prixUnitaire = const Value.absent(),
    this.prixTotal = const Value.absent(),
    this.station = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.photo = const Value.absent(),
    this.typePlein = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PleinsCompanion.insert({
    required String id,
    required String vehiculeId,
    required DateTime date,
    required double odometre,
    required double volume,
    required double prixUnitaire,
    required double prixTotal,
    this.station = const Value.absent(),
    this.latitude = const Value.absent(),
    this.longitude = const Value.absent(),
    this.notes = const Value.absent(),
    this.photo = const Value.absent(),
    this.typePlein = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehiculeId = Value(vehiculeId),
       date = Value(date),
       odometre = Value(odometre),
       volume = Value(volume),
       prixUnitaire = Value(prixUnitaire),
       prixTotal = Value(prixTotal);
  static Insertable<Plein> custom({
    Expression<String>? id,
    Expression<String>? vehiculeId,
    Expression<DateTime>? date,
    Expression<double>? odometre,
    Expression<double>? volume,
    Expression<double>? prixUnitaire,
    Expression<double>? prixTotal,
    Expression<String>? station,
    Expression<double>? latitude,
    Expression<double>? longitude,
    Expression<String>? notes,
    Expression<String>? photo,
    Expression<int>? typePlein,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehiculeId != null) 'vehicule_id': vehiculeId,
      if (date != null) 'date': date,
      if (odometre != null) 'odometre': odometre,
      if (volume != null) 'volume': volume,
      if (prixUnitaire != null) 'prix_unitaire': prixUnitaire,
      if (prixTotal != null) 'prix_total': prixTotal,
      if (station != null) 'station': station,
      if (latitude != null) 'latitude': latitude,
      if (longitude != null) 'longitude': longitude,
      if (notes != null) 'notes': notes,
      if (photo != null) 'photo': photo,
      if (typePlein != null) 'type_plein': typePlein,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PleinsCompanion copyWith({
    Value<String>? id,
    Value<String>? vehiculeId,
    Value<DateTime>? date,
    Value<double>? odometre,
    Value<double>? volume,
    Value<double>? prixUnitaire,
    Value<double>? prixTotal,
    Value<String?>? station,
    Value<double?>? latitude,
    Value<double?>? longitude,
    Value<String?>? notes,
    Value<String?>? photo,
    Value<TypePlein>? typePlein,
    Value<int>? rowid,
  }) {
    return PleinsCompanion(
      id: id ?? this.id,
      vehiculeId: vehiculeId ?? this.vehiculeId,
      date: date ?? this.date,
      odometre: odometre ?? this.odometre,
      volume: volume ?? this.volume,
      prixUnitaire: prixUnitaire ?? this.prixUnitaire,
      prixTotal: prixTotal ?? this.prixTotal,
      station: station ?? this.station,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      notes: notes ?? this.notes,
      photo: photo ?? this.photo,
      typePlein: typePlein ?? this.typePlein,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehiculeId.present) {
      map['vehicule_id'] = Variable<String>(vehiculeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (odometre.present) {
      map['odometre'] = Variable<double>(odometre.value);
    }
    if (volume.present) {
      map['volume'] = Variable<double>(volume.value);
    }
    if (prixUnitaire.present) {
      map['prix_unitaire'] = Variable<double>(prixUnitaire.value);
    }
    if (prixTotal.present) {
      map['prix_total'] = Variable<double>(prixTotal.value);
    }
    if (station.present) {
      map['station'] = Variable<String>(station.value);
    }
    if (latitude.present) {
      map['latitude'] = Variable<double>(latitude.value);
    }
    if (longitude.present) {
      map['longitude'] = Variable<double>(longitude.value);
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (typePlein.present) {
      map['type_plein'] = Variable<int>(
        $PleinsTable.$convertertypePlein.toSql(typePlein.value),
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PleinsCompanion(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('date: $date, ')
          ..write('odometre: $odometre, ')
          ..write('volume: $volume, ')
          ..write('prixUnitaire: $prixUnitaire, ')
          ..write('prixTotal: $prixTotal, ')
          ..write('station: $station, ')
          ..write('latitude: $latitude, ')
          ..write('longitude: $longitude, ')
          ..write('notes: $notes, ')
          ..write('photo: $photo, ')
          ..write('typePlein: $typePlein, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DepensesTable extends Depenses with TableInfo<$DepensesTable, Depense> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DepensesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehiculeIdMeta = const VerificationMeta(
    'vehiculeId',
  );
  @override
  late final GeneratedColumn<String> vehiculeId = GeneratedColumn<String>(
    'vehicule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicules (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dateMeta = const VerificationMeta('date');
  @override
  late final GeneratedColumn<DateTime> date = GeneratedColumn<DateTime>(
    'date',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _montantMeta = const VerificationMeta(
    'montant',
  );
  @override
  late final GeneratedColumn<double> montant = GeneratedColumn<double>(
    'montant',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<CategorieDepense, int> categorie =
      GeneratedColumn<int>(
        'categorie',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<CategorieDepense>($DepensesTable.$convertercategorie);
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _photoMeta = const VerificationMeta('photo');
  @override
  late final GeneratedColumn<String> photo = GeneratedColumn<String>(
    'photo',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehiculeId,
    date,
    montant,
    categorie,
    description,
    photo,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'depenses';
  @override
  VerificationContext validateIntegrity(
    Insertable<Depense> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicule_id')) {
      context.handle(
        _vehiculeIdMeta,
        vehiculeId.isAcceptableOrUnknown(data['vehicule_id']!, _vehiculeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehiculeIdMeta);
    }
    if (data.containsKey('date')) {
      context.handle(
        _dateMeta,
        date.isAcceptableOrUnknown(data['date']!, _dateMeta),
      );
    } else if (isInserting) {
      context.missing(_dateMeta);
    }
    if (data.containsKey('montant')) {
      context.handle(
        _montantMeta,
        montant.isAcceptableOrUnknown(data['montant']!, _montantMeta),
      );
    } else if (isInserting) {
      context.missing(_montantMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('photo')) {
      context.handle(
        _photoMeta,
        photo.isAcceptableOrUnknown(data['photo']!, _photoMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Depense map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Depense(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehiculeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicule_id'],
      )!,
      date: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date'],
      )!,
      montant: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}montant'],
      )!,
      categorie: $DepensesTable.$convertercategorie.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}categorie'],
        )!,
      ),
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      photo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo'],
      ),
    );
  }

  @override
  $DepensesTable createAlias(String alias) {
    return $DepensesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<CategorieDepense, int, int> $convertercategorie =
      const EnumIndexConverter<CategorieDepense>(CategorieDepense.values);
}

class Depense extends DataClass implements Insertable<Depense> {
  final String id;
  final String vehiculeId;
  final DateTime date;
  final double montant;
  final CategorieDepense categorie;
  final String? description;
  final String? photo;
  const Depense({
    required this.id,
    required this.vehiculeId,
    required this.date,
    required this.montant,
    required this.categorie,
    this.description,
    this.photo,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicule_id'] = Variable<String>(vehiculeId);
    map['date'] = Variable<DateTime>(date);
    map['montant'] = Variable<double>(montant);
    {
      map['categorie'] = Variable<int>(
        $DepensesTable.$convertercategorie.toSql(categorie),
      );
    }
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || photo != null) {
      map['photo'] = Variable<String>(photo);
    }
    return map;
  }

  DepensesCompanion toCompanion(bool nullToAbsent) {
    return DepensesCompanion(
      id: Value(id),
      vehiculeId: Value(vehiculeId),
      date: Value(date),
      montant: Value(montant),
      categorie: Value(categorie),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      photo: photo == null && nullToAbsent
          ? const Value.absent()
          : Value(photo),
    );
  }

  factory Depense.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Depense(
      id: serializer.fromJson<String>(json['id']),
      vehiculeId: serializer.fromJson<String>(json['vehiculeId']),
      date: serializer.fromJson<DateTime>(json['date']),
      montant: serializer.fromJson<double>(json['montant']),
      categorie: $DepensesTable.$convertercategorie.fromJson(
        serializer.fromJson<int>(json['categorie']),
      ),
      description: serializer.fromJson<String?>(json['description']),
      photo: serializer.fromJson<String?>(json['photo']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehiculeId': serializer.toJson<String>(vehiculeId),
      'date': serializer.toJson<DateTime>(date),
      'montant': serializer.toJson<double>(montant),
      'categorie': serializer.toJson<int>(
        $DepensesTable.$convertercategorie.toJson(categorie),
      ),
      'description': serializer.toJson<String?>(description),
      'photo': serializer.toJson<String?>(photo),
    };
  }

  Depense copyWith({
    String? id,
    String? vehiculeId,
    DateTime? date,
    double? montant,
    CategorieDepense? categorie,
    Value<String?> description = const Value.absent(),
    Value<String?> photo = const Value.absent(),
  }) => Depense(
    id: id ?? this.id,
    vehiculeId: vehiculeId ?? this.vehiculeId,
    date: date ?? this.date,
    montant: montant ?? this.montant,
    categorie: categorie ?? this.categorie,
    description: description.present ? description.value : this.description,
    photo: photo.present ? photo.value : this.photo,
  );
  Depense copyWithCompanion(DepensesCompanion data) {
    return Depense(
      id: data.id.present ? data.id.value : this.id,
      vehiculeId: data.vehiculeId.present
          ? data.vehiculeId.value
          : this.vehiculeId,
      date: data.date.present ? data.date.value : this.date,
      montant: data.montant.present ? data.montant.value : this.montant,
      categorie: data.categorie.present ? data.categorie.value : this.categorie,
      description: data.description.present
          ? data.description.value
          : this.description,
      photo: data.photo.present ? data.photo.value : this.photo,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Depense(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('date: $date, ')
          ..write('montant: $montant, ')
          ..write('categorie: $categorie, ')
          ..write('description: $description, ')
          ..write('photo: $photo')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, vehiculeId, date, montant, categorie, description, photo);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Depense &&
          other.id == this.id &&
          other.vehiculeId == this.vehiculeId &&
          other.date == this.date &&
          other.montant == this.montant &&
          other.categorie == this.categorie &&
          other.description == this.description &&
          other.photo == this.photo);
}

class DepensesCompanion extends UpdateCompanion<Depense> {
  final Value<String> id;
  final Value<String> vehiculeId;
  final Value<DateTime> date;
  final Value<double> montant;
  final Value<CategorieDepense> categorie;
  final Value<String?> description;
  final Value<String?> photo;
  final Value<int> rowid;
  const DepensesCompanion({
    this.id = const Value.absent(),
    this.vehiculeId = const Value.absent(),
    this.date = const Value.absent(),
    this.montant = const Value.absent(),
    this.categorie = const Value.absent(),
    this.description = const Value.absent(),
    this.photo = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DepensesCompanion.insert({
    required String id,
    required String vehiculeId,
    required DateTime date,
    required double montant,
    required CategorieDepense categorie,
    this.description = const Value.absent(),
    this.photo = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehiculeId = Value(vehiculeId),
       date = Value(date),
       montant = Value(montant),
       categorie = Value(categorie);
  static Insertable<Depense> custom({
    Expression<String>? id,
    Expression<String>? vehiculeId,
    Expression<DateTime>? date,
    Expression<double>? montant,
    Expression<int>? categorie,
    Expression<String>? description,
    Expression<String>? photo,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehiculeId != null) 'vehicule_id': vehiculeId,
      if (date != null) 'date': date,
      if (montant != null) 'montant': montant,
      if (categorie != null) 'categorie': categorie,
      if (description != null) 'description': description,
      if (photo != null) 'photo': photo,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DepensesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehiculeId,
    Value<DateTime>? date,
    Value<double>? montant,
    Value<CategorieDepense>? categorie,
    Value<String?>? description,
    Value<String?>? photo,
    Value<int>? rowid,
  }) {
    return DepensesCompanion(
      id: id ?? this.id,
      vehiculeId: vehiculeId ?? this.vehiculeId,
      date: date ?? this.date,
      montant: montant ?? this.montant,
      categorie: categorie ?? this.categorie,
      description: description ?? this.description,
      photo: photo ?? this.photo,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehiculeId.present) {
      map['vehicule_id'] = Variable<String>(vehiculeId.value);
    }
    if (date.present) {
      map['date'] = Variable<DateTime>(date.value);
    }
    if (montant.present) {
      map['montant'] = Variable<double>(montant.value);
    }
    if (categorie.present) {
      map['categorie'] = Variable<int>(
        $DepensesTable.$convertercategorie.toSql(categorie.value),
      );
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (photo.present) {
      map['photo'] = Variable<String>(photo.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DepensesCompanion(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('date: $date, ')
          ..write('montant: $montant, ')
          ..write('categorie: $categorie, ')
          ..write('description: $description, ')
          ..write('photo: $photo, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MaintenancesTable extends Maintenances
    with TableInfo<$MaintenancesTable, Maintenance> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenancesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _vehiculeIdMeta = const VerificationMeta(
    'vehiculeId',
  );
  @override
  late final GeneratedColumn<String> vehiculeId = GeneratedColumn<String>(
    'vehicule_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES vehicules (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<TypeMaintenance, int> type =
      GeneratedColumn<int>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: true,
      ).withConverter<TypeMaintenance>($MaintenancesTable.$convertertype);
  static const VerificationMeta _kmPrevuMeta = const VerificationMeta(
    'kmPrevu',
  );
  @override
  late final GeneratedColumn<double> kmPrevu = GeneratedColumn<double>(
    'km_prevu',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _datePrevueMeta = const VerificationMeta(
    'datePrevue',
  );
  @override
  late final GeneratedColumn<DateTime> datePrevue = GeneratedColumn<DateTime>(
    'date_prevue',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<StatutMaintenance, int> statut =
      GeneratedColumn<int>(
        'statut',
        aliasedName,
        false,
        type: DriftSqlType.int,
        requiredDuringInsert: false,
        defaultValue: const Constant(0),
      ).withConverter<StatutMaintenance>($MaintenancesTable.$converterstatut);
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _dateEffectueMeta = const VerificationMeta(
    'dateEffectue',
  );
  @override
  late final GeneratedColumn<DateTime> dateEffectue = GeneratedColumn<DateTime>(
    'date_effectue',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _coutMeta = const VerificationMeta('cout');
  @override
  late final GeneratedColumn<double> cout = GeneratedColumn<double>(
    'cout',
    aliasedName,
    true,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    vehiculeId,
    type,
    kmPrevu,
    datePrevue,
    statut,
    notes,
    dateEffectue,
    cout,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenances';
  @override
  VerificationContext validateIntegrity(
    Insertable<Maintenance> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('vehicule_id')) {
      context.handle(
        _vehiculeIdMeta,
        vehiculeId.isAcceptableOrUnknown(data['vehicule_id']!, _vehiculeIdMeta),
      );
    } else if (isInserting) {
      context.missing(_vehiculeIdMeta);
    }
    if (data.containsKey('km_prevu')) {
      context.handle(
        _kmPrevuMeta,
        kmPrevu.isAcceptableOrUnknown(data['km_prevu']!, _kmPrevuMeta),
      );
    }
    if (data.containsKey('date_prevue')) {
      context.handle(
        _datePrevueMeta,
        datePrevue.isAcceptableOrUnknown(data['date_prevue']!, _datePrevueMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    if (data.containsKey('date_effectue')) {
      context.handle(
        _dateEffectueMeta,
        dateEffectue.isAcceptableOrUnknown(
          data['date_effectue']!,
          _dateEffectueMeta,
        ),
      );
    }
    if (data.containsKey('cout')) {
      context.handle(
        _coutMeta,
        cout.isAcceptableOrUnknown(data['cout']!, _coutMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Maintenance map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Maintenance(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      vehiculeId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vehicule_id'],
      )!,
      type: $MaintenancesTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}type'],
        )!,
      ),
      kmPrevu: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}km_prevu'],
      ),
      datePrevue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_prevue'],
      ),
      statut: $MaintenancesTable.$converterstatut.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.int,
          data['${effectivePrefix}statut'],
        )!,
      ),
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
      dateEffectue: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}date_effectue'],
      ),
      cout: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}cout'],
      ),
    );
  }

  @override
  $MaintenancesTable createAlias(String alias) {
    return $MaintenancesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TypeMaintenance, int, int> $convertertype =
      const EnumIndexConverter<TypeMaintenance>(TypeMaintenance.values);
  static JsonTypeConverter2<StatutMaintenance, int, int> $converterstatut =
      const EnumIndexConverter<StatutMaintenance>(StatutMaintenance.values);
}

class Maintenance extends DataClass implements Insertable<Maintenance> {
  final String id;
  final String vehiculeId;
  final TypeMaintenance type;
  final double? kmPrevu;
  final DateTime? datePrevue;
  final StatutMaintenance statut;
  final String? notes;
  final DateTime? dateEffectue;
  final double? cout;
  const Maintenance({
    required this.id,
    required this.vehiculeId,
    required this.type,
    this.kmPrevu,
    this.datePrevue,
    required this.statut,
    this.notes,
    this.dateEffectue,
    this.cout,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['vehicule_id'] = Variable<String>(vehiculeId);
    {
      map['type'] = Variable<int>(
        $MaintenancesTable.$convertertype.toSql(type),
      );
    }
    if (!nullToAbsent || kmPrevu != null) {
      map['km_prevu'] = Variable<double>(kmPrevu);
    }
    if (!nullToAbsent || datePrevue != null) {
      map['date_prevue'] = Variable<DateTime>(datePrevue);
    }
    {
      map['statut'] = Variable<int>(
        $MaintenancesTable.$converterstatut.toSql(statut),
      );
    }
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    if (!nullToAbsent || dateEffectue != null) {
      map['date_effectue'] = Variable<DateTime>(dateEffectue);
    }
    if (!nullToAbsent || cout != null) {
      map['cout'] = Variable<double>(cout);
    }
    return map;
  }

  MaintenancesCompanion toCompanion(bool nullToAbsent) {
    return MaintenancesCompanion(
      id: Value(id),
      vehiculeId: Value(vehiculeId),
      type: Value(type),
      kmPrevu: kmPrevu == null && nullToAbsent
          ? const Value.absent()
          : Value(kmPrevu),
      datePrevue: datePrevue == null && nullToAbsent
          ? const Value.absent()
          : Value(datePrevue),
      statut: Value(statut),
      notes: notes == null && nullToAbsent
          ? const Value.absent()
          : Value(notes),
      dateEffectue: dateEffectue == null && nullToAbsent
          ? const Value.absent()
          : Value(dateEffectue),
      cout: cout == null && nullToAbsent ? const Value.absent() : Value(cout),
    );
  }

  factory Maintenance.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Maintenance(
      id: serializer.fromJson<String>(json['id']),
      vehiculeId: serializer.fromJson<String>(json['vehiculeId']),
      type: $MaintenancesTable.$convertertype.fromJson(
        serializer.fromJson<int>(json['type']),
      ),
      kmPrevu: serializer.fromJson<double?>(json['kmPrevu']),
      datePrevue: serializer.fromJson<DateTime?>(json['datePrevue']),
      statut: $MaintenancesTable.$converterstatut.fromJson(
        serializer.fromJson<int>(json['statut']),
      ),
      notes: serializer.fromJson<String?>(json['notes']),
      dateEffectue: serializer.fromJson<DateTime?>(json['dateEffectue']),
      cout: serializer.fromJson<double?>(json['cout']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'vehiculeId': serializer.toJson<String>(vehiculeId),
      'type': serializer.toJson<int>(
        $MaintenancesTable.$convertertype.toJson(type),
      ),
      'kmPrevu': serializer.toJson<double?>(kmPrevu),
      'datePrevue': serializer.toJson<DateTime?>(datePrevue),
      'statut': serializer.toJson<int>(
        $MaintenancesTable.$converterstatut.toJson(statut),
      ),
      'notes': serializer.toJson<String?>(notes),
      'dateEffectue': serializer.toJson<DateTime?>(dateEffectue),
      'cout': serializer.toJson<double?>(cout),
    };
  }

  Maintenance copyWith({
    String? id,
    String? vehiculeId,
    TypeMaintenance? type,
    Value<double?> kmPrevu = const Value.absent(),
    Value<DateTime?> datePrevue = const Value.absent(),
    StatutMaintenance? statut,
    Value<String?> notes = const Value.absent(),
    Value<DateTime?> dateEffectue = const Value.absent(),
    Value<double?> cout = const Value.absent(),
  }) => Maintenance(
    id: id ?? this.id,
    vehiculeId: vehiculeId ?? this.vehiculeId,
    type: type ?? this.type,
    kmPrevu: kmPrevu.present ? kmPrevu.value : this.kmPrevu,
    datePrevue: datePrevue.present ? datePrevue.value : this.datePrevue,
    statut: statut ?? this.statut,
    notes: notes.present ? notes.value : this.notes,
    dateEffectue: dateEffectue.present ? dateEffectue.value : this.dateEffectue,
    cout: cout.present ? cout.value : this.cout,
  );
  Maintenance copyWithCompanion(MaintenancesCompanion data) {
    return Maintenance(
      id: data.id.present ? data.id.value : this.id,
      vehiculeId: data.vehiculeId.present
          ? data.vehiculeId.value
          : this.vehiculeId,
      type: data.type.present ? data.type.value : this.type,
      kmPrevu: data.kmPrevu.present ? data.kmPrevu.value : this.kmPrevu,
      datePrevue: data.datePrevue.present
          ? data.datePrevue.value
          : this.datePrevue,
      statut: data.statut.present ? data.statut.value : this.statut,
      notes: data.notes.present ? data.notes.value : this.notes,
      dateEffectue: data.dateEffectue.present
          ? data.dateEffectue.value
          : this.dateEffectue,
      cout: data.cout.present ? data.cout.value : this.cout,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Maintenance(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('type: $type, ')
          ..write('kmPrevu: $kmPrevu, ')
          ..write('datePrevue: $datePrevue, ')
          ..write('statut: $statut, ')
          ..write('notes: $notes, ')
          ..write('dateEffectue: $dateEffectue, ')
          ..write('cout: $cout')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    vehiculeId,
    type,
    kmPrevu,
    datePrevue,
    statut,
    notes,
    dateEffectue,
    cout,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Maintenance &&
          other.id == this.id &&
          other.vehiculeId == this.vehiculeId &&
          other.type == this.type &&
          other.kmPrevu == this.kmPrevu &&
          other.datePrevue == this.datePrevue &&
          other.statut == this.statut &&
          other.notes == this.notes &&
          other.dateEffectue == this.dateEffectue &&
          other.cout == this.cout);
}

class MaintenancesCompanion extends UpdateCompanion<Maintenance> {
  final Value<String> id;
  final Value<String> vehiculeId;
  final Value<TypeMaintenance> type;
  final Value<double?> kmPrevu;
  final Value<DateTime?> datePrevue;
  final Value<StatutMaintenance> statut;
  final Value<String?> notes;
  final Value<DateTime?> dateEffectue;
  final Value<double?> cout;
  final Value<int> rowid;
  const MaintenancesCompanion({
    this.id = const Value.absent(),
    this.vehiculeId = const Value.absent(),
    this.type = const Value.absent(),
    this.kmPrevu = const Value.absent(),
    this.datePrevue = const Value.absent(),
    this.statut = const Value.absent(),
    this.notes = const Value.absent(),
    this.dateEffectue = const Value.absent(),
    this.cout = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MaintenancesCompanion.insert({
    required String id,
    required String vehiculeId,
    required TypeMaintenance type,
    this.kmPrevu = const Value.absent(),
    this.datePrevue = const Value.absent(),
    this.statut = const Value.absent(),
    this.notes = const Value.absent(),
    this.dateEffectue = const Value.absent(),
    this.cout = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       vehiculeId = Value(vehiculeId),
       type = Value(type);
  static Insertable<Maintenance> custom({
    Expression<String>? id,
    Expression<String>? vehiculeId,
    Expression<int>? type,
    Expression<double>? kmPrevu,
    Expression<DateTime>? datePrevue,
    Expression<int>? statut,
    Expression<String>? notes,
    Expression<DateTime>? dateEffectue,
    Expression<double>? cout,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (vehiculeId != null) 'vehicule_id': vehiculeId,
      if (type != null) 'type': type,
      if (kmPrevu != null) 'km_prevu': kmPrevu,
      if (datePrevue != null) 'date_prevue': datePrevue,
      if (statut != null) 'statut': statut,
      if (notes != null) 'notes': notes,
      if (dateEffectue != null) 'date_effectue': dateEffectue,
      if (cout != null) 'cout': cout,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MaintenancesCompanion copyWith({
    Value<String>? id,
    Value<String>? vehiculeId,
    Value<TypeMaintenance>? type,
    Value<double?>? kmPrevu,
    Value<DateTime?>? datePrevue,
    Value<StatutMaintenance>? statut,
    Value<String?>? notes,
    Value<DateTime?>? dateEffectue,
    Value<double?>? cout,
    Value<int>? rowid,
  }) {
    return MaintenancesCompanion(
      id: id ?? this.id,
      vehiculeId: vehiculeId ?? this.vehiculeId,
      type: type ?? this.type,
      kmPrevu: kmPrevu ?? this.kmPrevu,
      datePrevue: datePrevue ?? this.datePrevue,
      statut: statut ?? this.statut,
      notes: notes ?? this.notes,
      dateEffectue: dateEffectue ?? this.dateEffectue,
      cout: cout ?? this.cout,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (vehiculeId.present) {
      map['vehicule_id'] = Variable<String>(vehiculeId.value);
    }
    if (type.present) {
      map['type'] = Variable<int>(
        $MaintenancesTable.$convertertype.toSql(type.value),
      );
    }
    if (kmPrevu.present) {
      map['km_prevu'] = Variable<double>(kmPrevu.value);
    }
    if (datePrevue.present) {
      map['date_prevue'] = Variable<DateTime>(datePrevue.value);
    }
    if (statut.present) {
      map['statut'] = Variable<int>(
        $MaintenancesTable.$converterstatut.toSql(statut.value),
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (dateEffectue.present) {
      map['date_effectue'] = Variable<DateTime>(dateEffectue.value);
    }
    if (cout.present) {
      map['cout'] = Variable<double>(cout.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenancesCompanion(')
          ..write('id: $id, ')
          ..write('vehiculeId: $vehiculeId, ')
          ..write('type: $type, ')
          ..write('kmPrevu: $kmPrevu, ')
          ..write('datePrevue: $datePrevue, ')
          ..write('statut: $statut, ')
          ..write('notes: $notes, ')
          ..write('dateEffectue: $dateEffectue, ')
          ..write('cout: $cout, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ReglagesTable extends Reglages with TableInfo<$ReglagesTable, Reglage> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ReglagesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _nomMeta = const VerificationMeta('nom');
  @override
  late final GeneratedColumn<String> nom = GeneratedColumn<String>(
    'nom',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('Conducteur'),
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _deviseMeta = const VerificationMeta('devise');
  @override
  late final GeneratedColumn<String> devise = GeneratedColumn<String>(
    'devise',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('€'),
  );
  static const VerificationMeta _uniteDistanceMeta = const VerificationMeta(
    'uniteDistance',
  );
  @override
  late final GeneratedColumn<String> uniteDistance = GeneratedColumn<String>(
    'unite_distance',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('km'),
  );
  static const VerificationMeta _uniteVolumeMeta = const VerificationMeta(
    'uniteVolume',
  );
  @override
  late final GeneratedColumn<String> uniteVolume = GeneratedColumn<String>(
    'unite_volume',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('L'),
  );
  static const VerificationMeta _themeModeMeta = const VerificationMeta(
    'themeMode',
  );
  @override
  late final GeneratedColumn<int> themeMode = GeneratedColumn<int>(
    'theme_mode',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(2),
  );
  static const VerificationMeta _langueMeta = const VerificationMeta('langue');
  @override
  late final GeneratedColumn<String> langue = GeneratedColumn<String>(
    'langue',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('fr'),
  );
  static const VerificationMeta _seuilAlerteMeta = const VerificationMeta(
    'seuilAlerte',
  );
  @override
  late final GeneratedColumn<double> seuilAlerte = GeneratedColumn<double>(
    'seuil_alerte',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(20),
  );
  static const VerificationMeta _grandTexteMeta = const VerificationMeta(
    'grandTexte',
  );
  @override
  late final GeneratedColumn<bool> grandTexte = GeneratedColumn<bool>(
    'grand_texte',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("grand_texte" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _contrasteEleveMeta = const VerificationMeta(
    'contrasteEleve',
  );
  @override
  late final GeneratedColumn<bool> contrasteEleve = GeneratedColumn<bool>(
    'contraste_eleve',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("contraste_eleve" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nom,
    email,
    devise,
    uniteDistance,
    uniteVolume,
    themeMode,
    langue,
    seuilAlerte,
    grandTexte,
    contrasteEleve,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reglages';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reglage> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nom')) {
      context.handle(
        _nomMeta,
        nom.isAcceptableOrUnknown(data['nom']!, _nomMeta),
      );
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('devise')) {
      context.handle(
        _deviseMeta,
        devise.isAcceptableOrUnknown(data['devise']!, _deviseMeta),
      );
    }
    if (data.containsKey('unite_distance')) {
      context.handle(
        _uniteDistanceMeta,
        uniteDistance.isAcceptableOrUnknown(
          data['unite_distance']!,
          _uniteDistanceMeta,
        ),
      );
    }
    if (data.containsKey('unite_volume')) {
      context.handle(
        _uniteVolumeMeta,
        uniteVolume.isAcceptableOrUnknown(
          data['unite_volume']!,
          _uniteVolumeMeta,
        ),
      );
    }
    if (data.containsKey('theme_mode')) {
      context.handle(
        _themeModeMeta,
        themeMode.isAcceptableOrUnknown(data['theme_mode']!, _themeModeMeta),
      );
    }
    if (data.containsKey('langue')) {
      context.handle(
        _langueMeta,
        langue.isAcceptableOrUnknown(data['langue']!, _langueMeta),
      );
    }
    if (data.containsKey('seuil_alerte')) {
      context.handle(
        _seuilAlerteMeta,
        seuilAlerte.isAcceptableOrUnknown(
          data['seuil_alerte']!,
          _seuilAlerteMeta,
        ),
      );
    }
    if (data.containsKey('grand_texte')) {
      context.handle(
        _grandTexteMeta,
        grandTexte.isAcceptableOrUnknown(data['grand_texte']!, _grandTexteMeta),
      );
    }
    if (data.containsKey('contraste_eleve')) {
      context.handle(
        _contrasteEleveMeta,
        contrasteEleve.isAcceptableOrUnknown(
          data['contraste_eleve']!,
          _contrasteEleveMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reglage map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reglage(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nom: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nom'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      devise: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}devise'],
      )!,
      uniteDistance: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unite_distance'],
      )!,
      uniteVolume: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unite_volume'],
      )!,
      themeMode: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}theme_mode'],
      )!,
      langue: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}langue'],
      )!,
      seuilAlerte: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}seuil_alerte'],
      )!,
      grandTexte: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}grand_texte'],
      )!,
      contrasteEleve: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}contraste_eleve'],
      )!,
    );
  }

  @override
  $ReglagesTable createAlias(String alias) {
    return $ReglagesTable(attachedDatabase, alias);
  }
}

class Reglage extends DataClass implements Insertable<Reglage> {
  final int id;
  final String nom;
  final String? email;
  final String devise;
  final String uniteDistance;
  final String uniteVolume;
  final int themeMode;
  final String langue;
  final double seuilAlerte;
  final bool grandTexte;
  final bool contrasteEleve;
  const Reglage({
    required this.id,
    required this.nom,
    this.email,
    required this.devise,
    required this.uniteDistance,
    required this.uniteVolume,
    required this.themeMode,
    required this.langue,
    required this.seuilAlerte,
    required this.grandTexte,
    required this.contrasteEleve,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nom'] = Variable<String>(nom);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    map['devise'] = Variable<String>(devise);
    map['unite_distance'] = Variable<String>(uniteDistance);
    map['unite_volume'] = Variable<String>(uniteVolume);
    map['theme_mode'] = Variable<int>(themeMode);
    map['langue'] = Variable<String>(langue);
    map['seuil_alerte'] = Variable<double>(seuilAlerte);
    map['grand_texte'] = Variable<bool>(grandTexte);
    map['contraste_eleve'] = Variable<bool>(contrasteEleve);
    return map;
  }

  ReglagesCompanion toCompanion(bool nullToAbsent) {
    return ReglagesCompanion(
      id: Value(id),
      nom: Value(nom),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      devise: Value(devise),
      uniteDistance: Value(uniteDistance),
      uniteVolume: Value(uniteVolume),
      themeMode: Value(themeMode),
      langue: Value(langue),
      seuilAlerte: Value(seuilAlerte),
      grandTexte: Value(grandTexte),
      contrasteEleve: Value(contrasteEleve),
    );
  }

  factory Reglage.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reglage(
      id: serializer.fromJson<int>(json['id']),
      nom: serializer.fromJson<String>(json['nom']),
      email: serializer.fromJson<String?>(json['email']),
      devise: serializer.fromJson<String>(json['devise']),
      uniteDistance: serializer.fromJson<String>(json['uniteDistance']),
      uniteVolume: serializer.fromJson<String>(json['uniteVolume']),
      themeMode: serializer.fromJson<int>(json['themeMode']),
      langue: serializer.fromJson<String>(json['langue']),
      seuilAlerte: serializer.fromJson<double>(json['seuilAlerte']),
      grandTexte: serializer.fromJson<bool>(json['grandTexte']),
      contrasteEleve: serializer.fromJson<bool>(json['contrasteEleve']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nom': serializer.toJson<String>(nom),
      'email': serializer.toJson<String?>(email),
      'devise': serializer.toJson<String>(devise),
      'uniteDistance': serializer.toJson<String>(uniteDistance),
      'uniteVolume': serializer.toJson<String>(uniteVolume),
      'themeMode': serializer.toJson<int>(themeMode),
      'langue': serializer.toJson<String>(langue),
      'seuilAlerte': serializer.toJson<double>(seuilAlerte),
      'grandTexte': serializer.toJson<bool>(grandTexte),
      'contrasteEleve': serializer.toJson<bool>(contrasteEleve),
    };
  }

  Reglage copyWith({
    int? id,
    String? nom,
    Value<String?> email = const Value.absent(),
    String? devise,
    String? uniteDistance,
    String? uniteVolume,
    int? themeMode,
    String? langue,
    double? seuilAlerte,
    bool? grandTexte,
    bool? contrasteEleve,
  }) => Reglage(
    id: id ?? this.id,
    nom: nom ?? this.nom,
    email: email.present ? email.value : this.email,
    devise: devise ?? this.devise,
    uniteDistance: uniteDistance ?? this.uniteDistance,
    uniteVolume: uniteVolume ?? this.uniteVolume,
    themeMode: themeMode ?? this.themeMode,
    langue: langue ?? this.langue,
    seuilAlerte: seuilAlerte ?? this.seuilAlerte,
    grandTexte: grandTexte ?? this.grandTexte,
    contrasteEleve: contrasteEleve ?? this.contrasteEleve,
  );
  Reglage copyWithCompanion(ReglagesCompanion data) {
    return Reglage(
      id: data.id.present ? data.id.value : this.id,
      nom: data.nom.present ? data.nom.value : this.nom,
      email: data.email.present ? data.email.value : this.email,
      devise: data.devise.present ? data.devise.value : this.devise,
      uniteDistance: data.uniteDistance.present
          ? data.uniteDistance.value
          : this.uniteDistance,
      uniteVolume: data.uniteVolume.present
          ? data.uniteVolume.value
          : this.uniteVolume,
      themeMode: data.themeMode.present ? data.themeMode.value : this.themeMode,
      langue: data.langue.present ? data.langue.value : this.langue,
      seuilAlerte: data.seuilAlerte.present
          ? data.seuilAlerte.value
          : this.seuilAlerte,
      grandTexte: data.grandTexte.present
          ? data.grandTexte.value
          : this.grandTexte,
      contrasteEleve: data.contrasteEleve.present
          ? data.contrasteEleve.value
          : this.contrasteEleve,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reglage(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('email: $email, ')
          ..write('devise: $devise, ')
          ..write('uniteDistance: $uniteDistance, ')
          ..write('uniteVolume: $uniteVolume, ')
          ..write('themeMode: $themeMode, ')
          ..write('langue: $langue, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('grandTexte: $grandTexte, ')
          ..write('contrasteEleve: $contrasteEleve')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    nom,
    email,
    devise,
    uniteDistance,
    uniteVolume,
    themeMode,
    langue,
    seuilAlerte,
    grandTexte,
    contrasteEleve,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reglage &&
          other.id == this.id &&
          other.nom == this.nom &&
          other.email == this.email &&
          other.devise == this.devise &&
          other.uniteDistance == this.uniteDistance &&
          other.uniteVolume == this.uniteVolume &&
          other.themeMode == this.themeMode &&
          other.langue == this.langue &&
          other.seuilAlerte == this.seuilAlerte &&
          other.grandTexte == this.grandTexte &&
          other.contrasteEleve == this.contrasteEleve);
}

class ReglagesCompanion extends UpdateCompanion<Reglage> {
  final Value<int> id;
  final Value<String> nom;
  final Value<String?> email;
  final Value<String> devise;
  final Value<String> uniteDistance;
  final Value<String> uniteVolume;
  final Value<int> themeMode;
  final Value<String> langue;
  final Value<double> seuilAlerte;
  final Value<bool> grandTexte;
  final Value<bool> contrasteEleve;
  const ReglagesCompanion({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.email = const Value.absent(),
    this.devise = const Value.absent(),
    this.uniteDistance = const Value.absent(),
    this.uniteVolume = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.langue = const Value.absent(),
    this.seuilAlerte = const Value.absent(),
    this.grandTexte = const Value.absent(),
    this.contrasteEleve = const Value.absent(),
  });
  ReglagesCompanion.insert({
    this.id = const Value.absent(),
    this.nom = const Value.absent(),
    this.email = const Value.absent(),
    this.devise = const Value.absent(),
    this.uniteDistance = const Value.absent(),
    this.uniteVolume = const Value.absent(),
    this.themeMode = const Value.absent(),
    this.langue = const Value.absent(),
    this.seuilAlerte = const Value.absent(),
    this.grandTexte = const Value.absent(),
    this.contrasteEleve = const Value.absent(),
  });
  static Insertable<Reglage> custom({
    Expression<int>? id,
    Expression<String>? nom,
    Expression<String>? email,
    Expression<String>? devise,
    Expression<String>? uniteDistance,
    Expression<String>? uniteVolume,
    Expression<int>? themeMode,
    Expression<String>? langue,
    Expression<double>? seuilAlerte,
    Expression<bool>? grandTexte,
    Expression<bool>? contrasteEleve,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nom != null) 'nom': nom,
      if (email != null) 'email': email,
      if (devise != null) 'devise': devise,
      if (uniteDistance != null) 'unite_distance': uniteDistance,
      if (uniteVolume != null) 'unite_volume': uniteVolume,
      if (themeMode != null) 'theme_mode': themeMode,
      if (langue != null) 'langue': langue,
      if (seuilAlerte != null) 'seuil_alerte': seuilAlerte,
      if (grandTexte != null) 'grand_texte': grandTexte,
      if (contrasteEleve != null) 'contraste_eleve': contrasteEleve,
    });
  }

  ReglagesCompanion copyWith({
    Value<int>? id,
    Value<String>? nom,
    Value<String?>? email,
    Value<String>? devise,
    Value<String>? uniteDistance,
    Value<String>? uniteVolume,
    Value<int>? themeMode,
    Value<String>? langue,
    Value<double>? seuilAlerte,
    Value<bool>? grandTexte,
    Value<bool>? contrasteEleve,
  }) {
    return ReglagesCompanion(
      id: id ?? this.id,
      nom: nom ?? this.nom,
      email: email ?? this.email,
      devise: devise ?? this.devise,
      uniteDistance: uniteDistance ?? this.uniteDistance,
      uniteVolume: uniteVolume ?? this.uniteVolume,
      themeMode: themeMode ?? this.themeMode,
      langue: langue ?? this.langue,
      seuilAlerte: seuilAlerte ?? this.seuilAlerte,
      grandTexte: grandTexte ?? this.grandTexte,
      contrasteEleve: contrasteEleve ?? this.contrasteEleve,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nom.present) {
      map['nom'] = Variable<String>(nom.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (devise.present) {
      map['devise'] = Variable<String>(devise.value);
    }
    if (uniteDistance.present) {
      map['unite_distance'] = Variable<String>(uniteDistance.value);
    }
    if (uniteVolume.present) {
      map['unite_volume'] = Variable<String>(uniteVolume.value);
    }
    if (themeMode.present) {
      map['theme_mode'] = Variable<int>(themeMode.value);
    }
    if (langue.present) {
      map['langue'] = Variable<String>(langue.value);
    }
    if (seuilAlerte.present) {
      map['seuil_alerte'] = Variable<double>(seuilAlerte.value);
    }
    if (grandTexte.present) {
      map['grand_texte'] = Variable<bool>(grandTexte.value);
    }
    if (contrasteEleve.present) {
      map['contraste_eleve'] = Variable<bool>(contrasteEleve.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ReglagesCompanion(')
          ..write('id: $id, ')
          ..write('nom: $nom, ')
          ..write('email: $email, ')
          ..write('devise: $devise, ')
          ..write('uniteDistance: $uniteDistance, ')
          ..write('uniteVolume: $uniteVolume, ')
          ..write('themeMode: $themeMode, ')
          ..write('langue: $langue, ')
          ..write('seuilAlerte: $seuilAlerte, ')
          ..write('grandTexte: $grandTexte, ')
          ..write('contrasteEleve: $contrasteEleve')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $VehiculesTable vehicules = $VehiculesTable(this);
  late final $PleinsTable pleins = $PleinsTable(this);
  late final $DepensesTable depenses = $DepensesTable(this);
  late final $MaintenancesTable maintenances = $MaintenancesTable(this);
  late final $ReglagesTable reglages = $ReglagesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    vehicules,
    pleins,
    depenses,
    maintenances,
    reglages,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('pleins', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('depenses', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'vehicules',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenances', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$VehiculesTableCreateCompanionBuilder =
    VehiculesCompanion Function({
      required String id,
      required String marque,
      required String modele,
      required int annee,
      Value<String?> plaque,
      required TypeCarburant typeCarburant,
      Value<double> kmInitial,
      Value<String?> photo,
      required DateTime dateAjout,
      Value<bool> parDefaut,
      Value<int> rowid,
    });
typedef $$VehiculesTableUpdateCompanionBuilder =
    VehiculesCompanion Function({
      Value<String> id,
      Value<String> marque,
      Value<String> modele,
      Value<int> annee,
      Value<String?> plaque,
      Value<TypeCarburant> typeCarburant,
      Value<double> kmInitial,
      Value<String?> photo,
      Value<DateTime> dateAjout,
      Value<bool> parDefaut,
      Value<int> rowid,
    });

final class $$VehiculesTableReferences
    extends BaseReferences<_$AppDatabase, $VehiculesTable, Vehicule> {
  $$VehiculesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$PleinsTable, List<Plein>> _pleinsRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.pleins,
    aliasName: $_aliasNameGenerator(db.vehicules.id, db.pleins.vehiculeId),
  );

  $$PleinsTableProcessedTableManager get pleinsRefs {
    final manager = $$PleinsTableTableManager(
      $_db,
      $_db.pleins,
    ).filter((f) => f.vehiculeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_pleinsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$DepensesTable, List<Depense>> _depensesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.depenses,
    aliasName: $_aliasNameGenerator(db.vehicules.id, db.depenses.vehiculeId),
  );

  $$DepensesTableProcessedTableManager get depensesRefs {
    final manager = $$DepensesTableTableManager(
      $_db,
      $_db.depenses,
    ).filter((f) => f.vehiculeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_depensesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$MaintenancesTable, List<Maintenance>>
  _maintenancesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenances,
    aliasName: $_aliasNameGenerator(
      db.vehicules.id,
      db.maintenances.vehiculeId,
    ),
  );

  $$MaintenancesTableProcessedTableManager get maintenancesRefs {
    final manager = $$MaintenancesTableTableManager(
      $_db,
      $_db.maintenances,
    ).filter((f) => f.vehiculeId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_maintenancesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$VehiculesTableFilterComposer
    extends Composer<_$AppDatabase, $VehiculesTable> {
  $$VehiculesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marque => $composableBuilder(
    column: $table.marque,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modele => $composableBuilder(
    column: $table.modele,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get annee => $composableBuilder(
    column: $table.annee,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get plaque => $composableBuilder(
    column: $table.plaque,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TypeCarburant, TypeCarburant, int>
  get typeCarburant => $composableBuilder(
    column: $table.typeCarburant,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get kmInitial => $composableBuilder(
    column: $table.kmInitial,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateAjout => $composableBuilder(
    column: $table.dateAjout,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get parDefaut => $composableBuilder(
    column: $table.parDefaut,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> pleinsRefs(
    Expression<bool> Function($$PleinsTableFilterComposer f) f,
  ) {
    final $$PleinsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pleins,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PleinsTableFilterComposer(
            $db: $db,
            $table: $db.pleins,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> depensesRefs(
    Expression<bool> Function($$DepensesTableFilterComposer f) f,
  ) {
    final $$DepensesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.depenses,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepensesTableFilterComposer(
            $db: $db,
            $table: $db.depenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> maintenancesRefs(
    Expression<bool> Function($$MaintenancesTableFilterComposer f) f,
  ) {
    final $$MaintenancesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableFilterComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculesTableOrderingComposer
    extends Composer<_$AppDatabase, $VehiculesTable> {
  $$VehiculesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marque => $composableBuilder(
    column: $table.marque,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modele => $composableBuilder(
    column: $table.modele,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get annee => $composableBuilder(
    column: $table.annee,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get plaque => $composableBuilder(
    column: $table.plaque,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typeCarburant => $composableBuilder(
    column: $table.typeCarburant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kmInitial => $composableBuilder(
    column: $table.kmInitial,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateAjout => $composableBuilder(
    column: $table.dateAjout,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get parDefaut => $composableBuilder(
    column: $table.parDefaut,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$VehiculesTableAnnotationComposer
    extends Composer<_$AppDatabase, $VehiculesTable> {
  $$VehiculesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get marque =>
      $composableBuilder(column: $table.marque, builder: (column) => column);

  GeneratedColumn<String> get modele =>
      $composableBuilder(column: $table.modele, builder: (column) => column);

  GeneratedColumn<int> get annee =>
      $composableBuilder(column: $table.annee, builder: (column) => column);

  GeneratedColumn<String> get plaque =>
      $composableBuilder(column: $table.plaque, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TypeCarburant, int> get typeCarburant =>
      $composableBuilder(
        column: $table.typeCarburant,
        builder: (column) => column,
      );

  GeneratedColumn<double> get kmInitial =>
      $composableBuilder(column: $table.kmInitial, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumn<DateTime> get dateAjout =>
      $composableBuilder(column: $table.dateAjout, builder: (column) => column);

  GeneratedColumn<bool> get parDefaut =>
      $composableBuilder(column: $table.parDefaut, builder: (column) => column);

  Expression<T> pleinsRefs<T extends Object>(
    Expression<T> Function($$PleinsTableAnnotationComposer a) f,
  ) {
    final $$PleinsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.pleins,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$PleinsTableAnnotationComposer(
            $db: $db,
            $table: $db.pleins,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> depensesRefs<T extends Object>(
    Expression<T> Function($$DepensesTableAnnotationComposer a) f,
  ) {
    final $$DepensesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.depenses,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$DepensesTableAnnotationComposer(
            $db: $db,
            $table: $db.depenses,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> maintenancesRefs<T extends Object>(
    Expression<T> Function($$MaintenancesTableAnnotationComposer a) f,
  ) {
    final $$MaintenancesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenances,
      getReferencedColumn: (t) => t.vehiculeId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenancesTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenances,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$VehiculesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $VehiculesTable,
          Vehicule,
          $$VehiculesTableFilterComposer,
          $$VehiculesTableOrderingComposer,
          $$VehiculesTableAnnotationComposer,
          $$VehiculesTableCreateCompanionBuilder,
          $$VehiculesTableUpdateCompanionBuilder,
          (Vehicule, $$VehiculesTableReferences),
          Vehicule,
          PrefetchHooks Function({
            bool pleinsRefs,
            bool depensesRefs,
            bool maintenancesRefs,
          })
        > {
  $$VehiculesTableTableManager(_$AppDatabase db, $VehiculesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$VehiculesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$VehiculesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$VehiculesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> marque = const Value.absent(),
                Value<String> modele = const Value.absent(),
                Value<int> annee = const Value.absent(),
                Value<String?> plaque = const Value.absent(),
                Value<TypeCarburant> typeCarburant = const Value.absent(),
                Value<double> kmInitial = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<DateTime> dateAjout = const Value.absent(),
                Value<bool> parDefaut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiculesCompanion(
                id: id,
                marque: marque,
                modele: modele,
                annee: annee,
                plaque: plaque,
                typeCarburant: typeCarburant,
                kmInitial: kmInitial,
                photo: photo,
                dateAjout: dateAjout,
                parDefaut: parDefaut,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String marque,
                required String modele,
                required int annee,
                Value<String?> plaque = const Value.absent(),
                required TypeCarburant typeCarburant,
                Value<double> kmInitial = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                required DateTime dateAjout,
                Value<bool> parDefaut = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => VehiculesCompanion.insert(
                id: id,
                marque: marque,
                modele: modele,
                annee: annee,
                plaque: plaque,
                typeCarburant: typeCarburant,
                kmInitial: kmInitial,
                photo: photo,
                dateAjout: dateAjout,
                parDefaut: parDefaut,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$VehiculesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                pleinsRefs = false,
                depensesRefs = false,
                maintenancesRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (pleinsRefs) db.pleins,
                    if (depensesRefs) db.depenses,
                    if (maintenancesRefs) db.maintenances,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (pleinsRefs)
                        await $_getPrefetchedData<
                          Vehicule,
                          $VehiculesTable,
                          Plein
                        >(
                          currentTable: table,
                          referencedTable: $$VehiculesTableReferences
                              ._pleinsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiculesTableReferences(
                                db,
                                table,
                                p0,
                              ).pleinsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehiculeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (depensesRefs)
                        await $_getPrefetchedData<
                          Vehicule,
                          $VehiculesTable,
                          Depense
                        >(
                          currentTable: table,
                          referencedTable: $$VehiculesTableReferences
                              ._depensesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiculesTableReferences(
                                db,
                                table,
                                p0,
                              ).depensesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehiculeId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (maintenancesRefs)
                        await $_getPrefetchedData<
                          Vehicule,
                          $VehiculesTable,
                          Maintenance
                        >(
                          currentTable: table,
                          referencedTable: $$VehiculesTableReferences
                              ._maintenancesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$VehiculesTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenancesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.vehiculeId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$VehiculesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $VehiculesTable,
      Vehicule,
      $$VehiculesTableFilterComposer,
      $$VehiculesTableOrderingComposer,
      $$VehiculesTableAnnotationComposer,
      $$VehiculesTableCreateCompanionBuilder,
      $$VehiculesTableUpdateCompanionBuilder,
      (Vehicule, $$VehiculesTableReferences),
      Vehicule,
      PrefetchHooks Function({
        bool pleinsRefs,
        bool depensesRefs,
        bool maintenancesRefs,
      })
    >;
typedef $$PleinsTableCreateCompanionBuilder =
    PleinsCompanion Function({
      required String id,
      required String vehiculeId,
      required DateTime date,
      required double odometre,
      required double volume,
      required double prixUnitaire,
      required double prixTotal,
      Value<String?> station,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> photo,
      Value<TypePlein> typePlein,
      Value<int> rowid,
    });
typedef $$PleinsTableUpdateCompanionBuilder =
    PleinsCompanion Function({
      Value<String> id,
      Value<String> vehiculeId,
      Value<DateTime> date,
      Value<double> odometre,
      Value<double> volume,
      Value<double> prixUnitaire,
      Value<double> prixTotal,
      Value<String?> station,
      Value<double?> latitude,
      Value<double?> longitude,
      Value<String?> notes,
      Value<String?> photo,
      Value<TypePlein> typePlein,
      Value<int> rowid,
    });

final class $$PleinsTableReferences
    extends BaseReferences<_$AppDatabase, $PleinsTable, Plein> {
  $$PleinsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiculesTable _vehiculeIdTable(_$AppDatabase db) => db.vehicules
      .createAlias($_aliasNameGenerator(db.pleins.vehiculeId, db.vehicules.id));

  $$VehiculesTableProcessedTableManager get vehiculeId {
    final $_column = $_itemColumn<String>('vehicule_id')!;

    final manager = $$VehiculesTableTableManager(
      $_db,
      $_db.vehicules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$PleinsTableFilterComposer
    extends Composer<_$AppDatabase, $PleinsTable> {
  $$PleinsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get odometre => $composableBuilder(
    column: $table.odometre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get prixTotal => $composableBuilder(
    column: $table.prixTotal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TypePlein, TypePlein, int> get typePlein =>
      $composableBuilder(
        column: $table.typePlein,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  $$VehiculesTableFilterComposer get vehiculeId {
    final $$VehiculesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableFilterComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PleinsTableOrderingComposer
    extends Composer<_$AppDatabase, $PleinsTable> {
  $$PleinsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get odometre => $composableBuilder(
    column: $table.odometre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get volume => $composableBuilder(
    column: $table.volume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get prixTotal => $composableBuilder(
    column: $table.prixTotal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get station => $composableBuilder(
    column: $table.station,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get latitude => $composableBuilder(
    column: $table.latitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get longitude => $composableBuilder(
    column: $table.longitude,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get typePlein => $composableBuilder(
    column: $table.typePlein,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiculesTableOrderingComposer get vehiculeId {
    final $$VehiculesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PleinsTableAnnotationComposer
    extends Composer<_$AppDatabase, $PleinsTable> {
  $$PleinsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get odometre =>
      $composableBuilder(column: $table.odometre, builder: (column) => column);

  GeneratedColumn<double> get volume =>
      $composableBuilder(column: $table.volume, builder: (column) => column);

  GeneratedColumn<double> get prixUnitaire => $composableBuilder(
    column: $table.prixUnitaire,
    builder: (column) => column,
  );

  GeneratedColumn<double> get prixTotal =>
      $composableBuilder(column: $table.prixTotal, builder: (column) => column);

  GeneratedColumn<String> get station =>
      $composableBuilder(column: $table.station, builder: (column) => column);

  GeneratedColumn<double> get latitude =>
      $composableBuilder(column: $table.latitude, builder: (column) => column);

  GeneratedColumn<double> get longitude =>
      $composableBuilder(column: $table.longitude, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TypePlein, int> get typePlein =>
      $composableBuilder(column: $table.typePlein, builder: (column) => column);

  $$VehiculesTableAnnotationComposer get vehiculeId {
    final $$VehiculesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$PleinsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $PleinsTable,
          Plein,
          $$PleinsTableFilterComposer,
          $$PleinsTableOrderingComposer,
          $$PleinsTableAnnotationComposer,
          $$PleinsTableCreateCompanionBuilder,
          $$PleinsTableUpdateCompanionBuilder,
          (Plein, $$PleinsTableReferences),
          Plein,
          PrefetchHooks Function({bool vehiculeId})
        > {
  $$PleinsTableTableManager(_$AppDatabase db, $PleinsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$PleinsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$PleinsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$PleinsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehiculeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> odometre = const Value.absent(),
                Value<double> volume = const Value.absent(),
                Value<double> prixUnitaire = const Value.absent(),
                Value<double> prixTotal = const Value.absent(),
                Value<String?> station = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<TypePlein> typePlein = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PleinsCompanion(
                id: id,
                vehiculeId: vehiculeId,
                date: date,
                odometre: odometre,
                volume: volume,
                prixUnitaire: prixUnitaire,
                prixTotal: prixTotal,
                station: station,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                photo: photo,
                typePlein: typePlein,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehiculeId,
                required DateTime date,
                required double odometre,
                required double volume,
                required double prixUnitaire,
                required double prixTotal,
                Value<String?> station = const Value.absent(),
                Value<double?> latitude = const Value.absent(),
                Value<double?> longitude = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<TypePlein> typePlein = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PleinsCompanion.insert(
                id: id,
                vehiculeId: vehiculeId,
                date: date,
                odometre: odometre,
                volume: volume,
                prixUnitaire: prixUnitaire,
                prixTotal: prixTotal,
                station: station,
                latitude: latitude,
                longitude: longitude,
                notes: notes,
                photo: photo,
                typePlein: typePlein,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$PleinsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({vehiculeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehiculeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehiculeId,
                                referencedTable: $$PleinsTableReferences
                                    ._vehiculeIdTable(db),
                                referencedColumn: $$PleinsTableReferences
                                    ._vehiculeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$PleinsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $PleinsTable,
      Plein,
      $$PleinsTableFilterComposer,
      $$PleinsTableOrderingComposer,
      $$PleinsTableAnnotationComposer,
      $$PleinsTableCreateCompanionBuilder,
      $$PleinsTableUpdateCompanionBuilder,
      (Plein, $$PleinsTableReferences),
      Plein,
      PrefetchHooks Function({bool vehiculeId})
    >;
typedef $$DepensesTableCreateCompanionBuilder =
    DepensesCompanion Function({
      required String id,
      required String vehiculeId,
      required DateTime date,
      required double montant,
      required CategorieDepense categorie,
      Value<String?> description,
      Value<String?> photo,
      Value<int> rowid,
    });
typedef $$DepensesTableUpdateCompanionBuilder =
    DepensesCompanion Function({
      Value<String> id,
      Value<String> vehiculeId,
      Value<DateTime> date,
      Value<double> montant,
      Value<CategorieDepense> categorie,
      Value<String?> description,
      Value<String?> photo,
      Value<int> rowid,
    });

final class $$DepensesTableReferences
    extends BaseReferences<_$AppDatabase, $DepensesTable, Depense> {
  $$DepensesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiculesTable _vehiculeIdTable(_$AppDatabase db) =>
      db.vehicules.createAlias(
        $_aliasNameGenerator(db.depenses.vehiculeId, db.vehicules.id),
      );

  $$VehiculesTableProcessedTableManager get vehiculeId {
    final $_column = $_itemColumn<String>('vehicule_id')!;

    final manager = $$VehiculesTableTableManager(
      $_db,
      $_db.vehicules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$DepensesTableFilterComposer
    extends Composer<_$AppDatabase, $DepensesTable> {
  $$DepensesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get montant => $composableBuilder(
    column: $table.montant,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<CategorieDepense, CategorieDepense, int>
  get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiculesTableFilterComposer get vehiculeId {
    final $$VehiculesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableFilterComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepensesTableOrderingComposer
    extends Composer<_$AppDatabase, $DepensesTable> {
  $$DepensesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get date => $composableBuilder(
    column: $table.date,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get montant => $composableBuilder(
    column: $table.montant,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get categorie => $composableBuilder(
    column: $table.categorie,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photo => $composableBuilder(
    column: $table.photo,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiculesTableOrderingComposer get vehiculeId {
    final $$VehiculesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepensesTableAnnotationComposer
    extends Composer<_$AppDatabase, $DepensesTable> {
  $$DepensesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get date =>
      $composableBuilder(column: $table.date, builder: (column) => column);

  GeneratedColumn<double> get montant =>
      $composableBuilder(column: $table.montant, builder: (column) => column);

  GeneratedColumnWithTypeConverter<CategorieDepense, int> get categorie =>
      $composableBuilder(column: $table.categorie, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photo =>
      $composableBuilder(column: $table.photo, builder: (column) => column);

  $$VehiculesTableAnnotationComposer get vehiculeId {
    final $$VehiculesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$DepensesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DepensesTable,
          Depense,
          $$DepensesTableFilterComposer,
          $$DepensesTableOrderingComposer,
          $$DepensesTableAnnotationComposer,
          $$DepensesTableCreateCompanionBuilder,
          $$DepensesTableUpdateCompanionBuilder,
          (Depense, $$DepensesTableReferences),
          Depense,
          PrefetchHooks Function({bool vehiculeId})
        > {
  $$DepensesTableTableManager(_$AppDatabase db, $DepensesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DepensesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DepensesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DepensesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehiculeId = const Value.absent(),
                Value<DateTime> date = const Value.absent(),
                Value<double> montant = const Value.absent(),
                Value<CategorieDepense> categorie = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepensesCompanion(
                id: id,
                vehiculeId: vehiculeId,
                date: date,
                montant: montant,
                categorie: categorie,
                description: description,
                photo: photo,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehiculeId,
                required DateTime date,
                required double montant,
                required CategorieDepense categorie,
                Value<String?> description = const Value.absent(),
                Value<String?> photo = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DepensesCompanion.insert(
                id: id,
                vehiculeId: vehiculeId,
                date: date,
                montant: montant,
                categorie: categorie,
                description: description,
                photo: photo,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$DepensesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehiculeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehiculeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehiculeId,
                                referencedTable: $$DepensesTableReferences
                                    ._vehiculeIdTable(db),
                                referencedColumn: $$DepensesTableReferences
                                    ._vehiculeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$DepensesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DepensesTable,
      Depense,
      $$DepensesTableFilterComposer,
      $$DepensesTableOrderingComposer,
      $$DepensesTableAnnotationComposer,
      $$DepensesTableCreateCompanionBuilder,
      $$DepensesTableUpdateCompanionBuilder,
      (Depense, $$DepensesTableReferences),
      Depense,
      PrefetchHooks Function({bool vehiculeId})
    >;
typedef $$MaintenancesTableCreateCompanionBuilder =
    MaintenancesCompanion Function({
      required String id,
      required String vehiculeId,
      required TypeMaintenance type,
      Value<double?> kmPrevu,
      Value<DateTime?> datePrevue,
      Value<StatutMaintenance> statut,
      Value<String?> notes,
      Value<DateTime?> dateEffectue,
      Value<double?> cout,
      Value<int> rowid,
    });
typedef $$MaintenancesTableUpdateCompanionBuilder =
    MaintenancesCompanion Function({
      Value<String> id,
      Value<String> vehiculeId,
      Value<TypeMaintenance> type,
      Value<double?> kmPrevu,
      Value<DateTime?> datePrevue,
      Value<StatutMaintenance> statut,
      Value<String?> notes,
      Value<DateTime?> dateEffectue,
      Value<double?> cout,
      Value<int> rowid,
    });

final class $$MaintenancesTableReferences
    extends BaseReferences<_$AppDatabase, $MaintenancesTable, Maintenance> {
  $$MaintenancesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $VehiculesTable _vehiculeIdTable(_$AppDatabase db) =>
      db.vehicules.createAlias(
        $_aliasNameGenerator(db.maintenances.vehiculeId, db.vehicules.id),
      );

  $$VehiculesTableProcessedTableManager get vehiculeId {
    final $_column = $_itemColumn<String>('vehicule_id')!;

    final manager = $$VehiculesTableTableManager(
      $_db,
      $_db.vehicules,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_vehiculeIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenancesTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<TypeMaintenance, TypeMaintenance, int>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<double> get kmPrevu => $composableBuilder(
    column: $table.kmPrevu,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get datePrevue => $composableBuilder(
    column: $table.datePrevue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<StatutMaintenance, StatutMaintenance, int>
  get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get dateEffectue => $composableBuilder(
    column: $table.dateEffectue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get cout => $composableBuilder(
    column: $table.cout,
    builder: (column) => ColumnFilters(column),
  );

  $$VehiculesTableFilterComposer get vehiculeId {
    final $$VehiculesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableFilterComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get kmPrevu => $composableBuilder(
    column: $table.kmPrevu,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get datePrevue => $composableBuilder(
    column: $table.datePrevue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get statut => $composableBuilder(
    column: $table.statut,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get dateEffectue => $composableBuilder(
    column: $table.dateEffectue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get cout => $composableBuilder(
    column: $table.cout,
    builder: (column) => ColumnOrderings(column),
  );

  $$VehiculesTableOrderingComposer get vehiculeId {
    final $$VehiculesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableOrderingComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenancesTable> {
  $$MaintenancesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TypeMaintenance, int> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<double> get kmPrevu =>
      $composableBuilder(column: $table.kmPrevu, builder: (column) => column);

  GeneratedColumn<DateTime> get datePrevue => $composableBuilder(
    column: $table.datePrevue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<StatutMaintenance, int> get statut =>
      $composableBuilder(column: $table.statut, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);

  GeneratedColumn<DateTime> get dateEffectue => $composableBuilder(
    column: $table.dateEffectue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get cout =>
      $composableBuilder(column: $table.cout, builder: (column) => column);

  $$VehiculesTableAnnotationComposer get vehiculeId {
    final $$VehiculesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.vehiculeId,
      referencedTable: $db.vehicules,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$VehiculesTableAnnotationComposer(
            $db: $db,
            $table: $db.vehicules,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenancesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenancesTable,
          Maintenance,
          $$MaintenancesTableFilterComposer,
          $$MaintenancesTableOrderingComposer,
          $$MaintenancesTableAnnotationComposer,
          $$MaintenancesTableCreateCompanionBuilder,
          $$MaintenancesTableUpdateCompanionBuilder,
          (Maintenance, $$MaintenancesTableReferences),
          Maintenance,
          PrefetchHooks Function({bool vehiculeId})
        > {
  $$MaintenancesTableTableManager(_$AppDatabase db, $MaintenancesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenancesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenancesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenancesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> vehiculeId = const Value.absent(),
                Value<TypeMaintenance> type = const Value.absent(),
                Value<double?> kmPrevu = const Value.absent(),
                Value<DateTime?> datePrevue = const Value.absent(),
                Value<StatutMaintenance> statut = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> dateEffectue = const Value.absent(),
                Value<double?> cout = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenancesCompanion(
                id: id,
                vehiculeId: vehiculeId,
                type: type,
                kmPrevu: kmPrevu,
                datePrevue: datePrevue,
                statut: statut,
                notes: notes,
                dateEffectue: dateEffectue,
                cout: cout,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String vehiculeId,
                required TypeMaintenance type,
                Value<double?> kmPrevu = const Value.absent(),
                Value<DateTime?> datePrevue = const Value.absent(),
                Value<StatutMaintenance> statut = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<DateTime?> dateEffectue = const Value.absent(),
                Value<double?> cout = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MaintenancesCompanion.insert(
                id: id,
                vehiculeId: vehiculeId,
                type: type,
                kmPrevu: kmPrevu,
                datePrevue: datePrevue,
                statut: statut,
                notes: notes,
                dateEffectue: dateEffectue,
                cout: cout,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenancesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({vehiculeId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (vehiculeId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.vehiculeId,
                                referencedTable: $$MaintenancesTableReferences
                                    ._vehiculeIdTable(db),
                                referencedColumn: $$MaintenancesTableReferences
                                    ._vehiculeIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenancesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenancesTable,
      Maintenance,
      $$MaintenancesTableFilterComposer,
      $$MaintenancesTableOrderingComposer,
      $$MaintenancesTableAnnotationComposer,
      $$MaintenancesTableCreateCompanionBuilder,
      $$MaintenancesTableUpdateCompanionBuilder,
      (Maintenance, $$MaintenancesTableReferences),
      Maintenance,
      PrefetchHooks Function({bool vehiculeId})
    >;
typedef $$ReglagesTableCreateCompanionBuilder =
    ReglagesCompanion Function({
      Value<int> id,
      Value<String> nom,
      Value<String?> email,
      Value<String> devise,
      Value<String> uniteDistance,
      Value<String> uniteVolume,
      Value<int> themeMode,
      Value<String> langue,
      Value<double> seuilAlerte,
      Value<bool> grandTexte,
      Value<bool> contrasteEleve,
    });
typedef $$ReglagesTableUpdateCompanionBuilder =
    ReglagesCompanion Function({
      Value<int> id,
      Value<String> nom,
      Value<String?> email,
      Value<String> devise,
      Value<String> uniteDistance,
      Value<String> uniteVolume,
      Value<int> themeMode,
      Value<String> langue,
      Value<double> seuilAlerte,
      Value<bool> grandTexte,
      Value<bool> contrasteEleve,
    });

class $$ReglagesTableFilterComposer
    extends Composer<_$AppDatabase, $ReglagesTable> {
  $$ReglagesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get devise => $composableBuilder(
    column: $table.devise,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uniteDistance => $composableBuilder(
    column: $table.uniteDistance,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uniteVolume => $composableBuilder(
    column: $table.uniteVolume,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get grandTexte => $composableBuilder(
    column: $table.grandTexte,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get contrasteEleve => $composableBuilder(
    column: $table.contrasteEleve,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ReglagesTableOrderingComposer
    extends Composer<_$AppDatabase, $ReglagesTable> {
  $$ReglagesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nom => $composableBuilder(
    column: $table.nom,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get devise => $composableBuilder(
    column: $table.devise,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uniteDistance => $composableBuilder(
    column: $table.uniteDistance,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uniteVolume => $composableBuilder(
    column: $table.uniteVolume,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get themeMode => $composableBuilder(
    column: $table.themeMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get langue => $composableBuilder(
    column: $table.langue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get grandTexte => $composableBuilder(
    column: $table.grandTexte,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get contrasteEleve => $composableBuilder(
    column: $table.contrasteEleve,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ReglagesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ReglagesTable> {
  $$ReglagesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nom =>
      $composableBuilder(column: $table.nom, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get devise =>
      $composableBuilder(column: $table.devise, builder: (column) => column);

  GeneratedColumn<String> get uniteDistance => $composableBuilder(
    column: $table.uniteDistance,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uniteVolume => $composableBuilder(
    column: $table.uniteVolume,
    builder: (column) => column,
  );

  GeneratedColumn<int> get themeMode =>
      $composableBuilder(column: $table.themeMode, builder: (column) => column);

  GeneratedColumn<String> get langue =>
      $composableBuilder(column: $table.langue, builder: (column) => column);

  GeneratedColumn<double> get seuilAlerte => $composableBuilder(
    column: $table.seuilAlerte,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get grandTexte => $composableBuilder(
    column: $table.grandTexte,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get contrasteEleve => $composableBuilder(
    column: $table.contrasteEleve,
    builder: (column) => column,
  );
}

class $$ReglagesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ReglagesTable,
          Reglage,
          $$ReglagesTableFilterComposer,
          $$ReglagesTableOrderingComposer,
          $$ReglagesTableAnnotationComposer,
          $$ReglagesTableCreateCompanionBuilder,
          $$ReglagesTableUpdateCompanionBuilder,
          (Reglage, BaseReferences<_$AppDatabase, $ReglagesTable, Reglage>),
          Reglage,
          PrefetchHooks Function()
        > {
  $$ReglagesTableTableManager(_$AppDatabase db, $ReglagesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ReglagesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ReglagesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ReglagesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> devise = const Value.absent(),
                Value<String> uniteDistance = const Value.absent(),
                Value<String> uniteVolume = const Value.absent(),
                Value<int> themeMode = const Value.absent(),
                Value<String> langue = const Value.absent(),
                Value<double> seuilAlerte = const Value.absent(),
                Value<bool> grandTexte = const Value.absent(),
                Value<bool> contrasteEleve = const Value.absent(),
              }) => ReglagesCompanion(
                id: id,
                nom: nom,
                email: email,
                devise: devise,
                uniteDistance: uniteDistance,
                uniteVolume: uniteVolume,
                themeMode: themeMode,
                langue: langue,
                seuilAlerte: seuilAlerte,
                grandTexte: grandTexte,
                contrasteEleve: contrasteEleve,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nom = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String> devise = const Value.absent(),
                Value<String> uniteDistance = const Value.absent(),
                Value<String> uniteVolume = const Value.absent(),
                Value<int> themeMode = const Value.absent(),
                Value<String> langue = const Value.absent(),
                Value<double> seuilAlerte = const Value.absent(),
                Value<bool> grandTexte = const Value.absent(),
                Value<bool> contrasteEleve = const Value.absent(),
              }) => ReglagesCompanion.insert(
                id: id,
                nom: nom,
                email: email,
                devise: devise,
                uniteDistance: uniteDistance,
                uniteVolume: uniteVolume,
                themeMode: themeMode,
                langue: langue,
                seuilAlerte: seuilAlerte,
                grandTexte: grandTexte,
                contrasteEleve: contrasteEleve,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ReglagesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ReglagesTable,
      Reglage,
      $$ReglagesTableFilterComposer,
      $$ReglagesTableOrderingComposer,
      $$ReglagesTableAnnotationComposer,
      $$ReglagesTableCreateCompanionBuilder,
      $$ReglagesTableUpdateCompanionBuilder,
      (Reglage, BaseReferences<_$AppDatabase, $ReglagesTable, Reglage>),
      Reglage,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$VehiculesTableTableManager get vehicules =>
      $$VehiculesTableTableManager(_db, _db.vehicules);
  $$PleinsTableTableManager get pleins =>
      $$PleinsTableTableManager(_db, _db.pleins);
  $$DepensesTableTableManager get depenses =>
      $$DepensesTableTableManager(_db, _db.depenses);
  $$MaintenancesTableTableManager get maintenances =>
      $$MaintenancesTableTableManager(_db, _db.maintenances);
  $$ReglagesTableTableManager get reglages =>
      $$ReglagesTableTableManager(_db, _db.reglages);
}
