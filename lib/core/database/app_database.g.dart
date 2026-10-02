// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $UserProfilesTable extends UserProfiles
    with TableInfo<$UserProfilesTable, UserProfile> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _intentionMeta = const VerificationMeta(
    'intention',
  );
  @override
  late final GeneratedColumn<String> intention = GeneratedColumn<String>(
    'intention',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _avatarColorMeta = const VerificationMeta(
    'avatarColor',
  );
  @override
  late final GeneratedColumn<int> avatarColor = GeneratedColumn<int>(
    'avatar_color',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    email,
    role,
    intention,
    avatarColor,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserProfile> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    }
    if (data.containsKey('intention')) {
      context.handle(
        _intentionMeta,
        intention.isAcceptableOrUnknown(data['intention']!, _intentionMeta),
      );
    }
    if (data.containsKey('avatar_color')) {
      context.handle(
        _avatarColorMeta,
        avatarColor.isAcceptableOrUnknown(
          data['avatar_color']!,
          _avatarColorMeta,
        ),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  UserProfile map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserProfile(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      email: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}email'],
      ),
      role: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}role'],
      ),
      intention: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intention'],
      ),
      avatarColor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}avatar_color'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $UserProfilesTable createAlias(String alias) {
    return $UserProfilesTable(attachedDatabase, alias);
  }
}

class UserProfile extends DataClass implements Insertable<UserProfile> {
  final String id;
  final String name;
  final String? email;
  final String? role;
  final String? intention;
  final int avatarColor;
  final DateTime createdAt;
  const UserProfile({
    required this.id,
    required this.name,
    this.email,
    this.role,
    this.intention,
    required this.avatarColor,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String>(email);
    }
    if (!nullToAbsent || role != null) {
      map['role'] = Variable<String>(role);
    }
    if (!nullToAbsent || intention != null) {
      map['intention'] = Variable<String>(intention);
    }
    map['avatar_color'] = Variable<int>(avatarColor);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  UserProfilesCompanion toCompanion(bool nullToAbsent) {
    return UserProfilesCompanion(
      id: Value(id),
      name: Value(name),
      email: email == null && nullToAbsent
          ? const Value.absent()
          : Value(email),
      role: role == null && nullToAbsent ? const Value.absent() : Value(role),
      intention: intention == null && nullToAbsent
          ? const Value.absent()
          : Value(intention),
      avatarColor: Value(avatarColor),
      createdAt: Value(createdAt),
    );
  }

  factory UserProfile.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserProfile(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      email: serializer.fromJson<String?>(json['email']),
      role: serializer.fromJson<String?>(json['role']),
      intention: serializer.fromJson<String?>(json['intention']),
      avatarColor: serializer.fromJson<int>(json['avatarColor']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'email': serializer.toJson<String?>(email),
      'role': serializer.toJson<String?>(role),
      'intention': serializer.toJson<String?>(intention),
      'avatarColor': serializer.toJson<int>(avatarColor),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  UserProfile copyWith({
    String? id,
    String? name,
    Value<String?> email = const Value.absent(),
    Value<String?> role = const Value.absent(),
    Value<String?> intention = const Value.absent(),
    int? avatarColor,
    DateTime? createdAt,
  }) => UserProfile(
    id: id ?? this.id,
    name: name ?? this.name,
    email: email.present ? email.value : this.email,
    role: role.present ? role.value : this.role,
    intention: intention.present ? intention.value : this.intention,
    avatarColor: avatarColor ?? this.avatarColor,
    createdAt: createdAt ?? this.createdAt,
  );
  UserProfile copyWithCompanion(UserProfilesCompanion data) {
    return UserProfile(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      intention: data.intention.present ? data.intention.value : this.intention,
      avatarColor: data.avatarColor.present
          ? data.avatarColor.value
          : this.avatarColor,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserProfile(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('intention: $intention, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, name, email, role, intention, avatarColor, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserProfile &&
          other.id == this.id &&
          other.name == this.name &&
          other.email == this.email &&
          other.role == this.role &&
          other.intention == this.intention &&
          other.avatarColor == this.avatarColor &&
          other.createdAt == this.createdAt);
}

class UserProfilesCompanion extends UpdateCompanion<UserProfile> {
  final Value<String> id;
  final Value<String> name;
  final Value<String?> email;
  final Value<String?> role;
  final Value<String?> intention;
  final Value<int> avatarColor;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const UserProfilesCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.intention = const Value.absent(),
    this.avatarColor = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserProfilesCompanion.insert({
    required String id,
    required String name,
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.intention = const Value.absent(),
    this.avatarColor = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       createdAt = Value(createdAt);
  static Insertable<UserProfile> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? intention,
    Expression<int>? avatarColor,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (intention != null) 'intention': intention,
      if (avatarColor != null) 'avatar_color': avatarColor,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserProfilesCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<String?>? email,
    Value<String?>? role,
    Value<String?>? intention,
    Value<int>? avatarColor,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return UserProfilesCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      role: role ?? this.role,
      intention: intention ?? this.intention,
      avatarColor: avatarColor ?? this.avatarColor,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (intention.present) {
      map['intention'] = Variable<String>(intention.value);
    }
    if (avatarColor.present) {
      map['avatar_color'] = Variable<int>(avatarColor.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserProfilesCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('intention: $intention, ')
          ..write('avatarColor: $avatarColor, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalsTable extends Goals with TableInfo<$GoalsTable, Goal> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
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
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LifeArea>($GoalsTable.$converterarea);
  @override
  late final GeneratedColumnWithTypeConverter<GoalType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<GoalType>($GoalsTable.$convertertype);
  static const VerificationMeta _unitMeta = const VerificationMeta('unit');
  @override
  late final GeneratedColumn<String> unit = GeneratedColumn<String>(
    'unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant(''),
  );
  static const VerificationMeta _targetValueMeta = const VerificationMeta(
    'targetValue',
  );
  @override
  late final GeneratedColumn<double> targetValue = GeneratedColumn<double>(
    'target_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _startValueMeta = const VerificationMeta(
    'startValue',
  );
  @override
  late final GeneratedColumn<double> startValue = GeneratedColumn<double>(
    'start_value',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalFrequency, String> frequency =
      GeneratedColumn<String>(
        'frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('once'),
      ).withConverter<GoalFrequency>($GoalsTable.$converterfrequency);
  static const VerificationMeta _periodTargetMeta = const VerificationMeta(
    'periodTarget',
  );
  @override
  late final GeneratedColumn<int> periodTarget = GeneratedColumn<int>(
    'period_target',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _whyMeta = const VerificationMeta('why');
  @override
  late final GeneratedColumn<String> why = GeneratedColumn<String>(
    'why',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('active'),
      ).withConverter<GoalStatus>($GoalsTable.$converterstatus);
  static const VerificationMeta _isPrimaryMeta = const VerificationMeta(
    'isPrimary',
  );
  @override
  late final GeneratedColumn<bool> isPrimary = GeneratedColumn<bool>(
    'is_primary',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_primary" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    description,
    area,
    type,
    unit,
    targetValue,
    startValue,
    frequency,
    periodTarget,
    targetDate,
    why,
    status,
    isPrimary,
    createdAt,
    updatedAt,
    completedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goals';
  @override
  VerificationContext validateIntegrity(
    Insertable<Goal> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
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
    if (data.containsKey('unit')) {
      context.handle(
        _unitMeta,
        unit.isAcceptableOrUnknown(data['unit']!, _unitMeta),
      );
    }
    if (data.containsKey('target_value')) {
      context.handle(
        _targetValueMeta,
        targetValue.isAcceptableOrUnknown(
          data['target_value']!,
          _targetValueMeta,
        ),
      );
    }
    if (data.containsKey('start_value')) {
      context.handle(
        _startValueMeta,
        startValue.isAcceptableOrUnknown(data['start_value']!, _startValueMeta),
      );
    }
    if (data.containsKey('period_target')) {
      context.handle(
        _periodTargetMeta,
        periodTarget.isAcceptableOrUnknown(
          data['period_target']!,
          _periodTargetMeta,
        ),
      );
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('why')) {
      context.handle(
        _whyMeta,
        why.isAcceptableOrUnknown(data['why']!, _whyMeta),
      );
    }
    if (data.containsKey('is_primary')) {
      context.handle(
        _isPrimaryMeta,
        isPrimary.isAcceptableOrUnknown(data['is_primary']!, _isPrimaryMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Goal map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Goal(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      area: $GoalsTable.$converterarea.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        )!,
      ),
      type: $GoalsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      unit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}unit'],
      )!,
      targetValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}target_value'],
      )!,
      startValue: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}start_value'],
      )!,
      frequency: $GoalsTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      periodTarget: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}period_target'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      why: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}why'],
      ),
      status: $GoalsTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      isPrimary: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_primary'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
    );
  }

  @override
  $GoalsTable createAlias(String alias) {
    return $GoalsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeArea, String, String> $converterarea =
      const EnumNameConverter<LifeArea>(LifeArea.values);
  static JsonTypeConverter2<GoalType, String, String> $convertertype =
      const EnumNameConverter<GoalType>(GoalType.values);
  static JsonTypeConverter2<GoalFrequency, String, String> $converterfrequency =
      const EnumNameConverter<GoalFrequency>(GoalFrequency.values);
  static JsonTypeConverter2<GoalStatus, String, String> $converterstatus =
      const EnumNameConverter<GoalStatus>(GoalStatus.values);
}

class Goal extends DataClass implements Insertable<Goal> {
  final String id;
  final String title;
  final String? description;
  final LifeArea area;
  final GoalType type;
  final String unit;
  final double targetValue;
  final double startValue;
  final GoalFrequency frequency;
  final int periodTarget;
  final DateTime? targetDate;
  final String? why;
  final GoalStatus status;
  final bool isPrimary;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? completedAt;
  const Goal({
    required this.id,
    required this.title,
    this.description,
    required this.area,
    required this.type,
    required this.unit,
    required this.targetValue,
    required this.startValue,
    required this.frequency,
    required this.periodTarget,
    this.targetDate,
    this.why,
    required this.status,
    required this.isPrimary,
    required this.createdAt,
    required this.updatedAt,
    this.completedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    {
      map['area'] = Variable<String>($GoalsTable.$converterarea.toSql(area));
    }
    {
      map['type'] = Variable<String>($GoalsTable.$convertertype.toSql(type));
    }
    map['unit'] = Variable<String>(unit);
    map['target_value'] = Variable<double>(targetValue);
    map['start_value'] = Variable<double>(startValue);
    {
      map['frequency'] = Variable<String>(
        $GoalsTable.$converterfrequency.toSql(frequency),
      );
    }
    map['period_target'] = Variable<int>(periodTarget);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || why != null) {
      map['why'] = Variable<String>(why);
    }
    {
      map['status'] = Variable<String>(
        $GoalsTable.$converterstatus.toSql(status),
      );
    }
    map['is_primary'] = Variable<bool>(isPrimary);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    return map;
  }

  GoalsCompanion toCompanion(bool nullToAbsent) {
    return GoalsCompanion(
      id: Value(id),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      area: Value(area),
      type: Value(type),
      unit: Value(unit),
      targetValue: Value(targetValue),
      startValue: Value(startValue),
      frequency: Value(frequency),
      periodTarget: Value(periodTarget),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      why: why == null && nullToAbsent ? const Value.absent() : Value(why),
      status: Value(status),
      isPrimary: Value(isPrimary),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
    );
  }

  factory Goal.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Goal(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      area: $GoalsTable.$converterarea.fromJson(
        serializer.fromJson<String>(json['area']),
      ),
      type: $GoalsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      unit: serializer.fromJson<String>(json['unit']),
      targetValue: serializer.fromJson<double>(json['targetValue']),
      startValue: serializer.fromJson<double>(json['startValue']),
      frequency: $GoalsTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      periodTarget: serializer.fromJson<int>(json['periodTarget']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      why: serializer.fromJson<String?>(json['why']),
      status: $GoalsTable.$converterstatus.fromJson(
        serializer.fromJson<String>(json['status']),
      ),
      isPrimary: serializer.fromJson<bool>(json['isPrimary']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'area': serializer.toJson<String>(
        $GoalsTable.$converterarea.toJson(area),
      ),
      'type': serializer.toJson<String>(
        $GoalsTable.$convertertype.toJson(type),
      ),
      'unit': serializer.toJson<String>(unit),
      'targetValue': serializer.toJson<double>(targetValue),
      'startValue': serializer.toJson<double>(startValue),
      'frequency': serializer.toJson<String>(
        $GoalsTable.$converterfrequency.toJson(frequency),
      ),
      'periodTarget': serializer.toJson<int>(periodTarget),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'why': serializer.toJson<String?>(why),
      'status': serializer.toJson<String>(
        $GoalsTable.$converterstatus.toJson(status),
      ),
      'isPrimary': serializer.toJson<bool>(isPrimary),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
    };
  }

  Goal copyWith({
    String? id,
    String? title,
    Value<String?> description = const Value.absent(),
    LifeArea? area,
    GoalType? type,
    String? unit,
    double? targetValue,
    double? startValue,
    GoalFrequency? frequency,
    int? periodTarget,
    Value<DateTime?> targetDate = const Value.absent(),
    Value<String?> why = const Value.absent(),
    GoalStatus? status,
    bool? isPrimary,
    DateTime? createdAt,
    DateTime? updatedAt,
    Value<DateTime?> completedAt = const Value.absent(),
  }) => Goal(
    id: id ?? this.id,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    area: area ?? this.area,
    type: type ?? this.type,
    unit: unit ?? this.unit,
    targetValue: targetValue ?? this.targetValue,
    startValue: startValue ?? this.startValue,
    frequency: frequency ?? this.frequency,
    periodTarget: periodTarget ?? this.periodTarget,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    why: why.present ? why.value : this.why,
    status: status ?? this.status,
    isPrimary: isPrimary ?? this.isPrimary,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
  );
  Goal copyWithCompanion(GoalsCompanion data) {
    return Goal(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      area: data.area.present ? data.area.value : this.area,
      type: data.type.present ? data.type.value : this.type,
      unit: data.unit.present ? data.unit.value : this.unit,
      targetValue: data.targetValue.present
          ? data.targetValue.value
          : this.targetValue,
      startValue: data.startValue.present
          ? data.startValue.value
          : this.startValue,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      periodTarget: data.periodTarget.present
          ? data.periodTarget.value
          : this.periodTarget,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      why: data.why.present ? data.why.value : this.why,
      status: data.status.present ? data.status.value : this.status,
      isPrimary: data.isPrimary.present ? data.isPrimary.value : this.isPrimary,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Goal(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('area: $area, ')
          ..write('type: $type, ')
          ..write('unit: $unit, ')
          ..write('targetValue: $targetValue, ')
          ..write('startValue: $startValue, ')
          ..write('frequency: $frequency, ')
          ..write('periodTarget: $periodTarget, ')
          ..write('targetDate: $targetDate, ')
          ..write('why: $why, ')
          ..write('status: $status, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    description,
    area,
    type,
    unit,
    targetValue,
    startValue,
    frequency,
    periodTarget,
    targetDate,
    why,
    status,
    isPrimary,
    createdAt,
    updatedAt,
    completedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Goal &&
          other.id == this.id &&
          other.title == this.title &&
          other.description == this.description &&
          other.area == this.area &&
          other.type == this.type &&
          other.unit == this.unit &&
          other.targetValue == this.targetValue &&
          other.startValue == this.startValue &&
          other.frequency == this.frequency &&
          other.periodTarget == this.periodTarget &&
          other.targetDate == this.targetDate &&
          other.why == this.why &&
          other.status == this.status &&
          other.isPrimary == this.isPrimary &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.completedAt == this.completedAt);
}

class GoalsCompanion extends UpdateCompanion<Goal> {
  final Value<String> id;
  final Value<String> title;
  final Value<String?> description;
  final Value<LifeArea> area;
  final Value<GoalType> type;
  final Value<String> unit;
  final Value<double> targetValue;
  final Value<double> startValue;
  final Value<GoalFrequency> frequency;
  final Value<int> periodTarget;
  final Value<DateTime?> targetDate;
  final Value<String?> why;
  final Value<GoalStatus> status;
  final Value<bool> isPrimary;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<DateTime?> completedAt;
  final Value<int> rowid;
  const GoalsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.area = const Value.absent(),
    this.type = const Value.absent(),
    this.unit = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.startValue = const Value.absent(),
    this.frequency = const Value.absent(),
    this.periodTarget = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.why = const Value.absent(),
    this.status = const Value.absent(),
    this.isPrimary = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalsCompanion.insert({
    required String id,
    required String title,
    this.description = const Value.absent(),
    required LifeArea area,
    required GoalType type,
    this.unit = const Value.absent(),
    this.targetValue = const Value.absent(),
    this.startValue = const Value.absent(),
    this.frequency = const Value.absent(),
    this.periodTarget = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.why = const Value.absent(),
    this.status = const Value.absent(),
    this.isPrimary = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
    this.completedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       area = Value(area),
       type = Value(type),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<Goal> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? description,
    Expression<String>? area,
    Expression<String>? type,
    Expression<String>? unit,
    Expression<double>? targetValue,
    Expression<double>? startValue,
    Expression<String>? frequency,
    Expression<int>? periodTarget,
    Expression<DateTime>? targetDate,
    Expression<String>? why,
    Expression<String>? status,
    Expression<bool>? isPrimary,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<DateTime>? completedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (area != null) 'area': area,
      if (type != null) 'type': type,
      if (unit != null) 'unit': unit,
      if (targetValue != null) 'target_value': targetValue,
      if (startValue != null) 'start_value': startValue,
      if (frequency != null) 'frequency': frequency,
      if (periodTarget != null) 'period_target': periodTarget,
      if (targetDate != null) 'target_date': targetDate,
      if (why != null) 'why': why,
      if (status != null) 'status': status,
      if (isPrimary != null) 'is_primary': isPrimary,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (completedAt != null) 'completed_at': completedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String?>? description,
    Value<LifeArea>? area,
    Value<GoalType>? type,
    Value<String>? unit,
    Value<double>? targetValue,
    Value<double>? startValue,
    Value<GoalFrequency>? frequency,
    Value<int>? periodTarget,
    Value<DateTime?>? targetDate,
    Value<String?>? why,
    Value<GoalStatus>? status,
    Value<bool>? isPrimary,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<DateTime?>? completedAt,
    Value<int>? rowid,
  }) {
    return GoalsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      area: area ?? this.area,
      type: type ?? this.type,
      unit: unit ?? this.unit,
      targetValue: targetValue ?? this.targetValue,
      startValue: startValue ?? this.startValue,
      frequency: frequency ?? this.frequency,
      periodTarget: periodTarget ?? this.periodTarget,
      targetDate: targetDate ?? this.targetDate,
      why: why ?? this.why,
      status: status ?? this.status,
      isPrimary: isPrimary ?? this.isPrimary,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      completedAt: completedAt ?? this.completedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $GoalsTable.$converterarea.toSql(area.value),
      );
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $GoalsTable.$convertertype.toSql(type.value),
      );
    }
    if (unit.present) {
      map['unit'] = Variable<String>(unit.value);
    }
    if (targetValue.present) {
      map['target_value'] = Variable<double>(targetValue.value);
    }
    if (startValue.present) {
      map['start_value'] = Variable<double>(startValue.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(
        $GoalsTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (periodTarget.present) {
      map['period_target'] = Variable<int>(periodTarget.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (why.present) {
      map['why'] = Variable<String>(why.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(
        $GoalsTable.$converterstatus.toSql(status.value),
      );
    }
    if (isPrimary.present) {
      map['is_primary'] = Variable<bool>(isPrimary.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('area: $area, ')
          ..write('type: $type, ')
          ..write('unit: $unit, ')
          ..write('targetValue: $targetValue, ')
          ..write('startValue: $startValue, ')
          ..write('frequency: $frequency, ')
          ..write('periodTarget: $periodTarget, ')
          ..write('targetDate: $targetDate, ')
          ..write('why: $why, ')
          ..write('status: $status, ')
          ..write('isPrimary: $isPrimary, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('completedAt: $completedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalActionsTable extends GoalActions
    with TableInfo<$GoalActionsTable, GoalAction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalActionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<GoalFrequency, String> frequency =
      GeneratedColumn<String>(
        'frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('weekly'),
      ).withConverter<GoalFrequency>($GoalActionsTable.$converterfrequency);
  static const VerificationMeta _lastCompletedAtMeta = const VerificationMeta(
    'lastCompletedAt',
  );
  @override
  late final GeneratedColumn<DateTime> lastCompletedAt =
      GeneratedColumn<DateTime>(
        'last_completed_at',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalId,
    title,
    detail,
    frequency,
    lastCompletedAt,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_actions';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalAction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('last_completed_at')) {
      context.handle(
        _lastCompletedAtMeta,
        lastCompletedAt.isAcceptableOrUnknown(
          data['last_completed_at']!,
          _lastCompletedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalAction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalAction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      frequency: $GoalActionsTable.$converterfrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}frequency'],
        )!,
      ),
      lastCompletedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_completed_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $GoalActionsTable createAlias(String alias) {
    return $GoalActionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<GoalFrequency, String, String> $converterfrequency =
      const EnumNameConverter<GoalFrequency>(GoalFrequency.values);
}

class GoalAction extends DataClass implements Insertable<GoalAction> {
  final String id;
  final String goalId;
  final String title;
  final String? detail;
  final GoalFrequency frequency;
  final DateTime? lastCompletedAt;
  final int sortOrder;
  final DateTime createdAt;
  const GoalAction({
    required this.id,
    required this.goalId,
    required this.title,
    this.detail,
    required this.frequency,
    this.lastCompletedAt,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    {
      map['frequency'] = Variable<String>(
        $GoalActionsTable.$converterfrequency.toSql(frequency),
      );
    }
    if (!nullToAbsent || lastCompletedAt != null) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  GoalActionsCompanion toCompanion(bool nullToAbsent) {
    return GoalActionsCompanion(
      id: Value(id),
      goalId: Value(goalId),
      title: Value(title),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      frequency: Value(frequency),
      lastCompletedAt: lastCompletedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(lastCompletedAt),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory GoalAction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalAction(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      title: serializer.fromJson<String>(json['title']),
      detail: serializer.fromJson<String?>(json['detail']),
      frequency: $GoalActionsTable.$converterfrequency.fromJson(
        serializer.fromJson<String>(json['frequency']),
      ),
      lastCompletedAt: serializer.fromJson<DateTime?>(json['lastCompletedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'title': serializer.toJson<String>(title),
      'detail': serializer.toJson<String?>(detail),
      'frequency': serializer.toJson<String>(
        $GoalActionsTable.$converterfrequency.toJson(frequency),
      ),
      'lastCompletedAt': serializer.toJson<DateTime?>(lastCompletedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  GoalAction copyWith({
    String? id,
    String? goalId,
    String? title,
    Value<String?> detail = const Value.absent(),
    GoalFrequency? frequency,
    Value<DateTime?> lastCompletedAt = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => GoalAction(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    title: title ?? this.title,
    detail: detail.present ? detail.value : this.detail,
    frequency: frequency ?? this.frequency,
    lastCompletedAt: lastCompletedAt.present
        ? lastCompletedAt.value
        : this.lastCompletedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  GoalAction copyWithCompanion(GoalActionsCompanion data) {
    return GoalAction(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      title: data.title.present ? data.title.value : this.title,
      detail: data.detail.present ? data.detail.value : this.detail,
      frequency: data.frequency.present ? data.frequency.value : this.frequency,
      lastCompletedAt: data.lastCompletedAt.present
          ? data.lastCompletedAt.value
          : this.lastCompletedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalAction(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('frequency: $frequency, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    goalId,
    title,
    detail,
    frequency,
    lastCompletedAt,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalAction &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.title == this.title &&
          other.detail == this.detail &&
          other.frequency == this.frequency &&
          other.lastCompletedAt == this.lastCompletedAt &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class GoalActionsCompanion extends UpdateCompanion<GoalAction> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<String> title;
  final Value<String?> detail;
  final Value<GoalFrequency> frequency;
  final Value<DateTime?> lastCompletedAt;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const GoalActionsCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.title = const Value.absent(),
    this.detail = const Value.absent(),
    this.frequency = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalActionsCompanion.insert({
    required String id,
    required String goalId,
    required String title,
    this.detail = const Value.absent(),
    this.frequency = const Value.absent(),
    this.lastCompletedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       title = Value(title),
       createdAt = Value(createdAt);
  static Insertable<GoalAction> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<String>? title,
    Expression<String>? detail,
    Expression<String>? frequency,
    Expression<DateTime>? lastCompletedAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (title != null) 'title': title,
      if (detail != null) 'detail': detail,
      if (frequency != null) 'frequency': frequency,
      if (lastCompletedAt != null) 'last_completed_at': lastCompletedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalActionsCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<String>? title,
    Value<String?>? detail,
    Value<GoalFrequency>? frequency,
    Value<DateTime?>? lastCompletedAt,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return GoalActionsCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      detail: detail ?? this.detail,
      frequency: frequency ?? this.frequency,
      lastCompletedAt: lastCompletedAt ?? this.lastCompletedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (frequency.present) {
      map['frequency'] = Variable<String>(
        $GoalActionsTable.$converterfrequency.toSql(frequency.value),
      );
    }
    if (lastCompletedAt.present) {
      map['last_completed_at'] = Variable<DateTime>(lastCompletedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalActionsCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('detail: $detail, ')
          ..write('frequency: $frequency, ')
          ..write('lastCompletedAt: $lastCompletedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalMilestonesTable extends GoalMilestones
    with TableInfo<$GoalMilestonesTable, GoalMilestone> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalMilestonesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _targetDateMeta = const VerificationMeta(
    'targetDate',
  );
  @override
  late final GeneratedColumn<DateTime> targetDate = GeneratedColumn<DateTime>(
    'target_date',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalId,
    title,
    targetDate,
    completedAt,
    sortOrder,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_milestones';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalMilestone> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('target_date')) {
      context.handle(
        _targetDateMeta,
        targetDate.isAcceptableOrUnknown(data['target_date']!, _targetDateMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalMilestone map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalMilestone(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      targetDate: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}target_date'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
    );
  }

  @override
  $GoalMilestonesTable createAlias(String alias) {
    return $GoalMilestonesTable(attachedDatabase, alias);
  }
}

class GoalMilestone extends DataClass implements Insertable<GoalMilestone> {
  final String id;
  final String goalId;
  final String title;
  final DateTime? targetDate;
  final DateTime? completedAt;
  final int sortOrder;
  const GoalMilestone({
    required this.id,
    required this.goalId,
    required this.title,
    this.targetDate,
    this.completedAt,
    required this.sortOrder,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || targetDate != null) {
      map['target_date'] = Variable<DateTime>(targetDate);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    return map;
  }

  GoalMilestonesCompanion toCompanion(bool nullToAbsent) {
    return GoalMilestonesCompanion(
      id: Value(id),
      goalId: Value(goalId),
      title: Value(title),
      targetDate: targetDate == null && nullToAbsent
          ? const Value.absent()
          : Value(targetDate),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      sortOrder: Value(sortOrder),
    );
  }

  factory GoalMilestone.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalMilestone(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      title: serializer.fromJson<String>(json['title']),
      targetDate: serializer.fromJson<DateTime?>(json['targetDate']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'title': serializer.toJson<String>(title),
      'targetDate': serializer.toJson<DateTime?>(targetDate),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
    };
  }

  GoalMilestone copyWith({
    String? id,
    String? goalId,
    String? title,
    Value<DateTime?> targetDate = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    int? sortOrder,
  }) => GoalMilestone(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    title: title ?? this.title,
    targetDate: targetDate.present ? targetDate.value : this.targetDate,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    sortOrder: sortOrder ?? this.sortOrder,
  );
  GoalMilestone copyWithCompanion(GoalMilestonesCompanion data) {
    return GoalMilestone(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      title: data.title.present ? data.title.value : this.title,
      targetDate: data.targetDate.present
          ? data.targetDate.value
          : this.targetDate,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalMilestone(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('targetDate: $targetDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, goalId, title, targetDate, completedAt, sortOrder);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalMilestone &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.title == this.title &&
          other.targetDate == this.targetDate &&
          other.completedAt == this.completedAt &&
          other.sortOrder == this.sortOrder);
}

class GoalMilestonesCompanion extends UpdateCompanion<GoalMilestone> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<String> title;
  final Value<DateTime?> targetDate;
  final Value<DateTime?> completedAt;
  final Value<int> sortOrder;
  final Value<int> rowid;
  const GoalMilestonesCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.title = const Value.absent(),
    this.targetDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalMilestonesCompanion.insert({
    required String id,
    required String goalId,
    required String title,
    this.targetDate = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       title = Value(title);
  static Insertable<GoalMilestone> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<String>? title,
    Expression<DateTime>? targetDate,
    Expression<DateTime>? completedAt,
    Expression<int>? sortOrder,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (title != null) 'title': title,
      if (targetDate != null) 'target_date': targetDate,
      if (completedAt != null) 'completed_at': completedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalMilestonesCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<String>? title,
    Value<DateTime?>? targetDate,
    Value<DateTime?>? completedAt,
    Value<int>? sortOrder,
    Value<int>? rowid,
  }) {
    return GoalMilestonesCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      title: title ?? this.title,
      targetDate: targetDate ?? this.targetDate,
      completedAt: completedAt ?? this.completedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (targetDate.present) {
      map['target_date'] = Variable<DateTime>(targetDate.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalMilestonesCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('title: $title, ')
          ..write('targetDate: $targetDate, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GoalProgressEventsTable extends GoalProgressEvents
    with TableInfo<$GoalProgressEventsTable, GoalProgressEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GoalProgressEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _deltaMeta = const VerificationMeta('delta');
  @override
  late final GeneratedColumn<double> delta = GeneratedColumn<double>(
    'delta',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ProgressSource, String> source =
      GeneratedColumn<String>(
        'source',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('manual'),
      ).withConverter<ProgressSource>(
        $GoalProgressEventsTable.$convertersource,
      );
  static const VerificationMeta _sourceIdMeta = const VerificationMeta(
    'sourceId',
  );
  @override
  late final GeneratedColumn<String> sourceId = GeneratedColumn<String>(
    'source_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    goalId,
    delta,
    note,
    source,
    sourceId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'goal_progress_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<GoalProgressEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    } else if (isInserting) {
      context.missing(_goalIdMeta);
    }
    if (data.containsKey('delta')) {
      context.handle(
        _deltaMeta,
        delta.isAcceptableOrUnknown(data['delta']!, _deltaMeta),
      );
    } else if (isInserting) {
      context.missing(_deltaMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('source_id')) {
      context.handle(
        _sourceIdMeta,
        sourceId.isAcceptableOrUnknown(data['source_id']!, _sourceIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GoalProgressEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GoalProgressEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      )!,
      delta: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}delta'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      source: $GoalProgressEventsTable.$convertersource.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}source'],
        )!,
      ),
      sourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}source_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $GoalProgressEventsTable createAlias(String alias) {
    return $GoalProgressEventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ProgressSource, String, String> $convertersource =
      const EnumNameConverter<ProgressSource>(ProgressSource.values);
}

class GoalProgressEvent extends DataClass
    implements Insertable<GoalProgressEvent> {
  final String id;
  final String goalId;
  final double delta;
  final String? note;
  final ProgressSource source;
  final String? sourceId;
  final DateTime occurredAt;
  const GoalProgressEvent({
    required this.id,
    required this.goalId,
    required this.delta,
    this.note,
    required this.source,
    this.sourceId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['goal_id'] = Variable<String>(goalId);
    map['delta'] = Variable<double>(delta);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['source'] = Variable<String>(
        $GoalProgressEventsTable.$convertersource.toSql(source),
      );
    }
    if (!nullToAbsent || sourceId != null) {
      map['source_id'] = Variable<String>(sourceId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  GoalProgressEventsCompanion toCompanion(bool nullToAbsent) {
    return GoalProgressEventsCompanion(
      id: Value(id),
      goalId: Value(goalId),
      delta: Value(delta),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      source: Value(source),
      sourceId: sourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(sourceId),
      occurredAt: Value(occurredAt),
    );
  }

  factory GoalProgressEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GoalProgressEvent(
      id: serializer.fromJson<String>(json['id']),
      goalId: serializer.fromJson<String>(json['goalId']),
      delta: serializer.fromJson<double>(json['delta']),
      note: serializer.fromJson<String?>(json['note']),
      source: $GoalProgressEventsTable.$convertersource.fromJson(
        serializer.fromJson<String>(json['source']),
      ),
      sourceId: serializer.fromJson<String?>(json['sourceId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'goalId': serializer.toJson<String>(goalId),
      'delta': serializer.toJson<double>(delta),
      'note': serializer.toJson<String?>(note),
      'source': serializer.toJson<String>(
        $GoalProgressEventsTable.$convertersource.toJson(source),
      ),
      'sourceId': serializer.toJson<String?>(sourceId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  GoalProgressEvent copyWith({
    String? id,
    String? goalId,
    double? delta,
    Value<String?> note = const Value.absent(),
    ProgressSource? source,
    Value<String?> sourceId = const Value.absent(),
    DateTime? occurredAt,
  }) => GoalProgressEvent(
    id: id ?? this.id,
    goalId: goalId ?? this.goalId,
    delta: delta ?? this.delta,
    note: note.present ? note.value : this.note,
    source: source ?? this.source,
    sourceId: sourceId.present ? sourceId.value : this.sourceId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  GoalProgressEvent copyWithCompanion(GoalProgressEventsCompanion data) {
    return GoalProgressEvent(
      id: data.id.present ? data.id.value : this.id,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      delta: data.delta.present ? data.delta.value : this.delta,
      note: data.note.present ? data.note.value : this.note,
      source: data.source.present ? data.source.value : this.source,
      sourceId: data.sourceId.present ? data.sourceId.value : this.sourceId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GoalProgressEvent(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('delta: $delta, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, goalId, delta, note, source, sourceId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GoalProgressEvent &&
          other.id == this.id &&
          other.goalId == this.goalId &&
          other.delta == this.delta &&
          other.note == this.note &&
          other.source == this.source &&
          other.sourceId == this.sourceId &&
          other.occurredAt == this.occurredAt);
}

class GoalProgressEventsCompanion extends UpdateCompanion<GoalProgressEvent> {
  final Value<String> id;
  final Value<String> goalId;
  final Value<double> delta;
  final Value<String?> note;
  final Value<ProgressSource> source;
  final Value<String?> sourceId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const GoalProgressEventsCompanion({
    this.id = const Value.absent(),
    this.goalId = const Value.absent(),
    this.delta = const Value.absent(),
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GoalProgressEventsCompanion.insert({
    required String id,
    required String goalId,
    required double delta,
    this.note = const Value.absent(),
    this.source = const Value.absent(),
    this.sourceId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       goalId = Value(goalId),
       delta = Value(delta),
       occurredAt = Value(occurredAt);
  static Insertable<GoalProgressEvent> custom({
    Expression<String>? id,
    Expression<String>? goalId,
    Expression<double>? delta,
    Expression<String>? note,
    Expression<String>? source,
    Expression<String>? sourceId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (goalId != null) 'goal_id': goalId,
      if (delta != null) 'delta': delta,
      if (note != null) 'note': note,
      if (source != null) 'source': source,
      if (sourceId != null) 'source_id': sourceId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GoalProgressEventsCompanion copyWith({
    Value<String>? id,
    Value<String>? goalId,
    Value<double>? delta,
    Value<String?>? note,
    Value<ProgressSource>? source,
    Value<String?>? sourceId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return GoalProgressEventsCompanion(
      id: id ?? this.id,
      goalId: goalId ?? this.goalId,
      delta: delta ?? this.delta,
      note: note ?? this.note,
      source: source ?? this.source,
      sourceId: sourceId ?? this.sourceId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (delta.present) {
      map['delta'] = Variable<double>(delta.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (source.present) {
      map['source'] = Variable<String>(
        $GoalProgressEventsTable.$convertersource.toSql(source.value),
      );
    }
    if (sourceId.present) {
      map['source_id'] = Variable<String>(sourceId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GoalProgressEventsCompanion(')
          ..write('id: $id, ')
          ..write('goalId: $goalId, ')
          ..write('delta: $delta, ')
          ..write('note: $note, ')
          ..write('source: $source, ')
          ..write('sourceId: $sourceId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $TasksTable extends Tasks with TableInfo<$TasksTable, Task> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TasksTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LifeArea>($TasksTable.$converterarea);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _scheduledMinuteMeta = const VerificationMeta(
    'scheduledMinute',
  );
  @override
  late final GeneratedColumn<int> scheduledMinute = GeneratedColumn<int>(
    'scheduled_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _durationMinutesMeta = const VerificationMeta(
    'durationMinutes',
  );
  @override
  late final GeneratedColumn<int> durationMinutes = GeneratedColumn<int>(
    'duration_minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _badgeMeta = const VerificationMeta('badge');
  @override
  late final GeneratedColumn<String> badge = GeneratedColumn<String>(
    'badge',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _priorityRankMeta = const VerificationMeta(
    'priorityRank',
  );
  @override
  late final GeneratedColumn<int> priorityRank = GeneratedColumn<int>(
    'priority_rank',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dayKey,
    title,
    area,
    goalId,
    scheduledMinute,
    durationMinutes,
    badge,
    note,
    priorityRank,
    completedAt,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tasks';
  @override
  VerificationContext validateIntegrity(
    Insertable<Task> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('scheduled_minute')) {
      context.handle(
        _scheduledMinuteMeta,
        scheduledMinute.isAcceptableOrUnknown(
          data['scheduled_minute']!,
          _scheduledMinuteMeta,
        ),
      );
    }
    if (data.containsKey('duration_minutes')) {
      context.handle(
        _durationMinutesMeta,
        durationMinutes.isAcceptableOrUnknown(
          data['duration_minutes']!,
          _durationMinutesMeta,
        ),
      );
    }
    if (data.containsKey('badge')) {
      context.handle(
        _badgeMeta,
        badge.isAcceptableOrUnknown(data['badge']!, _badgeMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('priority_rank')) {
      context.handle(
        _priorityRankMeta,
        priorityRank.isAcceptableOrUnknown(
          data['priority_rank']!,
          _priorityRankMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Task map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Task(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      area: $TasksTable.$converterarea.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        )!,
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      scheduledMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}scheduled_minute'],
      ),
      durationMinutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}duration_minutes'],
      ),
      badge: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}badge'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      priorityRank: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}priority_rank'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $TasksTable createAlias(String alias) {
    return $TasksTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeArea, String, String> $converterarea =
      const EnumNameConverter<LifeArea>(LifeArea.values);
}

class Task extends DataClass implements Insertable<Task> {
  final String id;
  final String dayKey;
  final String title;
  final LifeArea area;
  final String? goalId;
  final int? scheduledMinute;
  final int? durationMinutes;
  final String? badge;
  final String? note;
  final int? priorityRank;
  final DateTime? completedAt;
  final int sortOrder;
  final DateTime createdAt;
  const Task({
    required this.id,
    required this.dayKey,
    required this.title,
    required this.area,
    this.goalId,
    this.scheduledMinute,
    this.durationMinutes,
    this.badge,
    this.note,
    this.priorityRank,
    this.completedAt,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['day_key'] = Variable<String>(dayKey);
    map['title'] = Variable<String>(title);
    {
      map['area'] = Variable<String>($TasksTable.$converterarea.toSql(area));
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    if (!nullToAbsent || scheduledMinute != null) {
      map['scheduled_minute'] = Variable<int>(scheduledMinute);
    }
    if (!nullToAbsent || durationMinutes != null) {
      map['duration_minutes'] = Variable<int>(durationMinutes);
    }
    if (!nullToAbsent || badge != null) {
      map['badge'] = Variable<String>(badge);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || priorityRank != null) {
      map['priority_rank'] = Variable<int>(priorityRank);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  TasksCompanion toCompanion(bool nullToAbsent) {
    return TasksCompanion(
      id: Value(id),
      dayKey: Value(dayKey),
      title: Value(title),
      area: Value(area),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      scheduledMinute: scheduledMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledMinute),
      durationMinutes: durationMinutes == null && nullToAbsent
          ? const Value.absent()
          : Value(durationMinutes),
      badge: badge == null && nullToAbsent
          ? const Value.absent()
          : Value(badge),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      priorityRank: priorityRank == null && nullToAbsent
          ? const Value.absent()
          : Value(priorityRank),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory Task.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Task(
      id: serializer.fromJson<String>(json['id']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      title: serializer.fromJson<String>(json['title']),
      area: $TasksTable.$converterarea.fromJson(
        serializer.fromJson<String>(json['area']),
      ),
      goalId: serializer.fromJson<String?>(json['goalId']),
      scheduledMinute: serializer.fromJson<int?>(json['scheduledMinute']),
      durationMinutes: serializer.fromJson<int?>(json['durationMinutes']),
      badge: serializer.fromJson<String?>(json['badge']),
      note: serializer.fromJson<String?>(json['note']),
      priorityRank: serializer.fromJson<int?>(json['priorityRank']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dayKey': serializer.toJson<String>(dayKey),
      'title': serializer.toJson<String>(title),
      'area': serializer.toJson<String>(
        $TasksTable.$converterarea.toJson(area),
      ),
      'goalId': serializer.toJson<String?>(goalId),
      'scheduledMinute': serializer.toJson<int?>(scheduledMinute),
      'durationMinutes': serializer.toJson<int?>(durationMinutes),
      'badge': serializer.toJson<String?>(badge),
      'note': serializer.toJson<String?>(note),
      'priorityRank': serializer.toJson<int?>(priorityRank),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Task copyWith({
    String? id,
    String? dayKey,
    String? title,
    LifeArea? area,
    Value<String?> goalId = const Value.absent(),
    Value<int?> scheduledMinute = const Value.absent(),
    Value<int?> durationMinutes = const Value.absent(),
    Value<String?> badge = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<int?> priorityRank = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    int? sortOrder,
    DateTime? createdAt,
  }) => Task(
    id: id ?? this.id,
    dayKey: dayKey ?? this.dayKey,
    title: title ?? this.title,
    area: area ?? this.area,
    goalId: goalId.present ? goalId.value : this.goalId,
    scheduledMinute: scheduledMinute.present
        ? scheduledMinute.value
        : this.scheduledMinute,
    durationMinutes: durationMinutes.present
        ? durationMinutes.value
        : this.durationMinutes,
    badge: badge.present ? badge.value : this.badge,
    note: note.present ? note.value : this.note,
    priorityRank: priorityRank.present ? priorityRank.value : this.priorityRank,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  Task copyWithCompanion(TasksCompanion data) {
    return Task(
      id: data.id.present ? data.id.value : this.id,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      title: data.title.present ? data.title.value : this.title,
      area: data.area.present ? data.area.value : this.area,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      scheduledMinute: data.scheduledMinute.present
          ? data.scheduledMinute.value
          : this.scheduledMinute,
      durationMinutes: data.durationMinutes.present
          ? data.durationMinutes.value
          : this.durationMinutes,
      badge: data.badge.present ? data.badge.value : this.badge,
      note: data.note.present ? data.note.value : this.note,
      priorityRank: data.priorityRank.present
          ? data.priorityRank.value
          : this.priorityRank,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Task(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('title: $title, ')
          ..write('area: $area, ')
          ..write('goalId: $goalId, ')
          ..write('scheduledMinute: $scheduledMinute, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('badge: $badge, ')
          ..write('note: $note, ')
          ..write('priorityRank: $priorityRank, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    dayKey,
    title,
    area,
    goalId,
    scheduledMinute,
    durationMinutes,
    badge,
    note,
    priorityRank,
    completedAt,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Task &&
          other.id == this.id &&
          other.dayKey == this.dayKey &&
          other.title == this.title &&
          other.area == this.area &&
          other.goalId == this.goalId &&
          other.scheduledMinute == this.scheduledMinute &&
          other.durationMinutes == this.durationMinutes &&
          other.badge == this.badge &&
          other.note == this.note &&
          other.priorityRank == this.priorityRank &&
          other.completedAt == this.completedAt &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class TasksCompanion extends UpdateCompanion<Task> {
  final Value<String> id;
  final Value<String> dayKey;
  final Value<String> title;
  final Value<LifeArea> area;
  final Value<String?> goalId;
  final Value<int?> scheduledMinute;
  final Value<int?> durationMinutes;
  final Value<String?> badge;
  final Value<String?> note;
  final Value<int?> priorityRank;
  final Value<DateTime?> completedAt;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const TasksCompanion({
    this.id = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.title = const Value.absent(),
    this.area = const Value.absent(),
    this.goalId = const Value.absent(),
    this.scheduledMinute = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.badge = const Value.absent(),
    this.note = const Value.absent(),
    this.priorityRank = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  TasksCompanion.insert({
    required String id,
    required String dayKey,
    required String title,
    required LifeArea area,
    this.goalId = const Value.absent(),
    this.scheduledMinute = const Value.absent(),
    this.durationMinutes = const Value.absent(),
    this.badge = const Value.absent(),
    this.note = const Value.absent(),
    this.priorityRank = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dayKey = Value(dayKey),
       title = Value(title),
       area = Value(area),
       createdAt = Value(createdAt);
  static Insertable<Task> custom({
    Expression<String>? id,
    Expression<String>? dayKey,
    Expression<String>? title,
    Expression<String>? area,
    Expression<String>? goalId,
    Expression<int>? scheduledMinute,
    Expression<int>? durationMinutes,
    Expression<String>? badge,
    Expression<String>? note,
    Expression<int>? priorityRank,
    Expression<DateTime>? completedAt,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayKey != null) 'day_key': dayKey,
      if (title != null) 'title': title,
      if (area != null) 'area': area,
      if (goalId != null) 'goal_id': goalId,
      if (scheduledMinute != null) 'scheduled_minute': scheduledMinute,
      if (durationMinutes != null) 'duration_minutes': durationMinutes,
      if (badge != null) 'badge': badge,
      if (note != null) 'note': note,
      if (priorityRank != null) 'priority_rank': priorityRank,
      if (completedAt != null) 'completed_at': completedAt,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  TasksCompanion copyWith({
    Value<String>? id,
    Value<String>? dayKey,
    Value<String>? title,
    Value<LifeArea>? area,
    Value<String?>? goalId,
    Value<int?>? scheduledMinute,
    Value<int?>? durationMinutes,
    Value<String?>? badge,
    Value<String?>? note,
    Value<int?>? priorityRank,
    Value<DateTime?>? completedAt,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return TasksCompanion(
      id: id ?? this.id,
      dayKey: dayKey ?? this.dayKey,
      title: title ?? this.title,
      area: area ?? this.area,
      goalId: goalId ?? this.goalId,
      scheduledMinute: scheduledMinute ?? this.scheduledMinute,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      badge: badge ?? this.badge,
      note: note ?? this.note,
      priorityRank: priorityRank ?? this.priorityRank,
      completedAt: completedAt ?? this.completedAt,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $TasksTable.$converterarea.toSql(area.value),
      );
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (scheduledMinute.present) {
      map['scheduled_minute'] = Variable<int>(scheduledMinute.value);
    }
    if (durationMinutes.present) {
      map['duration_minutes'] = Variable<int>(durationMinutes.value);
    }
    if (badge.present) {
      map['badge'] = Variable<String>(badge.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (priorityRank.present) {
      map['priority_rank'] = Variable<int>(priorityRank.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TasksCompanion(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('title: $title, ')
          ..write('area: $area, ')
          ..write('goalId: $goalId, ')
          ..write('scheduledMinute: $scheduledMinute, ')
          ..write('durationMinutes: $durationMinutes, ')
          ..write('badge: $badge, ')
          ..write('note: $note, ')
          ..write('priorityRank: $priorityRank, ')
          ..write('completedAt: $completedAt, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MorningCheckInsTable extends MorningCheckIns
    with TableInfo<$MorningCheckInsTable, MorningCheckIn> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MorningCheckInsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Energy, String> energy =
      GeneratedColumn<String>(
        'energy',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Energy>($MorningCheckInsTable.$converterenergy);
  @override
  late final GeneratedColumnWithTypeConverter<Capacity, String> capacity =
      GeneratedColumn<String>(
        'capacity',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<Capacity>($MorningCheckInsTable.$convertercapacity);
  static const VerificationMeta _intentionMeta = const VerificationMeta(
    'intention',
  );
  @override
  late final GeneratedColumn<String> intention = GeneratedColumn<String>(
    'intention',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    dayKey,
    energy,
    capacity,
    intention,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'morning_check_ins';
  @override
  VerificationContext validateIntegrity(
    Insertable<MorningCheckIn> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('intention')) {
      context.handle(
        _intentionMeta,
        intention.isAcceptableOrUnknown(data['intention']!, _intentionMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayKey};
  @override
  MorningCheckIn map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MorningCheckIn(
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      energy: $MorningCheckInsTable.$converterenergy.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}energy'],
        )!,
      ),
      capacity: $MorningCheckInsTable.$convertercapacity.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}capacity'],
        )!,
      ),
      intention: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}intention'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MorningCheckInsTable createAlias(String alias) {
    return $MorningCheckInsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Energy, String, String> $converterenergy =
      const EnumNameConverter<Energy>(Energy.values);
  static JsonTypeConverter2<Capacity, String, String> $convertercapacity =
      const EnumNameConverter<Capacity>(Capacity.values);
}

class MorningCheckIn extends DataClass implements Insertable<MorningCheckIn> {
  final String dayKey;
  final Energy energy;
  final Capacity capacity;
  final String? intention;
  final DateTime createdAt;
  const MorningCheckIn({
    required this.dayKey,
    required this.energy,
    required this.capacity,
    this.intention,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_key'] = Variable<String>(dayKey);
    {
      map['energy'] = Variable<String>(
        $MorningCheckInsTable.$converterenergy.toSql(energy),
      );
    }
    {
      map['capacity'] = Variable<String>(
        $MorningCheckInsTable.$convertercapacity.toSql(capacity),
      );
    }
    if (!nullToAbsent || intention != null) {
      map['intention'] = Variable<String>(intention);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MorningCheckInsCompanion toCompanion(bool nullToAbsent) {
    return MorningCheckInsCompanion(
      dayKey: Value(dayKey),
      energy: Value(energy),
      capacity: Value(capacity),
      intention: intention == null && nullToAbsent
          ? const Value.absent()
          : Value(intention),
      createdAt: Value(createdAt),
    );
  }

  factory MorningCheckIn.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MorningCheckIn(
      dayKey: serializer.fromJson<String>(json['dayKey']),
      energy: $MorningCheckInsTable.$converterenergy.fromJson(
        serializer.fromJson<String>(json['energy']),
      ),
      capacity: $MorningCheckInsTable.$convertercapacity.fromJson(
        serializer.fromJson<String>(json['capacity']),
      ),
      intention: serializer.fromJson<String?>(json['intention']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayKey': serializer.toJson<String>(dayKey),
      'energy': serializer.toJson<String>(
        $MorningCheckInsTable.$converterenergy.toJson(energy),
      ),
      'capacity': serializer.toJson<String>(
        $MorningCheckInsTable.$convertercapacity.toJson(capacity),
      ),
      'intention': serializer.toJson<String?>(intention),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MorningCheckIn copyWith({
    String? dayKey,
    Energy? energy,
    Capacity? capacity,
    Value<String?> intention = const Value.absent(),
    DateTime? createdAt,
  }) => MorningCheckIn(
    dayKey: dayKey ?? this.dayKey,
    energy: energy ?? this.energy,
    capacity: capacity ?? this.capacity,
    intention: intention.present ? intention.value : this.intention,
    createdAt: createdAt ?? this.createdAt,
  );
  MorningCheckIn copyWithCompanion(MorningCheckInsCompanion data) {
    return MorningCheckIn(
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      energy: data.energy.present ? data.energy.value : this.energy,
      capacity: data.capacity.present ? data.capacity.value : this.capacity,
      intention: data.intention.present ? data.intention.value : this.intention,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MorningCheckIn(')
          ..write('dayKey: $dayKey, ')
          ..write('energy: $energy, ')
          ..write('capacity: $capacity, ')
          ..write('intention: $intention, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(dayKey, energy, capacity, intention, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MorningCheckIn &&
          other.dayKey == this.dayKey &&
          other.energy == this.energy &&
          other.capacity == this.capacity &&
          other.intention == this.intention &&
          other.createdAt == this.createdAt);
}

class MorningCheckInsCompanion extends UpdateCompanion<MorningCheckIn> {
  final Value<String> dayKey;
  final Value<Energy> energy;
  final Value<Capacity> capacity;
  final Value<String?> intention;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const MorningCheckInsCompanion({
    this.dayKey = const Value.absent(),
    this.energy = const Value.absent(),
    this.capacity = const Value.absent(),
    this.intention = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MorningCheckInsCompanion.insert({
    required String dayKey,
    required Energy energy,
    required Capacity capacity,
    this.intention = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : dayKey = Value(dayKey),
       energy = Value(energy),
       capacity = Value(capacity),
       createdAt = Value(createdAt);
  static Insertable<MorningCheckIn> custom({
    Expression<String>? dayKey,
    Expression<String>? energy,
    Expression<String>? capacity,
    Expression<String>? intention,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayKey != null) 'day_key': dayKey,
      if (energy != null) 'energy': energy,
      if (capacity != null) 'capacity': capacity,
      if (intention != null) 'intention': intention,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MorningCheckInsCompanion copyWith({
    Value<String>? dayKey,
    Value<Energy>? energy,
    Value<Capacity>? capacity,
    Value<String?>? intention,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return MorningCheckInsCompanion(
      dayKey: dayKey ?? this.dayKey,
      energy: energy ?? this.energy,
      capacity: capacity ?? this.capacity,
      intention: intention ?? this.intention,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (energy.present) {
      map['energy'] = Variable<String>(
        $MorningCheckInsTable.$converterenergy.toSql(energy.value),
      );
    }
    if (capacity.present) {
      map['capacity'] = Variable<String>(
        $MorningCheckInsTable.$convertercapacity.toSql(capacity.value),
      );
    }
    if (intention.present) {
      map['intention'] = Variable<String>(intention.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MorningCheckInsCompanion(')
          ..write('dayKey: $dayKey, ')
          ..write('energy: $energy, ')
          ..write('capacity: $capacity, ')
          ..write('intention: $intention, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NightReviewsTable extends NightReviews
    with TableInfo<$NightReviewsTable, NightReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NightReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ratingMeta = const VerificationMeta('rating');
  @override
  late final GeneratedColumn<int> rating = GeneratedColumn<int>(
    'rating',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wentWellTagsMeta = const VerificationMeta(
    'wentWellTags',
  );
  @override
  late final GeneratedColumn<String> wentWellTags = GeneratedColumn<String>(
    'went_well_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _wentWellNoteMeta = const VerificationMeta(
    'wentWellNote',
  );
  @override
  late final GeneratedColumn<String> wentWellNote = GeneratedColumn<String>(
    'went_well_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _betterTagsMeta = const VerificationMeta(
    'betterTags',
  );
  @override
  late final GeneratedColumn<String> betterTags = GeneratedColumn<String>(
    'better_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _betterNoteMeta = const VerificationMeta(
    'betterNote',
  );
  @override
  late final GeneratedColumn<String> betterNote = GeneratedColumn<String>(
    'better_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _biggestWinMeta = const VerificationMeta(
    'biggestWin',
  );
  @override
  late final GeneratedColumn<String> biggestWin = GeneratedColumn<String>(
    'biggest_win',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    dayKey,
    rating,
    wentWellTags,
    wentWellNote,
    betterTags,
    betterNote,
    biggestWin,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'night_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<NightReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('rating')) {
      context.handle(
        _ratingMeta,
        rating.isAcceptableOrUnknown(data['rating']!, _ratingMeta),
      );
    } else if (isInserting) {
      context.missing(_ratingMeta);
    }
    if (data.containsKey('went_well_tags')) {
      context.handle(
        _wentWellTagsMeta,
        wentWellTags.isAcceptableOrUnknown(
          data['went_well_tags']!,
          _wentWellTagsMeta,
        ),
      );
    }
    if (data.containsKey('went_well_note')) {
      context.handle(
        _wentWellNoteMeta,
        wentWellNote.isAcceptableOrUnknown(
          data['went_well_note']!,
          _wentWellNoteMeta,
        ),
      );
    }
    if (data.containsKey('better_tags')) {
      context.handle(
        _betterTagsMeta,
        betterTags.isAcceptableOrUnknown(data['better_tags']!, _betterTagsMeta),
      );
    }
    if (data.containsKey('better_note')) {
      context.handle(
        _betterNoteMeta,
        betterNote.isAcceptableOrUnknown(data['better_note']!, _betterNoteMeta),
      );
    }
    if (data.containsKey('biggest_win')) {
      context.handle(
        _biggestWinMeta,
        biggestWin.isAcceptableOrUnknown(data['biggest_win']!, _biggestWinMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {dayKey};
  @override
  NightReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return NightReview(
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      rating: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}rating'],
      )!,
      wentWellTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well_tags'],
      )!,
      wentWellNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well_note'],
      ),
      betterTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}better_tags'],
      )!,
      betterNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}better_note'],
      ),
      biggestWin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biggest_win'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NightReviewsTable createAlias(String alias) {
    return $NightReviewsTable(attachedDatabase, alias);
  }
}

class NightReview extends DataClass implements Insertable<NightReview> {
  final String dayKey;
  final int rating;
  final String wentWellTags;
  final String? wentWellNote;
  final String betterTags;
  final String? betterNote;
  final String? biggestWin;
  final DateTime createdAt;
  const NightReview({
    required this.dayKey,
    required this.rating,
    required this.wentWellTags,
    this.wentWellNote,
    required this.betterTags,
    this.betterNote,
    this.biggestWin,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['day_key'] = Variable<String>(dayKey);
    map['rating'] = Variable<int>(rating);
    map['went_well_tags'] = Variable<String>(wentWellTags);
    if (!nullToAbsent || wentWellNote != null) {
      map['went_well_note'] = Variable<String>(wentWellNote);
    }
    map['better_tags'] = Variable<String>(betterTags);
    if (!nullToAbsent || betterNote != null) {
      map['better_note'] = Variable<String>(betterNote);
    }
    if (!nullToAbsent || biggestWin != null) {
      map['biggest_win'] = Variable<String>(biggestWin);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NightReviewsCompanion toCompanion(bool nullToAbsent) {
    return NightReviewsCompanion(
      dayKey: Value(dayKey),
      rating: Value(rating),
      wentWellTags: Value(wentWellTags),
      wentWellNote: wentWellNote == null && nullToAbsent
          ? const Value.absent()
          : Value(wentWellNote),
      betterTags: Value(betterTags),
      betterNote: betterNote == null && nullToAbsent
          ? const Value.absent()
          : Value(betterNote),
      biggestWin: biggestWin == null && nullToAbsent
          ? const Value.absent()
          : Value(biggestWin),
      createdAt: Value(createdAt),
    );
  }

  factory NightReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NightReview(
      dayKey: serializer.fromJson<String>(json['dayKey']),
      rating: serializer.fromJson<int>(json['rating']),
      wentWellTags: serializer.fromJson<String>(json['wentWellTags']),
      wentWellNote: serializer.fromJson<String?>(json['wentWellNote']),
      betterTags: serializer.fromJson<String>(json['betterTags']),
      betterNote: serializer.fromJson<String?>(json['betterNote']),
      biggestWin: serializer.fromJson<String?>(json['biggestWin']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'dayKey': serializer.toJson<String>(dayKey),
      'rating': serializer.toJson<int>(rating),
      'wentWellTags': serializer.toJson<String>(wentWellTags),
      'wentWellNote': serializer.toJson<String?>(wentWellNote),
      'betterTags': serializer.toJson<String>(betterTags),
      'betterNote': serializer.toJson<String?>(betterNote),
      'biggestWin': serializer.toJson<String?>(biggestWin),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  NightReview copyWith({
    String? dayKey,
    int? rating,
    String? wentWellTags,
    Value<String?> wentWellNote = const Value.absent(),
    String? betterTags,
    Value<String?> betterNote = const Value.absent(),
    Value<String?> biggestWin = const Value.absent(),
    DateTime? createdAt,
  }) => NightReview(
    dayKey: dayKey ?? this.dayKey,
    rating: rating ?? this.rating,
    wentWellTags: wentWellTags ?? this.wentWellTags,
    wentWellNote: wentWellNote.present ? wentWellNote.value : this.wentWellNote,
    betterTags: betterTags ?? this.betterTags,
    betterNote: betterNote.present ? betterNote.value : this.betterNote,
    biggestWin: biggestWin.present ? biggestWin.value : this.biggestWin,
    createdAt: createdAt ?? this.createdAt,
  );
  NightReview copyWithCompanion(NightReviewsCompanion data) {
    return NightReview(
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      rating: data.rating.present ? data.rating.value : this.rating,
      wentWellTags: data.wentWellTags.present
          ? data.wentWellTags.value
          : this.wentWellTags,
      wentWellNote: data.wentWellNote.present
          ? data.wentWellNote.value
          : this.wentWellNote,
      betterTags: data.betterTags.present
          ? data.betterTags.value
          : this.betterTags,
      betterNote: data.betterNote.present
          ? data.betterNote.value
          : this.betterNote,
      biggestWin: data.biggestWin.present
          ? data.biggestWin.value
          : this.biggestWin,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('NightReview(')
          ..write('dayKey: $dayKey, ')
          ..write('rating: $rating, ')
          ..write('wentWellTags: $wentWellTags, ')
          ..write('wentWellNote: $wentWellNote, ')
          ..write('betterTags: $betterTags, ')
          ..write('betterNote: $betterNote, ')
          ..write('biggestWin: $biggestWin, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    dayKey,
    rating,
    wentWellTags,
    wentWellNote,
    betterTags,
    betterNote,
    biggestWin,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NightReview &&
          other.dayKey == this.dayKey &&
          other.rating == this.rating &&
          other.wentWellTags == this.wentWellTags &&
          other.wentWellNote == this.wentWellNote &&
          other.betterTags == this.betterTags &&
          other.betterNote == this.betterNote &&
          other.biggestWin == this.biggestWin &&
          other.createdAt == this.createdAt);
}

class NightReviewsCompanion extends UpdateCompanion<NightReview> {
  final Value<String> dayKey;
  final Value<int> rating;
  final Value<String> wentWellTags;
  final Value<String?> wentWellNote;
  final Value<String> betterTags;
  final Value<String?> betterNote;
  final Value<String?> biggestWin;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NightReviewsCompanion({
    this.dayKey = const Value.absent(),
    this.rating = const Value.absent(),
    this.wentWellTags = const Value.absent(),
    this.wentWellNote = const Value.absent(),
    this.betterTags = const Value.absent(),
    this.betterNote = const Value.absent(),
    this.biggestWin = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NightReviewsCompanion.insert({
    required String dayKey,
    required int rating,
    this.wentWellTags = const Value.absent(),
    this.wentWellNote = const Value.absent(),
    this.betterTags = const Value.absent(),
    this.betterNote = const Value.absent(),
    this.biggestWin = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : dayKey = Value(dayKey),
       rating = Value(rating),
       createdAt = Value(createdAt);
  static Insertable<NightReview> custom({
    Expression<String>? dayKey,
    Expression<int>? rating,
    Expression<String>? wentWellTags,
    Expression<String>? wentWellNote,
    Expression<String>? betterTags,
    Expression<String>? betterNote,
    Expression<String>? biggestWin,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (dayKey != null) 'day_key': dayKey,
      if (rating != null) 'rating': rating,
      if (wentWellTags != null) 'went_well_tags': wentWellTags,
      if (wentWellNote != null) 'went_well_note': wentWellNote,
      if (betterTags != null) 'better_tags': betterTags,
      if (betterNote != null) 'better_note': betterNote,
      if (biggestWin != null) 'biggest_win': biggestWin,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NightReviewsCompanion copyWith({
    Value<String>? dayKey,
    Value<int>? rating,
    Value<String>? wentWellTags,
    Value<String?>? wentWellNote,
    Value<String>? betterTags,
    Value<String?>? betterNote,
    Value<String?>? biggestWin,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NightReviewsCompanion(
      dayKey: dayKey ?? this.dayKey,
      rating: rating ?? this.rating,
      wentWellTags: wentWellTags ?? this.wentWellTags,
      wentWellNote: wentWellNote ?? this.wentWellNote,
      betterTags: betterTags ?? this.betterTags,
      betterNote: betterNote ?? this.betterNote,
      biggestWin: biggestWin ?? this.biggestWin,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (rating.present) {
      map['rating'] = Variable<int>(rating.value);
    }
    if (wentWellTags.present) {
      map['went_well_tags'] = Variable<String>(wentWellTags.value);
    }
    if (wentWellNote.present) {
      map['went_well_note'] = Variable<String>(wentWellNote.value);
    }
    if (betterTags.present) {
      map['better_tags'] = Variable<String>(betterTags.value);
    }
    if (betterNote.present) {
      map['better_note'] = Variable<String>(betterNote.value);
    }
    if (biggestWin.present) {
      map['biggest_win'] = Variable<String>(biggestWin.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NightReviewsCompanion(')
          ..write('dayKey: $dayKey, ')
          ..write('rating: $rating, ')
          ..write('wentWellTags: $wentWellTags, ')
          ..write('wentWellNote: $wentWellNote, ')
          ..write('betterTags: $betterTags, ')
          ..write('betterNote: $betterNote, ')
          ..write('biggestWin: $biggestWin, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $QuranLogsTable extends QuranLogs
    with TableInfo<$QuranLogsTable, QuranLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $QuranLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<QuranKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<QuranKind>($QuranLogsTable.$converterkind);
  static const VerificationMeta _pagesMeta = const VerificationMeta('pages');
  @override
  late final GeneratedColumn<double> pages = GeneratedColumn<double>(
    'pages',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _surahMeta = const VerificationMeta('surah');
  @override
  late final GeneratedColumn<String> surah = GeneratedColumn<String>(
    'surah',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    pages,
    minutes,
    surah,
    note,
    goalId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'quran_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<QuranLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('pages')) {
      context.handle(
        _pagesMeta,
        pages.isAcceptableOrUnknown(data['pages']!, _pagesMeta),
      );
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    }
    if (data.containsKey('surah')) {
      context.handle(
        _surahMeta,
        surah.isAcceptableOrUnknown(data['surah']!, _surahMeta),
      );
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  QuranLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return QuranLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: $QuranLogsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      pages: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}pages'],
      )!,
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      )!,
      surah: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}surah'],
      ),
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $QuranLogsTable createAlias(String alias) {
    return $QuranLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<QuranKind, String, String> $converterkind =
      const EnumNameConverter<QuranKind>(QuranKind.values);
}

class QuranLog extends DataClass implements Insertable<QuranLog> {
  final String id;
  final QuranKind kind;
  final double pages;
  final int minutes;
  final String? surah;
  final String? note;
  final String? goalId;
  final DateTime occurredAt;
  const QuranLog({
    required this.id,
    required this.kind,
    required this.pages,
    required this.minutes,
    this.surah,
    this.note,
    this.goalId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['kind'] = Variable<String>(
        $QuranLogsTable.$converterkind.toSql(kind),
      );
    }
    map['pages'] = Variable<double>(pages);
    map['minutes'] = Variable<int>(minutes);
    if (!nullToAbsent || surah != null) {
      map['surah'] = Variable<String>(surah);
    }
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  QuranLogsCompanion toCompanion(bool nullToAbsent) {
    return QuranLogsCompanion(
      id: Value(id),
      kind: Value(kind),
      pages: Value(pages),
      minutes: Value(minutes),
      surah: surah == null && nullToAbsent
          ? const Value.absent()
          : Value(surah),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      occurredAt: Value(occurredAt),
    );
  }

  factory QuranLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return QuranLog(
      id: serializer.fromJson<String>(json['id']),
      kind: $QuranLogsTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      pages: serializer.fromJson<double>(json['pages']),
      minutes: serializer.fromJson<int>(json['minutes']),
      surah: serializer.fromJson<String?>(json['surah']),
      note: serializer.fromJson<String?>(json['note']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(
        $QuranLogsTable.$converterkind.toJson(kind),
      ),
      'pages': serializer.toJson<double>(pages),
      'minutes': serializer.toJson<int>(minutes),
      'surah': serializer.toJson<String?>(surah),
      'note': serializer.toJson<String?>(note),
      'goalId': serializer.toJson<String?>(goalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  QuranLog copyWith({
    String? id,
    QuranKind? kind,
    double? pages,
    int? minutes,
    Value<String?> surah = const Value.absent(),
    Value<String?> note = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    DateTime? occurredAt,
  }) => QuranLog(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    pages: pages ?? this.pages,
    minutes: minutes ?? this.minutes,
    surah: surah.present ? surah.value : this.surah,
    note: note.present ? note.value : this.note,
    goalId: goalId.present ? goalId.value : this.goalId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  QuranLog copyWithCompanion(QuranLogsCompanion data) {
    return QuranLog(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      pages: data.pages.present ? data.pages.value : this.pages,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      surah: data.surah.present ? data.surah.value : this.surah,
      note: data.note.present ? data.note.value : this.note,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('QuranLog(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('pages: $pages, ')
          ..write('minutes: $minutes, ')
          ..write('surah: $surah, ')
          ..write('note: $note, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, kind, pages, minutes, surah, note, goalId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is QuranLog &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.pages == this.pages &&
          other.minutes == this.minutes &&
          other.surah == this.surah &&
          other.note == this.note &&
          other.goalId == this.goalId &&
          other.occurredAt == this.occurredAt);
}

class QuranLogsCompanion extends UpdateCompanion<QuranLog> {
  final Value<String> id;
  final Value<QuranKind> kind;
  final Value<double> pages;
  final Value<int> minutes;
  final Value<String?> surah;
  final Value<String?> note;
  final Value<String?> goalId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const QuranLogsCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.pages = const Value.absent(),
    this.minutes = const Value.absent(),
    this.surah = const Value.absent(),
    this.note = const Value.absent(),
    this.goalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  QuranLogsCompanion.insert({
    required String id,
    required QuranKind kind,
    this.pages = const Value.absent(),
    this.minutes = const Value.absent(),
    this.surah = const Value.absent(),
    this.note = const Value.absent(),
    this.goalId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       occurredAt = Value(occurredAt);
  static Insertable<QuranLog> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<double>? pages,
    Expression<int>? minutes,
    Expression<String>? surah,
    Expression<String>? note,
    Expression<String>? goalId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (pages != null) 'pages': pages,
      if (minutes != null) 'minutes': minutes,
      if (surah != null) 'surah': surah,
      if (note != null) 'note': note,
      if (goalId != null) 'goal_id': goalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  QuranLogsCompanion copyWith({
    Value<String>? id,
    Value<QuranKind>? kind,
    Value<double>? pages,
    Value<int>? minutes,
    Value<String?>? surah,
    Value<String?>? note,
    Value<String?>? goalId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return QuranLogsCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      pages: pages ?? this.pages,
      minutes: minutes ?? this.minutes,
      surah: surah ?? this.surah,
      note: note ?? this.note,
      goalId: goalId ?? this.goalId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $QuranLogsTable.$converterkind.toSql(kind.value),
      );
    }
    if (pages.present) {
      map['pages'] = Variable<double>(pages.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (surah.present) {
      map['surah'] = Variable<String>(surah.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('QuranLogsCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('pages: $pages, ')
          ..write('minutes: $minutes, ')
          ..write('surah: $surah, ')
          ..write('note: $note, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkActivitiesTable extends WorkActivities
    with TableInfo<$WorkActivitiesTable, WorkActivity> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkActivitiesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<WorkKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<WorkKind>($WorkActivitiesTable.$converterkind);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _counterpartMeta = const VerificationMeta(
    'counterpart',
  );
  @override
  late final GeneratedColumn<String> counterpart = GeneratedColumn<String>(
    'counterpart',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _valueMinorMeta = const VerificationMeta(
    'valueMinor',
  );
  @override
  late final GeneratedColumn<int> valueMinor = GeneratedColumn<int>(
    'value_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _scheduledAtMeta = const VerificationMeta(
    'scheduledAt',
  );
  @override
  late final GeneratedColumn<DateTime> scheduledAt = GeneratedColumn<DateTime>(
    'scheduled_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    title,
    counterpart,
    detail,
    valueMinor,
    minutes,
    scheduledAt,
    goalId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'work_activities';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkActivity> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('counterpart')) {
      context.handle(
        _counterpartMeta,
        counterpart.isAcceptableOrUnknown(
          data['counterpart']!,
          _counterpartMeta,
        ),
      );
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('value_minor')) {
      context.handle(
        _valueMinorMeta,
        valueMinor.isAcceptableOrUnknown(data['value_minor']!, _valueMinorMeta),
      );
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    }
    if (data.containsKey('scheduled_at')) {
      context.handle(
        _scheduledAtMeta,
        scheduledAt.isAcceptableOrUnknown(
          data['scheduled_at']!,
          _scheduledAtMeta,
        ),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkActivity map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkActivity(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: $WorkActivitiesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      counterpart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}counterpart'],
      ),
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      valueMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}value_minor'],
      ),
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      ),
      scheduledAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}scheduled_at'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $WorkActivitiesTable createAlias(String alias) {
    return $WorkActivitiesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<WorkKind, String, String> $converterkind =
      const EnumNameConverter<WorkKind>(WorkKind.values);
}

class WorkActivity extends DataClass implements Insertable<WorkActivity> {
  final String id;
  final WorkKind kind;
  final String title;
  final String? counterpart;
  final String? detail;
  final int? valueMinor;
  final int? minutes;
  final DateTime? scheduledAt;
  final String? goalId;
  final DateTime occurredAt;
  const WorkActivity({
    required this.id,
    required this.kind,
    required this.title,
    this.counterpart,
    this.detail,
    this.valueMinor,
    this.minutes,
    this.scheduledAt,
    this.goalId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['kind'] = Variable<String>(
        $WorkActivitiesTable.$converterkind.toSql(kind),
      );
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || counterpart != null) {
      map['counterpart'] = Variable<String>(counterpart);
    }
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    if (!nullToAbsent || valueMinor != null) {
      map['value_minor'] = Variable<int>(valueMinor);
    }
    if (!nullToAbsent || minutes != null) {
      map['minutes'] = Variable<int>(minutes);
    }
    if (!nullToAbsent || scheduledAt != null) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  WorkActivitiesCompanion toCompanion(bool nullToAbsent) {
    return WorkActivitiesCompanion(
      id: Value(id),
      kind: Value(kind),
      title: Value(title),
      counterpart: counterpart == null && nullToAbsent
          ? const Value.absent()
          : Value(counterpart),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      valueMinor: valueMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(valueMinor),
      minutes: minutes == null && nullToAbsent
          ? const Value.absent()
          : Value(minutes),
      scheduledAt: scheduledAt == null && nullToAbsent
          ? const Value.absent()
          : Value(scheduledAt),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      occurredAt: Value(occurredAt),
    );
  }

  factory WorkActivity.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkActivity(
      id: serializer.fromJson<String>(json['id']),
      kind: $WorkActivitiesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      title: serializer.fromJson<String>(json['title']),
      counterpart: serializer.fromJson<String?>(json['counterpart']),
      detail: serializer.fromJson<String?>(json['detail']),
      valueMinor: serializer.fromJson<int?>(json['valueMinor']),
      minutes: serializer.fromJson<int?>(json['minutes']),
      scheduledAt: serializer.fromJson<DateTime?>(json['scheduledAt']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(
        $WorkActivitiesTable.$converterkind.toJson(kind),
      ),
      'title': serializer.toJson<String>(title),
      'counterpart': serializer.toJson<String?>(counterpart),
      'detail': serializer.toJson<String?>(detail),
      'valueMinor': serializer.toJson<int?>(valueMinor),
      'minutes': serializer.toJson<int?>(minutes),
      'scheduledAt': serializer.toJson<DateTime?>(scheduledAt),
      'goalId': serializer.toJson<String?>(goalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  WorkActivity copyWith({
    String? id,
    WorkKind? kind,
    String? title,
    Value<String?> counterpart = const Value.absent(),
    Value<String?> detail = const Value.absent(),
    Value<int?> valueMinor = const Value.absent(),
    Value<int?> minutes = const Value.absent(),
    Value<DateTime?> scheduledAt = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    DateTime? occurredAt,
  }) => WorkActivity(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    title: title ?? this.title,
    counterpart: counterpart.present ? counterpart.value : this.counterpart,
    detail: detail.present ? detail.value : this.detail,
    valueMinor: valueMinor.present ? valueMinor.value : this.valueMinor,
    minutes: minutes.present ? minutes.value : this.minutes,
    scheduledAt: scheduledAt.present ? scheduledAt.value : this.scheduledAt,
    goalId: goalId.present ? goalId.value : this.goalId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  WorkActivity copyWithCompanion(WorkActivitiesCompanion data) {
    return WorkActivity(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      title: data.title.present ? data.title.value : this.title,
      counterpart: data.counterpart.present
          ? data.counterpart.value
          : this.counterpart,
      detail: data.detail.present ? data.detail.value : this.detail,
      valueMinor: data.valueMinor.present
          ? data.valueMinor.value
          : this.valueMinor,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      scheduledAt: data.scheduledAt.present
          ? data.scheduledAt.value
          : this.scheduledAt,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkActivity(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('counterpart: $counterpart, ')
          ..write('detail: $detail, ')
          ..write('valueMinor: $valueMinor, ')
          ..write('minutes: $minutes, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    kind,
    title,
    counterpart,
    detail,
    valueMinor,
    minutes,
    scheduledAt,
    goalId,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkActivity &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.title == this.title &&
          other.counterpart == this.counterpart &&
          other.detail == this.detail &&
          other.valueMinor == this.valueMinor &&
          other.minutes == this.minutes &&
          other.scheduledAt == this.scheduledAt &&
          other.goalId == this.goalId &&
          other.occurredAt == this.occurredAt);
}

class WorkActivitiesCompanion extends UpdateCompanion<WorkActivity> {
  final Value<String> id;
  final Value<WorkKind> kind;
  final Value<String> title;
  final Value<String?> counterpart;
  final Value<String?> detail;
  final Value<int?> valueMinor;
  final Value<int?> minutes;
  final Value<DateTime?> scheduledAt;
  final Value<String?> goalId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const WorkActivitiesCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.title = const Value.absent(),
    this.counterpart = const Value.absent(),
    this.detail = const Value.absent(),
    this.valueMinor = const Value.absent(),
    this.minutes = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.goalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkActivitiesCompanion.insert({
    required String id,
    required WorkKind kind,
    required String title,
    this.counterpart = const Value.absent(),
    this.detail = const Value.absent(),
    this.valueMinor = const Value.absent(),
    this.minutes = const Value.absent(),
    this.scheduledAt = const Value.absent(),
    this.goalId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       title = Value(title),
       occurredAt = Value(occurredAt);
  static Insertable<WorkActivity> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<String>? title,
    Expression<String>? counterpart,
    Expression<String>? detail,
    Expression<int>? valueMinor,
    Expression<int>? minutes,
    Expression<DateTime>? scheduledAt,
    Expression<String>? goalId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (title != null) 'title': title,
      if (counterpart != null) 'counterpart': counterpart,
      if (detail != null) 'detail': detail,
      if (valueMinor != null) 'value_minor': valueMinor,
      if (minutes != null) 'minutes': minutes,
      if (scheduledAt != null) 'scheduled_at': scheduledAt,
      if (goalId != null) 'goal_id': goalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkActivitiesCompanion copyWith({
    Value<String>? id,
    Value<WorkKind>? kind,
    Value<String>? title,
    Value<String?>? counterpart,
    Value<String?>? detail,
    Value<int?>? valueMinor,
    Value<int?>? minutes,
    Value<DateTime?>? scheduledAt,
    Value<String?>? goalId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return WorkActivitiesCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      title: title ?? this.title,
      counterpart: counterpart ?? this.counterpart,
      detail: detail ?? this.detail,
      valueMinor: valueMinor ?? this.valueMinor,
      minutes: minutes ?? this.minutes,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      goalId: goalId ?? this.goalId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $WorkActivitiesTable.$converterkind.toSql(kind.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (counterpart.present) {
      map['counterpart'] = Variable<String>(counterpart.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (valueMinor.present) {
      map['value_minor'] = Variable<int>(valueMinor.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (scheduledAt.present) {
      map['scheduled_at'] = Variable<DateTime>(scheduledAt.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkActivitiesCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('title: $title, ')
          ..write('counterpart: $counterpart, ')
          ..write('detail: $detail, ')
          ..write('valueMinor: $valueMinor, ')
          ..write('minutes: $minutes, ')
          ..write('scheduledAt: $scheduledAt, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $FinanceTransactionsTable extends FinanceTransactions
    with TableInfo<$FinanceTransactionsTable, FinanceTransaction> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FinanceTransactionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<TransactionType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<TransactionType>(
        $FinanceTransactionsTable.$convertertype,
      );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _categoryMeta = const VerificationMeta(
    'category',
  );
  @override
  late final GeneratedColumn<String> category = GeneratedColumn<String>(
    'category',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MoneyTag, String> tag =
      GeneratedColumn<String>(
        'tag',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
        defaultValue: const Constant('personal'),
      ).withConverter<MoneyTag>($FinanceTransactionsTable.$convertertag);
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    type,
    amountMinor,
    category,
    note,
    tag,
    goalId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'finance_transactions';
  @override
  VerificationContext validateIntegrity(
    Insertable<FinanceTransaction> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_amountMinorMeta);
    }
    if (data.containsKey('category')) {
      context.handle(
        _categoryMeta,
        category.isAcceptableOrUnknown(data['category']!, _categoryMeta),
      );
    } else if (isInserting) {
      context.missing(_categoryMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FinanceTransaction map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FinanceTransaction(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      type: $FinanceTransactionsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      )!,
      category: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}category'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      tag: $FinanceTransactionsTable.$convertertag.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}tag'],
        )!,
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $FinanceTransactionsTable createAlias(String alias) {
    return $FinanceTransactionsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<TransactionType, String, String> $convertertype =
      const EnumNameConverter<TransactionType>(TransactionType.values);
  static JsonTypeConverter2<MoneyTag, String, String> $convertertag =
      const EnumNameConverter<MoneyTag>(MoneyTag.values);
}

class FinanceTransaction extends DataClass
    implements Insertable<FinanceTransaction> {
  final String id;
  final TransactionType type;
  final int amountMinor;
  final String category;
  final String? note;
  final MoneyTag tag;
  final String? goalId;
  final DateTime occurredAt;
  const FinanceTransaction({
    required this.id,
    required this.type,
    required this.amountMinor,
    required this.category,
    this.note,
    required this.tag,
    this.goalId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['type'] = Variable<String>(
        $FinanceTransactionsTable.$convertertype.toSql(type),
      );
    }
    map['amount_minor'] = Variable<int>(amountMinor);
    map['category'] = Variable<String>(category);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    {
      map['tag'] = Variable<String>(
        $FinanceTransactionsTable.$convertertag.toSql(tag),
      );
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  FinanceTransactionsCompanion toCompanion(bool nullToAbsent) {
    return FinanceTransactionsCompanion(
      id: Value(id),
      type: Value(type),
      amountMinor: Value(amountMinor),
      category: Value(category),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      tag: Value(tag),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      occurredAt: Value(occurredAt),
    );
  }

  factory FinanceTransaction.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FinanceTransaction(
      id: serializer.fromJson<String>(json['id']),
      type: $FinanceTransactionsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      amountMinor: serializer.fromJson<int>(json['amountMinor']),
      category: serializer.fromJson<String>(json['category']),
      note: serializer.fromJson<String?>(json['note']),
      tag: $FinanceTransactionsTable.$convertertag.fromJson(
        serializer.fromJson<String>(json['tag']),
      ),
      goalId: serializer.fromJson<String?>(json['goalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'type': serializer.toJson<String>(
        $FinanceTransactionsTable.$convertertype.toJson(type),
      ),
      'amountMinor': serializer.toJson<int>(amountMinor),
      'category': serializer.toJson<String>(category),
      'note': serializer.toJson<String?>(note),
      'tag': serializer.toJson<String>(
        $FinanceTransactionsTable.$convertertag.toJson(tag),
      ),
      'goalId': serializer.toJson<String?>(goalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  FinanceTransaction copyWith({
    String? id,
    TransactionType? type,
    int? amountMinor,
    String? category,
    Value<String?> note = const Value.absent(),
    MoneyTag? tag,
    Value<String?> goalId = const Value.absent(),
    DateTime? occurredAt,
  }) => FinanceTransaction(
    id: id ?? this.id,
    type: type ?? this.type,
    amountMinor: amountMinor ?? this.amountMinor,
    category: category ?? this.category,
    note: note.present ? note.value : this.note,
    tag: tag ?? this.tag,
    goalId: goalId.present ? goalId.value : this.goalId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  FinanceTransaction copyWithCompanion(FinanceTransactionsCompanion data) {
    return FinanceTransaction(
      id: data.id.present ? data.id.value : this.id,
      type: data.type.present ? data.type.value : this.type,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      category: data.category.present ? data.category.value : this.category,
      note: data.note.present ? data.note.value : this.note,
      tag: data.tag.present ? data.tag.value : this.tag,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FinanceTransaction(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('tag: $tag, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    type,
    amountMinor,
    category,
    note,
    tag,
    goalId,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FinanceTransaction &&
          other.id == this.id &&
          other.type == this.type &&
          other.amountMinor == this.amountMinor &&
          other.category == this.category &&
          other.note == this.note &&
          other.tag == this.tag &&
          other.goalId == this.goalId &&
          other.occurredAt == this.occurredAt);
}

class FinanceTransactionsCompanion extends UpdateCompanion<FinanceTransaction> {
  final Value<String> id;
  final Value<TransactionType> type;
  final Value<int> amountMinor;
  final Value<String> category;
  final Value<String?> note;
  final Value<MoneyTag> tag;
  final Value<String?> goalId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const FinanceTransactionsCompanion({
    this.id = const Value.absent(),
    this.type = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.category = const Value.absent(),
    this.note = const Value.absent(),
    this.tag = const Value.absent(),
    this.goalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FinanceTransactionsCompanion.insert({
    required String id,
    required TransactionType type,
    required int amountMinor,
    required String category,
    this.note = const Value.absent(),
    this.tag = const Value.absent(),
    this.goalId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       amountMinor = Value(amountMinor),
       category = Value(category),
       occurredAt = Value(occurredAt);
  static Insertable<FinanceTransaction> custom({
    Expression<String>? id,
    Expression<String>? type,
    Expression<int>? amountMinor,
    Expression<String>? category,
    Expression<String>? note,
    Expression<String>? tag,
    Expression<String>? goalId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (type != null) 'type': type,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (category != null) 'category': category,
      if (note != null) 'note': note,
      if (tag != null) 'tag': tag,
      if (goalId != null) 'goal_id': goalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FinanceTransactionsCompanion copyWith({
    Value<String>? id,
    Value<TransactionType>? type,
    Value<int>? amountMinor,
    Value<String>? category,
    Value<String?>? note,
    Value<MoneyTag>? tag,
    Value<String?>? goalId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return FinanceTransactionsCompanion(
      id: id ?? this.id,
      type: type ?? this.type,
      amountMinor: amountMinor ?? this.amountMinor,
      category: category ?? this.category,
      note: note ?? this.note,
      tag: tag ?? this.tag,
      goalId: goalId ?? this.goalId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $FinanceTransactionsTable.$convertertype.toSql(type.value),
      );
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (category.present) {
      map['category'] = Variable<String>(category.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (tag.present) {
      map['tag'] = Variable<String>(
        $FinanceTransactionsTable.$convertertag.toSql(tag.value),
      );
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FinanceTransactionsCompanion(')
          ..write('id: $id, ')
          ..write('type: $type, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('category: $category, ')
          ..write('note: $note, ')
          ..write('tag: $tag, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<LifeArea>($HabitsTable.$converterarea);
  static const VerificationMeta _labelMeta = const VerificationMeta('label');
  @override
  late final GeneratedColumn<String> label = GeneratedColumn<String>(
    'label',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reminderMinuteMeta = const VerificationMeta(
    'reminderMinute',
  );
  @override
  late final GeneratedColumn<int> reminderMinute = GeneratedColumn<int>(
    'reminder_minute',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _sortOrderMeta = const VerificationMeta(
    'sortOrder',
  );
  @override
  late final GeneratedColumn<int> sortOrder = GeneratedColumn<int>(
    'sort_order',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    name,
    area,
    label,
    templateId,
    reminderMinute,
    archived,
    sortOrder,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    if (data.containsKey('label')) {
      context.handle(
        _labelMeta,
        label.isAcceptableOrUnknown(data['label']!, _labelMeta),
      );
    }
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    }
    if (data.containsKey('reminder_minute')) {
      context.handle(
        _reminderMinuteMeta,
        reminderMinute.isAcceptableOrUnknown(
          data['reminder_minute']!,
          _reminderMinuteMeta,
        ),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('sort_order')) {
      context.handle(
        _sortOrderMeta,
        sortOrder.isAcceptableOrUnknown(data['sort_order']!, _sortOrderMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
      area: $HabitsTable.$converterarea.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        )!,
      ),
      label: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}label'],
      ),
      templateId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}template_id'],
      ),
      reminderMinute: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}reminder_minute'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      sortOrder: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}sort_order'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeArea, String, String> $converterarea =
      const EnumNameConverter<LifeArea>(LifeArea.values);
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String name;
  final LifeArea area;
  final String? label;

  /// Built-in starter habit id (e.g. `health1`); the name is then localized at
  /// display time. Cleared when the user renames the habit.
  final String? templateId;
  final int? reminderMinute;
  final bool archived;
  final int sortOrder;
  final DateTime createdAt;
  const Habit({
    required this.id,
    required this.name,
    required this.area,
    this.label,
    this.templateId,
    this.reminderMinute,
    required this.archived,
    required this.sortOrder,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    {
      map['area'] = Variable<String>($HabitsTable.$converterarea.toSql(area));
    }
    if (!nullToAbsent || label != null) {
      map['label'] = Variable<String>(label);
    }
    if (!nullToAbsent || templateId != null) {
      map['template_id'] = Variable<String>(templateId);
    }
    if (!nullToAbsent || reminderMinute != null) {
      map['reminder_minute'] = Variable<int>(reminderMinute);
    }
    map['archived'] = Variable<bool>(archived);
    map['sort_order'] = Variable<int>(sortOrder);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      name: Value(name),
      area: Value(area),
      label: label == null && nullToAbsent
          ? const Value.absent()
          : Value(label),
      templateId: templateId == null && nullToAbsent
          ? const Value.absent()
          : Value(templateId),
      reminderMinute: reminderMinute == null && nullToAbsent
          ? const Value.absent()
          : Value(reminderMinute),
      archived: Value(archived),
      sortOrder: Value(sortOrder),
      createdAt: Value(createdAt),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      area: $HabitsTable.$converterarea.fromJson(
        serializer.fromJson<String>(json['area']),
      ),
      label: serializer.fromJson<String?>(json['label']),
      templateId: serializer.fromJson<String?>(json['templateId']),
      reminderMinute: serializer.fromJson<int?>(json['reminderMinute']),
      archived: serializer.fromJson<bool>(json['archived']),
      sortOrder: serializer.fromJson<int>(json['sortOrder']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
      'area': serializer.toJson<String>(
        $HabitsTable.$converterarea.toJson(area),
      ),
      'label': serializer.toJson<String?>(label),
      'templateId': serializer.toJson<String?>(templateId),
      'reminderMinute': serializer.toJson<int?>(reminderMinute),
      'archived': serializer.toJson<bool>(archived),
      'sortOrder': serializer.toJson<int>(sortOrder),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Habit copyWith({
    String? id,
    String? name,
    LifeArea? area,
    Value<String?> label = const Value.absent(),
    Value<String?> templateId = const Value.absent(),
    Value<int?> reminderMinute = const Value.absent(),
    bool? archived,
    int? sortOrder,
    DateTime? createdAt,
  }) => Habit(
    id: id ?? this.id,
    name: name ?? this.name,
    area: area ?? this.area,
    label: label.present ? label.value : this.label,
    templateId: templateId.present ? templateId.value : this.templateId,
    reminderMinute: reminderMinute.present
        ? reminderMinute.value
        : this.reminderMinute,
    archived: archived ?? this.archived,
    sortOrder: sortOrder ?? this.sortOrder,
    createdAt: createdAt ?? this.createdAt,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
      area: data.area.present ? data.area.value : this.area,
      label: data.label.present ? data.label.value : this.label,
      templateId: data.templateId.present
          ? data.templateId.value
          : this.templateId,
      reminderMinute: data.reminderMinute.present
          ? data.reminderMinute.value
          : this.reminderMinute,
      archived: data.archived.present ? data.archived.value : this.archived,
      sortOrder: data.sortOrder.present ? data.sortOrder.value : this.sortOrder,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('area: $area, ')
          ..write('label: $label, ')
          ..write('templateId: $templateId, ')
          ..write('reminderMinute: $reminderMinute, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    area,
    label,
    templateId,
    reminderMinute,
    archived,
    sortOrder,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.name == this.name &&
          other.area == this.area &&
          other.label == this.label &&
          other.templateId == this.templateId &&
          other.reminderMinute == this.reminderMinute &&
          other.archived == this.archived &&
          other.sortOrder == this.sortOrder &&
          other.createdAt == this.createdAt);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> name;
  final Value<LifeArea> area;
  final Value<String?> label;
  final Value<String?> templateId;
  final Value<int?> reminderMinute;
  final Value<bool> archived;
  final Value<int> sortOrder;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.area = const Value.absent(),
    this.label = const Value.absent(),
    this.templateId = const Value.absent(),
    this.reminderMinute = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String name,
    required LifeArea area,
    this.label = const Value.absent(),
    this.templateId = const Value.absent(),
    this.reminderMinute = const Value.absent(),
    this.archived = const Value.absent(),
    this.sortOrder = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name),
       area = Value(area),
       createdAt = Value(createdAt);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<String>? area,
    Expression<String>? label,
    Expression<String>? templateId,
    Expression<int>? reminderMinute,
    Expression<bool>? archived,
    Expression<int>? sortOrder,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (area != null) 'area': area,
      if (label != null) 'label': label,
      if (templateId != null) 'template_id': templateId,
      if (reminderMinute != null) 'reminder_minute': reminderMinute,
      if (archived != null) 'archived': archived,
      if (sortOrder != null) 'sort_order': sortOrder,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<LifeArea>? area,
    Value<String?>? label,
    Value<String?>? templateId,
    Value<int?>? reminderMinute,
    Value<bool>? archived,
    Value<int>? sortOrder,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      area: area ?? this.area,
      label: label ?? this.label,
      templateId: templateId ?? this.templateId,
      reminderMinute: reminderMinute ?? this.reminderMinute,
      archived: archived ?? this.archived,
      sortOrder: sortOrder ?? this.sortOrder,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $HabitsTable.$converterarea.toSql(area.value),
      );
    }
    if (label.present) {
      map['label'] = Variable<String>(label.value);
    }
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (reminderMinute.present) {
      map['reminder_minute'] = Variable<int>(reminderMinute.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (sortOrder.present) {
      map['sort_order'] = Variable<int>(sortOrder.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('area: $area, ')
          ..write('label: $label, ')
          ..write('templateId: $templateId, ')
          ..write('reminderMinute: $reminderMinute, ')
          ..write('archived: $archived, ')
          ..write('sortOrder: $sortOrder, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $HabitLogsTable extends HabitLogs
    with TableInfo<$HabitLogsTable, HabitLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, habitId, dayKey, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habit_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<HabitLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  List<Set<GeneratedColumn>> get uniqueKeys => [
    {habitId, dayKey},
  ];
  @override
  HabitLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return HabitLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $HabitLogsTable createAlias(String alias) {
    return $HabitLogsTable(attachedDatabase, alias);
  }
}

class HabitLog extends DataClass implements Insertable<HabitLog> {
  final String id;
  final String habitId;
  final String dayKey;
  final DateTime createdAt;
  const HabitLog({
    required this.id,
    required this.habitId,
    required this.dayKey,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['day_key'] = Variable<String>(dayKey);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  HabitLogsCompanion toCompanion(bool nullToAbsent) {
    return HabitLogsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      dayKey: Value(dayKey),
      createdAt: Value(createdAt),
    );
  }

  factory HabitLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return HabitLog(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'dayKey': serializer.toJson<String>(dayKey),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  HabitLog copyWith({
    String? id,
    String? habitId,
    String? dayKey,
    DateTime? createdAt,
  }) => HabitLog(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    dayKey: dayKey ?? this.dayKey,
    createdAt: createdAt ?? this.createdAt,
  );
  HabitLog copyWithCompanion(HabitLogsCompanion data) {
    return HabitLog(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('HabitLog(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('dayKey: $dayKey, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, habitId, dayKey, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is HabitLog &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.dayKey == this.dayKey &&
          other.createdAt == this.createdAt);
}

class HabitLogsCompanion extends UpdateCompanion<HabitLog> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<String> dayKey;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const HabitLogsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitLogsCompanion.insert({
    required String id,
    required String habitId,
    required String dayKey,
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       dayKey = Value(dayKey),
       createdAt = Value(createdAt);
  static Insertable<HabitLog> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<String>? dayKey,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (dayKey != null) 'day_key': dayKey,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<String>? dayKey,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return HabitLogsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      dayKey: dayKey ?? this.dayKey,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitLogsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('dayKey: $dayKey, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WorkoutLogsTable extends WorkoutLogs
    with TableInfo<$WorkoutLogsTable, WorkoutLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WorkoutLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _detailMeta = const VerificationMeta('detail');
  @override
  late final GeneratedColumn<String> detail = GeneratedColumn<String>(
    'detail',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    minutes,
    detail,
    goalId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'workout_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WorkoutLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    } else if (isInserting) {
      context.missing(_minutesMeta);
    }
    if (data.containsKey('detail')) {
      context.handle(
        _detailMeta,
        detail.isAcceptableOrUnknown(data['detail']!, _detailMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WorkoutLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WorkoutLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      )!,
      detail: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}detail'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $WorkoutLogsTable createAlias(String alias) {
    return $WorkoutLogsTable(attachedDatabase, alias);
  }
}

class WorkoutLog extends DataClass implements Insertable<WorkoutLog> {
  final String id;
  final String title;
  final int minutes;
  final String? detail;
  final String? goalId;
  final DateTime occurredAt;
  const WorkoutLog({
    required this.id,
    required this.title,
    required this.minutes,
    this.detail,
    this.goalId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['minutes'] = Variable<int>(minutes);
    if (!nullToAbsent || detail != null) {
      map['detail'] = Variable<String>(detail);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  WorkoutLogsCompanion toCompanion(bool nullToAbsent) {
    return WorkoutLogsCompanion(
      id: Value(id),
      title: Value(title),
      minutes: Value(minutes),
      detail: detail == null && nullToAbsent
          ? const Value.absent()
          : Value(detail),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      occurredAt: Value(occurredAt),
    );
  }

  factory WorkoutLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WorkoutLog(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      minutes: serializer.fromJson<int>(json['minutes']),
      detail: serializer.fromJson<String?>(json['detail']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'minutes': serializer.toJson<int>(minutes),
      'detail': serializer.toJson<String?>(detail),
      'goalId': serializer.toJson<String?>(goalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  WorkoutLog copyWith({
    String? id,
    String? title,
    int? minutes,
    Value<String?> detail = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    DateTime? occurredAt,
  }) => WorkoutLog(
    id: id ?? this.id,
    title: title ?? this.title,
    minutes: minutes ?? this.minutes,
    detail: detail.present ? detail.value : this.detail,
    goalId: goalId.present ? goalId.value : this.goalId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  WorkoutLog copyWithCompanion(WorkoutLogsCompanion data) {
    return WorkoutLog(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      detail: data.detail.present ? data.detail.value : this.detail,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLog(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('minutes: $minutes, ')
          ..write('detail: $detail, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, title, minutes, detail, goalId, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WorkoutLog &&
          other.id == this.id &&
          other.title == this.title &&
          other.minutes == this.minutes &&
          other.detail == this.detail &&
          other.goalId == this.goalId &&
          other.occurredAt == this.occurredAt);
}

class WorkoutLogsCompanion extends UpdateCompanion<WorkoutLog> {
  final Value<String> id;
  final Value<String> title;
  final Value<int> minutes;
  final Value<String?> detail;
  final Value<String?> goalId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const WorkoutLogsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.minutes = const Value.absent(),
    this.detail = const Value.absent(),
    this.goalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WorkoutLogsCompanion.insert({
    required String id,
    required String title,
    required int minutes,
    this.detail = const Value.absent(),
    this.goalId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       minutes = Value(minutes),
       occurredAt = Value(occurredAt);
  static Insertable<WorkoutLog> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<int>? minutes,
    Expression<String>? detail,
    Expression<String>? goalId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (minutes != null) 'minutes': minutes,
      if (detail != null) 'detail': detail,
      if (goalId != null) 'goal_id': goalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WorkoutLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<int>? minutes,
    Value<String?>? detail,
    Value<String?>? goalId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return WorkoutLogsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      minutes: minutes ?? this.minutes,
      detail: detail ?? this.detail,
      goalId: goalId ?? this.goalId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (detail.present) {
      map['detail'] = Variable<String>(detail.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WorkoutLogsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('minutes: $minutes, ')
          ..write('detail: $detail, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WalkingLogsTable extends WalkingLogs
    with TableInfo<$WalkingLogsTable, WalkingLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WalkingLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stepsMeta = const VerificationMeta('steps');
  @override
  late final GeneratedColumn<int> steps = GeneratedColumn<int>(
    'steps',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, minutes, steps, occurredAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'walking_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<WalkingLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    } else if (isInserting) {
      context.missing(_minutesMeta);
    }
    if (data.containsKey('steps')) {
      context.handle(
        _stepsMeta,
        steps.isAcceptableOrUnknown(data['steps']!, _stepsMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  WalkingLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WalkingLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      )!,
      steps: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}steps'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $WalkingLogsTable createAlias(String alias) {
    return $WalkingLogsTable(attachedDatabase, alias);
  }
}

class WalkingLog extends DataClass implements Insertable<WalkingLog> {
  final String id;
  final int minutes;
  final int? steps;
  final DateTime occurredAt;
  const WalkingLog({
    required this.id,
    required this.minutes,
    this.steps,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['minutes'] = Variable<int>(minutes);
    if (!nullToAbsent || steps != null) {
      map['steps'] = Variable<int>(steps);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  WalkingLogsCompanion toCompanion(bool nullToAbsent) {
    return WalkingLogsCompanion(
      id: Value(id),
      minutes: Value(minutes),
      steps: steps == null && nullToAbsent
          ? const Value.absent()
          : Value(steps),
      occurredAt: Value(occurredAt),
    );
  }

  factory WalkingLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WalkingLog(
      id: serializer.fromJson<String>(json['id']),
      minutes: serializer.fromJson<int>(json['minutes']),
      steps: serializer.fromJson<int?>(json['steps']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'minutes': serializer.toJson<int>(minutes),
      'steps': serializer.toJson<int?>(steps),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  WalkingLog copyWith({
    String? id,
    int? minutes,
    Value<int?> steps = const Value.absent(),
    DateTime? occurredAt,
  }) => WalkingLog(
    id: id ?? this.id,
    minutes: minutes ?? this.minutes,
    steps: steps.present ? steps.value : this.steps,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  WalkingLog copyWithCompanion(WalkingLogsCompanion data) {
    return WalkingLog(
      id: data.id.present ? data.id.value : this.id,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      steps: data.steps.present ? data.steps.value : this.steps,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WalkingLog(')
          ..write('id: $id, ')
          ..write('minutes: $minutes, ')
          ..write('steps: $steps, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, minutes, steps, occurredAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WalkingLog &&
          other.id == this.id &&
          other.minutes == this.minutes &&
          other.steps == this.steps &&
          other.occurredAt == this.occurredAt);
}

class WalkingLogsCompanion extends UpdateCompanion<WalkingLog> {
  final Value<String> id;
  final Value<int> minutes;
  final Value<int?> steps;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const WalkingLogsCompanion({
    this.id = const Value.absent(),
    this.minutes = const Value.absent(),
    this.steps = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WalkingLogsCompanion.insert({
    required String id,
    required int minutes,
    this.steps = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       minutes = Value(minutes),
       occurredAt = Value(occurredAt);
  static Insertable<WalkingLog> custom({
    Expression<String>? id,
    Expression<int>? minutes,
    Expression<int>? steps,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (minutes != null) 'minutes': minutes,
      if (steps != null) 'steps': steps,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WalkingLogsCompanion copyWith({
    Value<String>? id,
    Value<int>? minutes,
    Value<int?>? steps,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return WalkingLogsCompanion(
      id: id ?? this.id,
      minutes: minutes ?? this.minutes,
      steps: steps ?? this.steps,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (steps.present) {
      map['steps'] = Variable<int>(steps.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WalkingLogsCompanion(')
          ..write('id: $id, ')
          ..write('minutes: $minutes, ')
          ..write('steps: $steps, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $SleepLogsTable extends SleepLogs
    with TableInfo<$SleepLogsTable, SleepLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SleepLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayKeyMeta = const VerificationMeta('dayKey');
  @override
  late final GeneratedColumn<String> dayKey = GeneratedColumn<String>(
    'day_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bedTimeMeta = const VerificationMeta(
    'bedTime',
  );
  @override
  late final GeneratedColumn<DateTime> bedTime = GeneratedColumn<DateTime>(
    'bed_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wakeTimeMeta = const VerificationMeta(
    'wakeTime',
  );
  @override
  late final GeneratedColumn<DateTime> wakeTime = GeneratedColumn<DateTime>(
    'wake_time',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<Energy?, String> energy =
      GeneratedColumn<String>(
        'energy',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<Energy?>($SleepLogsTable.$converterenergyn);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    dayKey,
    bedTime,
    wakeTime,
    energy,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'sleep_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<SleepLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('day_key')) {
      context.handle(
        _dayKeyMeta,
        dayKey.isAcceptableOrUnknown(data['day_key']!, _dayKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_dayKeyMeta);
    }
    if (data.containsKey('bed_time')) {
      context.handle(
        _bedTimeMeta,
        bedTime.isAcceptableOrUnknown(data['bed_time']!, _bedTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_bedTimeMeta);
    }
    if (data.containsKey('wake_time')) {
      context.handle(
        _wakeTimeMeta,
        wakeTime.isAcceptableOrUnknown(data['wake_time']!, _wakeTimeMeta),
      );
    } else if (isInserting) {
      context.missing(_wakeTimeMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  SleepLog map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return SleepLog(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      dayKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day_key'],
      )!,
      bedTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}bed_time'],
      )!,
      wakeTime: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}wake_time'],
      )!,
      energy: $SleepLogsTable.$converterenergyn.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}energy'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $SleepLogsTable createAlias(String alias) {
    return $SleepLogsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<Energy, String, String> $converterenergy =
      const EnumNameConverter<Energy>(Energy.values);
  static JsonTypeConverter2<Energy?, String?, String?> $converterenergyn =
      JsonTypeConverter2.asNullable($converterenergy);
}

class SleepLog extends DataClass implements Insertable<SleepLog> {
  final String id;
  final String dayKey;
  final DateTime bedTime;
  final DateTime wakeTime;
  final Energy? energy;
  final DateTime createdAt;
  const SleepLog({
    required this.id,
    required this.dayKey,
    required this.bedTime,
    required this.wakeTime,
    this.energy,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['day_key'] = Variable<String>(dayKey);
    map['bed_time'] = Variable<DateTime>(bedTime);
    map['wake_time'] = Variable<DateTime>(wakeTime);
    if (!nullToAbsent || energy != null) {
      map['energy'] = Variable<String>(
        $SleepLogsTable.$converterenergyn.toSql(energy),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  SleepLogsCompanion toCompanion(bool nullToAbsent) {
    return SleepLogsCompanion(
      id: Value(id),
      dayKey: Value(dayKey),
      bedTime: Value(bedTime),
      wakeTime: Value(wakeTime),
      energy: energy == null && nullToAbsent
          ? const Value.absent()
          : Value(energy),
      createdAt: Value(createdAt),
    );
  }

  factory SleepLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return SleepLog(
      id: serializer.fromJson<String>(json['id']),
      dayKey: serializer.fromJson<String>(json['dayKey']),
      bedTime: serializer.fromJson<DateTime>(json['bedTime']),
      wakeTime: serializer.fromJson<DateTime>(json['wakeTime']),
      energy: $SleepLogsTable.$converterenergyn.fromJson(
        serializer.fromJson<String?>(json['energy']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'dayKey': serializer.toJson<String>(dayKey),
      'bedTime': serializer.toJson<DateTime>(bedTime),
      'wakeTime': serializer.toJson<DateTime>(wakeTime),
      'energy': serializer.toJson<String?>(
        $SleepLogsTable.$converterenergyn.toJson(energy),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  SleepLog copyWith({
    String? id,
    String? dayKey,
    DateTime? bedTime,
    DateTime? wakeTime,
    Value<Energy?> energy = const Value.absent(),
    DateTime? createdAt,
  }) => SleepLog(
    id: id ?? this.id,
    dayKey: dayKey ?? this.dayKey,
    bedTime: bedTime ?? this.bedTime,
    wakeTime: wakeTime ?? this.wakeTime,
    energy: energy.present ? energy.value : this.energy,
    createdAt: createdAt ?? this.createdAt,
  );
  SleepLog copyWithCompanion(SleepLogsCompanion data) {
    return SleepLog(
      id: data.id.present ? data.id.value : this.id,
      dayKey: data.dayKey.present ? data.dayKey.value : this.dayKey,
      bedTime: data.bedTime.present ? data.bedTime.value : this.bedTime,
      wakeTime: data.wakeTime.present ? data.wakeTime.value : this.wakeTime,
      energy: data.energy.present ? data.energy.value : this.energy,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('SleepLog(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('energy: $energy, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, dayKey, bedTime, wakeTime, energy, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is SleepLog &&
          other.id == this.id &&
          other.dayKey == this.dayKey &&
          other.bedTime == this.bedTime &&
          other.wakeTime == this.wakeTime &&
          other.energy == this.energy &&
          other.createdAt == this.createdAt);
}

class SleepLogsCompanion extends UpdateCompanion<SleepLog> {
  final Value<String> id;
  final Value<String> dayKey;
  final Value<DateTime> bedTime;
  final Value<DateTime> wakeTime;
  final Value<Energy?> energy;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const SleepLogsCompanion({
    this.id = const Value.absent(),
    this.dayKey = const Value.absent(),
    this.bedTime = const Value.absent(),
    this.wakeTime = const Value.absent(),
    this.energy = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  SleepLogsCompanion.insert({
    required String id,
    required String dayKey,
    required DateTime bedTime,
    required DateTime wakeTime,
    this.energy = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       dayKey = Value(dayKey),
       bedTime = Value(bedTime),
       wakeTime = Value(wakeTime),
       createdAt = Value(createdAt);
  static Insertable<SleepLog> custom({
    Expression<String>? id,
    Expression<String>? dayKey,
    Expression<DateTime>? bedTime,
    Expression<DateTime>? wakeTime,
    Expression<String>? energy,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (dayKey != null) 'day_key': dayKey,
      if (bedTime != null) 'bed_time': bedTime,
      if (wakeTime != null) 'wake_time': wakeTime,
      if (energy != null) 'energy': energy,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  SleepLogsCompanion copyWith({
    Value<String>? id,
    Value<String>? dayKey,
    Value<DateTime>? bedTime,
    Value<DateTime>? wakeTime,
    Value<Energy?>? energy,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return SleepLogsCompanion(
      id: id ?? this.id,
      dayKey: dayKey ?? this.dayKey,
      bedTime: bedTime ?? this.bedTime,
      wakeTime: wakeTime ?? this.wakeTime,
      energy: energy ?? this.energy,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (dayKey.present) {
      map['day_key'] = Variable<String>(dayKey.value);
    }
    if (bedTime.present) {
      map['bed_time'] = Variable<DateTime>(bedTime.value);
    }
    if (wakeTime.present) {
      map['wake_time'] = Variable<DateTime>(wakeTime.value);
    }
    if (energy.present) {
      map['energy'] = Variable<String>(
        $SleepLogsTable.$converterenergyn.toSql(energy.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SleepLogsCompanion(')
          ..write('id: $id, ')
          ..write('dayKey: $dayKey, ')
          ..write('bedTime: $bedTime, ')
          ..write('wakeTime: $wakeTime, ')
          ..write('energy: $energy, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningResourcesTable extends LearningResources
    with TableInfo<$LearningResourcesTable, LearningResource> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningResourcesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ResourceKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ResourceKind>($LearningResourcesTable.$converterkind);
  static const VerificationMeta _totalUnitsMeta = const VerificationMeta(
    'totalUnits',
  );
  @override
  late final GeneratedColumn<int> totalUnits = GeneratedColumn<int>(
    'total_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _completedUnitsMeta = const VerificationMeta(
    'completedUnits',
  );
  @override
  late final GeneratedColumn<int> completedUnits = GeneratedColumn<int>(
    'completed_units',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _skillMeta = const VerificationMeta('skill');
  @override
  late final GeneratedColumn<String> skill = GeneratedColumn<String>(
    'skill',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _archivedMeta = const VerificationMeta(
    'archived',
  );
  @override
  late final GeneratedColumn<bool> archived = GeneratedColumn<bool>(
    'archived',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("archived" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    kind,
    totalUnits,
    completedUnits,
    skill,
    archived,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_resources';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningResource> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('total_units')) {
      context.handle(
        _totalUnitsMeta,
        totalUnits.isAcceptableOrUnknown(data['total_units']!, _totalUnitsMeta),
      );
    } else if (isInserting) {
      context.missing(_totalUnitsMeta);
    }
    if (data.containsKey('completed_units')) {
      context.handle(
        _completedUnitsMeta,
        completedUnits.isAcceptableOrUnknown(
          data['completed_units']!,
          _completedUnitsMeta,
        ),
      );
    }
    if (data.containsKey('skill')) {
      context.handle(
        _skillMeta,
        skill.isAcceptableOrUnknown(data['skill']!, _skillMeta),
      );
    }
    if (data.containsKey('archived')) {
      context.handle(
        _archivedMeta,
        archived.isAcceptableOrUnknown(data['archived']!, _archivedMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningResource map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningResource(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      kind: $LearningResourcesTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      totalUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}total_units'],
      )!,
      completedUnits: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}completed_units'],
      )!,
      skill: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill'],
      ),
      archived: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}archived'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $LearningResourcesTable createAlias(String alias) {
    return $LearningResourcesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ResourceKind, String, String> $converterkind =
      const EnumNameConverter<ResourceKind>(ResourceKind.values);
}

class LearningResource extends DataClass
    implements Insertable<LearningResource> {
  final String id;
  final String title;
  final ResourceKind kind;
  final int totalUnits;
  final int completedUnits;
  final String? skill;
  final bool archived;
  final DateTime createdAt;
  const LearningResource({
    required this.id,
    required this.title,
    required this.kind,
    required this.totalUnits,
    required this.completedUnits,
    this.skill,
    required this.archived,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    {
      map['kind'] = Variable<String>(
        $LearningResourcesTable.$converterkind.toSql(kind),
      );
    }
    map['total_units'] = Variable<int>(totalUnits);
    map['completed_units'] = Variable<int>(completedUnits);
    if (!nullToAbsent || skill != null) {
      map['skill'] = Variable<String>(skill);
    }
    map['archived'] = Variable<bool>(archived);
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  LearningResourcesCompanion toCompanion(bool nullToAbsent) {
    return LearningResourcesCompanion(
      id: Value(id),
      title: Value(title),
      kind: Value(kind),
      totalUnits: Value(totalUnits),
      completedUnits: Value(completedUnits),
      skill: skill == null && nullToAbsent
          ? const Value.absent()
          : Value(skill),
      archived: Value(archived),
      createdAt: Value(createdAt),
    );
  }

  factory LearningResource.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningResource(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      kind: $LearningResourcesTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      totalUnits: serializer.fromJson<int>(json['totalUnits']),
      completedUnits: serializer.fromJson<int>(json['completedUnits']),
      skill: serializer.fromJson<String?>(json['skill']),
      archived: serializer.fromJson<bool>(json['archived']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'kind': serializer.toJson<String>(
        $LearningResourcesTable.$converterkind.toJson(kind),
      ),
      'totalUnits': serializer.toJson<int>(totalUnits),
      'completedUnits': serializer.toJson<int>(completedUnits),
      'skill': serializer.toJson<String?>(skill),
      'archived': serializer.toJson<bool>(archived),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  LearningResource copyWith({
    String? id,
    String? title,
    ResourceKind? kind,
    int? totalUnits,
    int? completedUnits,
    Value<String?> skill = const Value.absent(),
    bool? archived,
    DateTime? createdAt,
  }) => LearningResource(
    id: id ?? this.id,
    title: title ?? this.title,
    kind: kind ?? this.kind,
    totalUnits: totalUnits ?? this.totalUnits,
    completedUnits: completedUnits ?? this.completedUnits,
    skill: skill.present ? skill.value : this.skill,
    archived: archived ?? this.archived,
    createdAt: createdAt ?? this.createdAt,
  );
  LearningResource copyWithCompanion(LearningResourcesCompanion data) {
    return LearningResource(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      kind: data.kind.present ? data.kind.value : this.kind,
      totalUnits: data.totalUnits.present
          ? data.totalUnits.value
          : this.totalUnits,
      completedUnits: data.completedUnits.present
          ? data.completedUnits.value
          : this.completedUnits,
      skill: data.skill.present ? data.skill.value : this.skill,
      archived: data.archived.present ? data.archived.value : this.archived,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningResource(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('totalUnits: $totalUnits, ')
          ..write('completedUnits: $completedUnits, ')
          ..write('skill: $skill, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    kind,
    totalUnits,
    completedUnits,
    skill,
    archived,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningResource &&
          other.id == this.id &&
          other.title == this.title &&
          other.kind == this.kind &&
          other.totalUnits == this.totalUnits &&
          other.completedUnits == this.completedUnits &&
          other.skill == this.skill &&
          other.archived == this.archived &&
          other.createdAt == this.createdAt);
}

class LearningResourcesCompanion extends UpdateCompanion<LearningResource> {
  final Value<String> id;
  final Value<String> title;
  final Value<ResourceKind> kind;
  final Value<int> totalUnits;
  final Value<int> completedUnits;
  final Value<String?> skill;
  final Value<bool> archived;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const LearningResourcesCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.kind = const Value.absent(),
    this.totalUnits = const Value.absent(),
    this.completedUnits = const Value.absent(),
    this.skill = const Value.absent(),
    this.archived = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningResourcesCompanion.insert({
    required String id,
    required String title,
    required ResourceKind kind,
    required int totalUnits,
    this.completedUnits = const Value.absent(),
    this.skill = const Value.absent(),
    this.archived = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       kind = Value(kind),
       totalUnits = Value(totalUnits),
       createdAt = Value(createdAt);
  static Insertable<LearningResource> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? kind,
    Expression<int>? totalUnits,
    Expression<int>? completedUnits,
    Expression<String>? skill,
    Expression<bool>? archived,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (kind != null) 'kind': kind,
      if (totalUnits != null) 'total_units': totalUnits,
      if (completedUnits != null) 'completed_units': completedUnits,
      if (skill != null) 'skill': skill,
      if (archived != null) 'archived': archived,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningResourcesCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<ResourceKind>? kind,
    Value<int>? totalUnits,
    Value<int>? completedUnits,
    Value<String?>? skill,
    Value<bool>? archived,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return LearningResourcesCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      kind: kind ?? this.kind,
      totalUnits: totalUnits ?? this.totalUnits,
      completedUnits: completedUnits ?? this.completedUnits,
      skill: skill ?? this.skill,
      archived: archived ?? this.archived,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $LearningResourcesTable.$converterkind.toSql(kind.value),
      );
    }
    if (totalUnits.present) {
      map['total_units'] = Variable<int>(totalUnits.value);
    }
    if (completedUnits.present) {
      map['completed_units'] = Variable<int>(completedUnits.value);
    }
    if (skill.present) {
      map['skill'] = Variable<String>(skill.value);
    }
    if (archived.present) {
      map['archived'] = Variable<bool>(archived.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningResourcesCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('kind: $kind, ')
          ..write('totalUnits: $totalUnits, ')
          ..write('completedUnits: $completedUnits, ')
          ..write('skill: $skill, ')
          ..write('archived: $archived, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $LearningSessionsTable extends LearningSessions
    with TableInfo<$LearningSessionsTable, LearningSession> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LearningSessionsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _topicMeta = const VerificationMeta('topic');
  @override
  late final GeneratedColumn<String> topic = GeneratedColumn<String>(
    'topic',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _skillMeta = const VerificationMeta('skill');
  @override
  late final GeneratedColumn<String> skill = GeneratedColumn<String>(
    'skill',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _minutesMeta = const VerificationMeta(
    'minutes',
  );
  @override
  late final GeneratedColumn<int> minutes = GeneratedColumn<int>(
    'minutes',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _resourceIdMeta = const VerificationMeta(
    'resourceId',
  );
  @override
  late final GeneratedColumn<String> resourceId = GeneratedColumn<String>(
    'resource_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES learning_resources (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _takeawayMeta = const VerificationMeta(
    'takeaway',
  );
  @override
  late final GeneratedColumn<String> takeaway = GeneratedColumn<String>(
    'takeaway',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _goalIdMeta = const VerificationMeta('goalId');
  @override
  late final GeneratedColumn<String> goalId = GeneratedColumn<String>(
    'goal_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES goals (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    topic,
    skill,
    minutes,
    resourceId,
    takeaway,
    goalId,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'learning_sessions';
  @override
  VerificationContext validateIntegrity(
    Insertable<LearningSession> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('topic')) {
      context.handle(
        _topicMeta,
        topic.isAcceptableOrUnknown(data['topic']!, _topicMeta),
      );
    } else if (isInserting) {
      context.missing(_topicMeta);
    }
    if (data.containsKey('skill')) {
      context.handle(
        _skillMeta,
        skill.isAcceptableOrUnknown(data['skill']!, _skillMeta),
      );
    }
    if (data.containsKey('minutes')) {
      context.handle(
        _minutesMeta,
        minutes.isAcceptableOrUnknown(data['minutes']!, _minutesMeta),
      );
    } else if (isInserting) {
      context.missing(_minutesMeta);
    }
    if (data.containsKey('resource_id')) {
      context.handle(
        _resourceIdMeta,
        resourceId.isAcceptableOrUnknown(data['resource_id']!, _resourceIdMeta),
      );
    }
    if (data.containsKey('takeaway')) {
      context.handle(
        _takeawayMeta,
        takeaway.isAcceptableOrUnknown(data['takeaway']!, _takeawayMeta),
      );
    }
    if (data.containsKey('goal_id')) {
      context.handle(
        _goalIdMeta,
        goalId.isAcceptableOrUnknown(data['goal_id']!, _goalIdMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LearningSession map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LearningSession(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      topic: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}topic'],
      )!,
      skill: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}skill'],
      ),
      minutes: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minutes'],
      )!,
      resourceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}resource_id'],
      ),
      takeaway: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}takeaway'],
      ),
      goalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}goal_id'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $LearningSessionsTable createAlias(String alias) {
    return $LearningSessionsTable(attachedDatabase, alias);
  }
}

class LearningSession extends DataClass implements Insertable<LearningSession> {
  final String id;
  final String topic;
  final String? skill;
  final int minutes;
  final String? resourceId;
  final String? takeaway;
  final String? goalId;
  final DateTime occurredAt;
  const LearningSession({
    required this.id,
    required this.topic,
    this.skill,
    required this.minutes,
    this.resourceId,
    this.takeaway,
    this.goalId,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['topic'] = Variable<String>(topic);
    if (!nullToAbsent || skill != null) {
      map['skill'] = Variable<String>(skill);
    }
    map['minutes'] = Variable<int>(minutes);
    if (!nullToAbsent || resourceId != null) {
      map['resource_id'] = Variable<String>(resourceId);
    }
    if (!nullToAbsent || takeaway != null) {
      map['takeaway'] = Variable<String>(takeaway);
    }
    if (!nullToAbsent || goalId != null) {
      map['goal_id'] = Variable<String>(goalId);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  LearningSessionsCompanion toCompanion(bool nullToAbsent) {
    return LearningSessionsCompanion(
      id: Value(id),
      topic: Value(topic),
      skill: skill == null && nullToAbsent
          ? const Value.absent()
          : Value(skill),
      minutes: Value(minutes),
      resourceId: resourceId == null && nullToAbsent
          ? const Value.absent()
          : Value(resourceId),
      takeaway: takeaway == null && nullToAbsent
          ? const Value.absent()
          : Value(takeaway),
      goalId: goalId == null && nullToAbsent
          ? const Value.absent()
          : Value(goalId),
      occurredAt: Value(occurredAt),
    );
  }

  factory LearningSession.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LearningSession(
      id: serializer.fromJson<String>(json['id']),
      topic: serializer.fromJson<String>(json['topic']),
      skill: serializer.fromJson<String?>(json['skill']),
      minutes: serializer.fromJson<int>(json['minutes']),
      resourceId: serializer.fromJson<String?>(json['resourceId']),
      takeaway: serializer.fromJson<String?>(json['takeaway']),
      goalId: serializer.fromJson<String?>(json['goalId']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'topic': serializer.toJson<String>(topic),
      'skill': serializer.toJson<String?>(skill),
      'minutes': serializer.toJson<int>(minutes),
      'resourceId': serializer.toJson<String?>(resourceId),
      'takeaway': serializer.toJson<String?>(takeaway),
      'goalId': serializer.toJson<String?>(goalId),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  LearningSession copyWith({
    String? id,
    String? topic,
    Value<String?> skill = const Value.absent(),
    int? minutes,
    Value<String?> resourceId = const Value.absent(),
    Value<String?> takeaway = const Value.absent(),
    Value<String?> goalId = const Value.absent(),
    DateTime? occurredAt,
  }) => LearningSession(
    id: id ?? this.id,
    topic: topic ?? this.topic,
    skill: skill.present ? skill.value : this.skill,
    minutes: minutes ?? this.minutes,
    resourceId: resourceId.present ? resourceId.value : this.resourceId,
    takeaway: takeaway.present ? takeaway.value : this.takeaway,
    goalId: goalId.present ? goalId.value : this.goalId,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  LearningSession copyWithCompanion(LearningSessionsCompanion data) {
    return LearningSession(
      id: data.id.present ? data.id.value : this.id,
      topic: data.topic.present ? data.topic.value : this.topic,
      skill: data.skill.present ? data.skill.value : this.skill,
      minutes: data.minutes.present ? data.minutes.value : this.minutes,
      resourceId: data.resourceId.present
          ? data.resourceId.value
          : this.resourceId,
      takeaway: data.takeaway.present ? data.takeaway.value : this.takeaway,
      goalId: data.goalId.present ? data.goalId.value : this.goalId,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('LearningSession(')
          ..write('id: $id, ')
          ..write('topic: $topic, ')
          ..write('skill: $skill, ')
          ..write('minutes: $minutes, ')
          ..write('resourceId: $resourceId, ')
          ..write('takeaway: $takeaway, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    topic,
    skill,
    minutes,
    resourceId,
    takeaway,
    goalId,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LearningSession &&
          other.id == this.id &&
          other.topic == this.topic &&
          other.skill == this.skill &&
          other.minutes == this.minutes &&
          other.resourceId == this.resourceId &&
          other.takeaway == this.takeaway &&
          other.goalId == this.goalId &&
          other.occurredAt == this.occurredAt);
}

class LearningSessionsCompanion extends UpdateCompanion<LearningSession> {
  final Value<String> id;
  final Value<String> topic;
  final Value<String?> skill;
  final Value<int> minutes;
  final Value<String?> resourceId;
  final Value<String?> takeaway;
  final Value<String?> goalId;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const LearningSessionsCompanion({
    this.id = const Value.absent(),
    this.topic = const Value.absent(),
    this.skill = const Value.absent(),
    this.minutes = const Value.absent(),
    this.resourceId = const Value.absent(),
    this.takeaway = const Value.absent(),
    this.goalId = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  LearningSessionsCompanion.insert({
    required String id,
    required String topic,
    this.skill = const Value.absent(),
    required int minutes,
    this.resourceId = const Value.absent(),
    this.takeaway = const Value.absent(),
    this.goalId = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       topic = Value(topic),
       minutes = Value(minutes),
       occurredAt = Value(occurredAt);
  static Insertable<LearningSession> custom({
    Expression<String>? id,
    Expression<String>? topic,
    Expression<String>? skill,
    Expression<int>? minutes,
    Expression<String>? resourceId,
    Expression<String>? takeaway,
    Expression<String>? goalId,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (topic != null) 'topic': topic,
      if (skill != null) 'skill': skill,
      if (minutes != null) 'minutes': minutes,
      if (resourceId != null) 'resource_id': resourceId,
      if (takeaway != null) 'takeaway': takeaway,
      if (goalId != null) 'goal_id': goalId,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  LearningSessionsCompanion copyWith({
    Value<String>? id,
    Value<String>? topic,
    Value<String?>? skill,
    Value<int>? minutes,
    Value<String?>? resourceId,
    Value<String?>? takeaway,
    Value<String?>? goalId,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return LearningSessionsCompanion(
      id: id ?? this.id,
      topic: topic ?? this.topic,
      skill: skill ?? this.skill,
      minutes: minutes ?? this.minutes,
      resourceId: resourceId ?? this.resourceId,
      takeaway: takeaway ?? this.takeaway,
      goalId: goalId ?? this.goalId,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (topic.present) {
      map['topic'] = Variable<String>(topic.value);
    }
    if (skill.present) {
      map['skill'] = Variable<String>(skill.value);
    }
    if (minutes.present) {
      map['minutes'] = Variable<int>(minutes.value);
    }
    if (resourceId.present) {
      map['resource_id'] = Variable<String>(resourceId.value);
    }
    if (takeaway.present) {
      map['takeaway'] = Variable<String>(takeaway.value);
    }
    if (goalId.present) {
      map['goal_id'] = Variable<String>(goalId.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LearningSessionsCompanion(')
          ..write('id: $id, ')
          ..write('topic: $topic, ')
          ..write('skill: $skill, ')
          ..write('minutes: $minutes, ')
          ..write('resourceId: $resourceId, ')
          ..write('takeaway: $takeaway, ')
          ..write('goalId: $goalId, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $NotesTable extends Notes with TableInfo<$NotesTable, Note> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $NotesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _bodyMeta = const VerificationMeta('body');
  @override
  late final GeneratedColumn<String> body = GeneratedColumn<String>(
    'body',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea?, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<LifeArea?>($NotesTable.$converterarean);
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, body, area, createdAt];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'notes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Note> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('body')) {
      context.handle(
        _bodyMeta,
        body.isAcceptableOrUnknown(data['body']!, _bodyMeta),
      );
    } else if (isInserting) {
      context.missing(_bodyMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Note map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Note(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      body: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}body'],
      )!,
      area: $NotesTable.$converterarean.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        ),
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $NotesTable createAlias(String alias) {
    return $NotesTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeArea, String, String> $converterarea =
      const EnumNameConverter<LifeArea>(LifeArea.values);
  static JsonTypeConverter2<LifeArea?, String?, String?> $converterarean =
      JsonTypeConverter2.asNullable($converterarea);
}

class Note extends DataClass implements Insertable<Note> {
  final String id;
  final String body;
  final LifeArea? area;
  final DateTime createdAt;
  const Note({
    required this.id,
    required this.body,
    this.area,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['body'] = Variable<String>(body);
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>($NotesTable.$converterarean.toSql(area));
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  NotesCompanion toCompanion(bool nullToAbsent) {
    return NotesCompanion(
      id: Value(id),
      body: Value(body),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      createdAt: Value(createdAt),
    );
  }

  factory Note.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Note(
      id: serializer.fromJson<String>(json['id']),
      body: serializer.fromJson<String>(json['body']),
      area: $NotesTable.$converterarean.fromJson(
        serializer.fromJson<String?>(json['area']),
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'body': serializer.toJson<String>(body),
      'area': serializer.toJson<String?>(
        $NotesTable.$converterarean.toJson(area),
      ),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  Note copyWith({
    String? id,
    String? body,
    Value<LifeArea?> area = const Value.absent(),
    DateTime? createdAt,
  }) => Note(
    id: id ?? this.id,
    body: body ?? this.body,
    area: area.present ? area.value : this.area,
    createdAt: createdAt ?? this.createdAt,
  );
  Note copyWithCompanion(NotesCompanion data) {
    return Note(
      id: data.id.present ? data.id.value : this.id,
      body: data.body.present ? data.body.value : this.body,
      area: data.area.present ? data.area.value : this.area,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Note(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('area: $area, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, body, area, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Note &&
          other.id == this.id &&
          other.body == this.body &&
          other.area == this.area &&
          other.createdAt == this.createdAt);
}

class NotesCompanion extends UpdateCompanion<Note> {
  final Value<String> id;
  final Value<String> body;
  final Value<LifeArea?> area;
  final Value<DateTime> createdAt;
  final Value<int> rowid;
  const NotesCompanion({
    this.id = const Value.absent(),
    this.body = const Value.absent(),
    this.area = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  NotesCompanion.insert({
    required String id,
    required String body,
    this.area = const Value.absent(),
    required DateTime createdAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       body = Value(body),
       createdAt = Value(createdAt);
  static Insertable<Note> custom({
    Expression<String>? id,
    Expression<String>? body,
    Expression<String>? area,
    Expression<DateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (body != null) 'body': body,
      if (area != null) 'area': area,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  NotesCompanion copyWith({
    Value<String>? id,
    Value<String>? body,
    Value<LifeArea?>? area,
    Value<DateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return NotesCompanion(
      id: id ?? this.id,
      body: body ?? this.body,
      area: area ?? this.area,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (body.present) {
      map['body'] = Variable<String>(body.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $NotesTable.$converterarean.toSql(area.value),
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesCompanion(')
          ..write('id: $id, ')
          ..write('body: $body, ')
          ..write('area: $area, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $WeeklyReviewsTable extends WeeklyReviews
    with TableInfo<$WeeklyReviewsTable, WeeklyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $WeeklyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _weekStartMeta = const VerificationMeta(
    'weekStart',
  );
  @override
  late final GeneratedColumn<String> weekStart = GeneratedColumn<String>(
    'week_start',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _wentWellTagsMeta = const VerificationMeta(
    'wentWellTags',
  );
  @override
  late final GeneratedColumn<String> wentWellTags = GeneratedColumn<String>(
    'went_well_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _wentWellNoteMeta = const VerificationMeta(
    'wentWellNote',
  );
  @override
  late final GeneratedColumn<String> wentWellNote = GeneratedColumn<String>(
    'went_well_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _changeTagsMeta = const VerificationMeta(
    'changeTags',
  );
  @override
  late final GeneratedColumn<String> changeTags = GeneratedColumn<String>(
    'change_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _changeNoteMeta = const VerificationMeta(
    'changeNote',
  );
  @override
  late final GeneratedColumn<String> changeNote = GeneratedColumn<String>(
    'change_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _biggestWinMeta = const VerificationMeta(
    'biggestWin',
  );
  @override
  late final GeneratedColumn<String> biggestWin = GeneratedColumn<String>(
    'biggest_win',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prioritiesMeta = const VerificationMeta(
    'priorities',
  );
  @override
  late final GeneratedColumn<String> priorities = GeneratedColumn<String>(
    'priorities',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    weekStart,
    wentWellTags,
    wentWellNote,
    changeTags,
    changeNote,
    biggestWin,
    priorities,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'weekly_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<WeeklyReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('week_start')) {
      context.handle(
        _weekStartMeta,
        weekStart.isAcceptableOrUnknown(data['week_start']!, _weekStartMeta),
      );
    } else if (isInserting) {
      context.missing(_weekStartMeta);
    }
    if (data.containsKey('went_well_tags')) {
      context.handle(
        _wentWellTagsMeta,
        wentWellTags.isAcceptableOrUnknown(
          data['went_well_tags']!,
          _wentWellTagsMeta,
        ),
      );
    }
    if (data.containsKey('went_well_note')) {
      context.handle(
        _wentWellNoteMeta,
        wentWellNote.isAcceptableOrUnknown(
          data['went_well_note']!,
          _wentWellNoteMeta,
        ),
      );
    }
    if (data.containsKey('change_tags')) {
      context.handle(
        _changeTagsMeta,
        changeTags.isAcceptableOrUnknown(data['change_tags']!, _changeTagsMeta),
      );
    }
    if (data.containsKey('change_note')) {
      context.handle(
        _changeNoteMeta,
        changeNote.isAcceptableOrUnknown(data['change_note']!, _changeNoteMeta),
      );
    }
    if (data.containsKey('biggest_win')) {
      context.handle(
        _biggestWinMeta,
        biggestWin.isAcceptableOrUnknown(data['biggest_win']!, _biggestWinMeta),
      );
    }
    if (data.containsKey('priorities')) {
      context.handle(
        _prioritiesMeta,
        priorities.isAcceptableOrUnknown(data['priorities']!, _prioritiesMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {weekStart};
  @override
  WeeklyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return WeeklyReview(
      weekStart: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}week_start'],
      )!,
      wentWellTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well_tags'],
      )!,
      wentWellNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}went_well_note'],
      ),
      changeTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_tags'],
      )!,
      changeNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}change_note'],
      ),
      biggestWin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}biggest_win'],
      ),
      priorities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priorities'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $WeeklyReviewsTable createAlias(String alias) {
    return $WeeklyReviewsTable(attachedDatabase, alias);
  }
}

class WeeklyReview extends DataClass implements Insertable<WeeklyReview> {
  final String weekStart;
  final String wentWellTags;
  final String? wentWellNote;
  final String changeTags;
  final String? changeNote;
  final String? biggestWin;
  final String priorities;
  final DateTime? completedAt;
  final DateTime updatedAt;
  const WeeklyReview({
    required this.weekStart,
    required this.wentWellTags,
    this.wentWellNote,
    required this.changeTags,
    this.changeNote,
    this.biggestWin,
    required this.priorities,
    this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['week_start'] = Variable<String>(weekStart);
    map['went_well_tags'] = Variable<String>(wentWellTags);
    if (!nullToAbsent || wentWellNote != null) {
      map['went_well_note'] = Variable<String>(wentWellNote);
    }
    map['change_tags'] = Variable<String>(changeTags);
    if (!nullToAbsent || changeNote != null) {
      map['change_note'] = Variable<String>(changeNote);
    }
    if (!nullToAbsent || biggestWin != null) {
      map['biggest_win'] = Variable<String>(biggestWin);
    }
    map['priorities'] = Variable<String>(priorities);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  WeeklyReviewsCompanion toCompanion(bool nullToAbsent) {
    return WeeklyReviewsCompanion(
      weekStart: Value(weekStart),
      wentWellTags: Value(wentWellTags),
      wentWellNote: wentWellNote == null && nullToAbsent
          ? const Value.absent()
          : Value(wentWellNote),
      changeTags: Value(changeTags),
      changeNote: changeNote == null && nullToAbsent
          ? const Value.absent()
          : Value(changeNote),
      biggestWin: biggestWin == null && nullToAbsent
          ? const Value.absent()
          : Value(biggestWin),
      priorities: Value(priorities),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory WeeklyReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return WeeklyReview(
      weekStart: serializer.fromJson<String>(json['weekStart']),
      wentWellTags: serializer.fromJson<String>(json['wentWellTags']),
      wentWellNote: serializer.fromJson<String?>(json['wentWellNote']),
      changeTags: serializer.fromJson<String>(json['changeTags']),
      changeNote: serializer.fromJson<String?>(json['changeNote']),
      biggestWin: serializer.fromJson<String?>(json['biggestWin']),
      priorities: serializer.fromJson<String>(json['priorities']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'weekStart': serializer.toJson<String>(weekStart),
      'wentWellTags': serializer.toJson<String>(wentWellTags),
      'wentWellNote': serializer.toJson<String?>(wentWellNote),
      'changeTags': serializer.toJson<String>(changeTags),
      'changeNote': serializer.toJson<String?>(changeNote),
      'biggestWin': serializer.toJson<String?>(biggestWin),
      'priorities': serializer.toJson<String>(priorities),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  WeeklyReview copyWith({
    String? weekStart,
    String? wentWellTags,
    Value<String?> wentWellNote = const Value.absent(),
    String? changeTags,
    Value<String?> changeNote = const Value.absent(),
    Value<String?> biggestWin = const Value.absent(),
    String? priorities,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => WeeklyReview(
    weekStart: weekStart ?? this.weekStart,
    wentWellTags: wentWellTags ?? this.wentWellTags,
    wentWellNote: wentWellNote.present ? wentWellNote.value : this.wentWellNote,
    changeTags: changeTags ?? this.changeTags,
    changeNote: changeNote.present ? changeNote.value : this.changeNote,
    biggestWin: biggestWin.present ? biggestWin.value : this.biggestWin,
    priorities: priorities ?? this.priorities,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  WeeklyReview copyWithCompanion(WeeklyReviewsCompanion data) {
    return WeeklyReview(
      weekStart: data.weekStart.present ? data.weekStart.value : this.weekStart,
      wentWellTags: data.wentWellTags.present
          ? data.wentWellTags.value
          : this.wentWellTags,
      wentWellNote: data.wentWellNote.present
          ? data.wentWellNote.value
          : this.wentWellNote,
      changeTags: data.changeTags.present
          ? data.changeTags.value
          : this.changeTags,
      changeNote: data.changeNote.present
          ? data.changeNote.value
          : this.changeNote,
      biggestWin: data.biggestWin.present
          ? data.biggestWin.value
          : this.biggestWin,
      priorities: data.priorities.present
          ? data.priorities.value
          : this.priorities,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReview(')
          ..write('weekStart: $weekStart, ')
          ..write('wentWellTags: $wentWellTags, ')
          ..write('wentWellNote: $wentWellNote, ')
          ..write('changeTags: $changeTags, ')
          ..write('changeNote: $changeNote, ')
          ..write('biggestWin: $biggestWin, ')
          ..write('priorities: $priorities, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    weekStart,
    wentWellTags,
    wentWellNote,
    changeTags,
    changeNote,
    biggestWin,
    priorities,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is WeeklyReview &&
          other.weekStart == this.weekStart &&
          other.wentWellTags == this.wentWellTags &&
          other.wentWellNote == this.wentWellNote &&
          other.changeTags == this.changeTags &&
          other.changeNote == this.changeNote &&
          other.biggestWin == this.biggestWin &&
          other.priorities == this.priorities &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class WeeklyReviewsCompanion extends UpdateCompanion<WeeklyReview> {
  final Value<String> weekStart;
  final Value<String> wentWellTags;
  final Value<String?> wentWellNote;
  final Value<String> changeTags;
  final Value<String?> changeNote;
  final Value<String?> biggestWin;
  final Value<String> priorities;
  final Value<DateTime?> completedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const WeeklyReviewsCompanion({
    this.weekStart = const Value.absent(),
    this.wentWellTags = const Value.absent(),
    this.wentWellNote = const Value.absent(),
    this.changeTags = const Value.absent(),
    this.changeNote = const Value.absent(),
    this.biggestWin = const Value.absent(),
    this.priorities = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  WeeklyReviewsCompanion.insert({
    required String weekStart,
    this.wentWellTags = const Value.absent(),
    this.wentWellNote = const Value.absent(),
    this.changeTags = const Value.absent(),
    this.changeNote = const Value.absent(),
    this.biggestWin = const Value.absent(),
    this.priorities = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : weekStart = Value(weekStart),
       updatedAt = Value(updatedAt);
  static Insertable<WeeklyReview> custom({
    Expression<String>? weekStart,
    Expression<String>? wentWellTags,
    Expression<String>? wentWellNote,
    Expression<String>? changeTags,
    Expression<String>? changeNote,
    Expression<String>? biggestWin,
    Expression<String>? priorities,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (weekStart != null) 'week_start': weekStart,
      if (wentWellTags != null) 'went_well_tags': wentWellTags,
      if (wentWellNote != null) 'went_well_note': wentWellNote,
      if (changeTags != null) 'change_tags': changeTags,
      if (changeNote != null) 'change_note': changeNote,
      if (biggestWin != null) 'biggest_win': biggestWin,
      if (priorities != null) 'priorities': priorities,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  WeeklyReviewsCompanion copyWith({
    Value<String>? weekStart,
    Value<String>? wentWellTags,
    Value<String?>? wentWellNote,
    Value<String>? changeTags,
    Value<String?>? changeNote,
    Value<String?>? biggestWin,
    Value<String>? priorities,
    Value<DateTime?>? completedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return WeeklyReviewsCompanion(
      weekStart: weekStart ?? this.weekStart,
      wentWellTags: wentWellTags ?? this.wentWellTags,
      wentWellNote: wentWellNote ?? this.wentWellNote,
      changeTags: changeTags ?? this.changeTags,
      changeNote: changeNote ?? this.changeNote,
      biggestWin: biggestWin ?? this.biggestWin,
      priorities: priorities ?? this.priorities,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (weekStart.present) {
      map['week_start'] = Variable<String>(weekStart.value);
    }
    if (wentWellTags.present) {
      map['went_well_tags'] = Variable<String>(wentWellTags.value);
    }
    if (wentWellNote.present) {
      map['went_well_note'] = Variable<String>(wentWellNote.value);
    }
    if (changeTags.present) {
      map['change_tags'] = Variable<String>(changeTags.value);
    }
    if (changeNote.present) {
      map['change_note'] = Variable<String>(changeNote.value);
    }
    if (biggestWin.present) {
      map['biggest_win'] = Variable<String>(biggestWin.value);
    }
    if (priorities.present) {
      map['priorities'] = Variable<String>(priorities.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('WeeklyReviewsCompanion(')
          ..write('weekStart: $weekStart, ')
          ..write('wentWellTags: $wentWellTags, ')
          ..write('wentWellNote: $wentWellNote, ')
          ..write('changeTags: $changeTags, ')
          ..write('changeNote: $changeNote, ')
          ..write('biggestWin: $biggestWin, ')
          ..write('priorities: $priorities, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $MonthlyReviewsTable extends MonthlyReviews
    with TableInfo<$MonthlyReviewsTable, MonthlyReview> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MonthlyReviewsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _monthKeyMeta = const VerificationMeta(
    'monthKey',
  );
  @override
  late final GeneratedColumn<String> monthKey = GeneratedColumn<String>(
    'month_key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _proudTagsMeta = const VerificationMeta(
    'proudTags',
  );
  @override
  late final GeneratedColumn<String> proudTags = GeneratedColumn<String>(
    'proud_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _proudNoteMeta = const VerificationMeta(
    'proudNote',
  );
  @override
  late final GeneratedColumn<String> proudNote = GeneratedColumn<String>(
    'proud_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _heldBackTagsMeta = const VerificationMeta(
    'heldBackTags',
  );
  @override
  late final GeneratedColumn<String> heldBackTags = GeneratedColumn<String>(
    'held_back_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _heldBackNoteMeta = const VerificationMeta(
    'heldBackNote',
  );
  @override
  late final GeneratedColumn<String> heldBackNote = GeneratedColumn<String>(
    'held_back_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _differentTagsMeta = const VerificationMeta(
    'differentTags',
  );
  @override
  late final GeneratedColumn<String> differentTags = GeneratedColumn<String>(
    'different_tags',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _differentNoteMeta = const VerificationMeta(
    'differentNote',
  );
  @override
  late final GeneratedColumn<String> differentNote = GeneratedColumn<String>(
    'different_note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _lessonMeta = const VerificationMeta('lesson');
  @override
  late final GeneratedColumn<String> lesson = GeneratedColumn<String>(
    'lesson',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _prioritiesMeta = const VerificationMeta(
    'priorities',
  );
  @override
  late final GeneratedColumn<String> priorities = GeneratedColumn<String>(
    'priorities',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('[]'),
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    monthKey,
    proudTags,
    proudNote,
    heldBackTags,
    heldBackNote,
    differentTags,
    differentNote,
    lesson,
    priorities,
    completedAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'monthly_reviews';
  @override
  VerificationContext validateIntegrity(
    Insertable<MonthlyReview> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('month_key')) {
      context.handle(
        _monthKeyMeta,
        monthKey.isAcceptableOrUnknown(data['month_key']!, _monthKeyMeta),
      );
    } else if (isInserting) {
      context.missing(_monthKeyMeta);
    }
    if (data.containsKey('proud_tags')) {
      context.handle(
        _proudTagsMeta,
        proudTags.isAcceptableOrUnknown(data['proud_tags']!, _proudTagsMeta),
      );
    }
    if (data.containsKey('proud_note')) {
      context.handle(
        _proudNoteMeta,
        proudNote.isAcceptableOrUnknown(data['proud_note']!, _proudNoteMeta),
      );
    }
    if (data.containsKey('held_back_tags')) {
      context.handle(
        _heldBackTagsMeta,
        heldBackTags.isAcceptableOrUnknown(
          data['held_back_tags']!,
          _heldBackTagsMeta,
        ),
      );
    }
    if (data.containsKey('held_back_note')) {
      context.handle(
        _heldBackNoteMeta,
        heldBackNote.isAcceptableOrUnknown(
          data['held_back_note']!,
          _heldBackNoteMeta,
        ),
      );
    }
    if (data.containsKey('different_tags')) {
      context.handle(
        _differentTagsMeta,
        differentTags.isAcceptableOrUnknown(
          data['different_tags']!,
          _differentTagsMeta,
        ),
      );
    }
    if (data.containsKey('different_note')) {
      context.handle(
        _differentNoteMeta,
        differentNote.isAcceptableOrUnknown(
          data['different_note']!,
          _differentNoteMeta,
        ),
      );
    }
    if (data.containsKey('lesson')) {
      context.handle(
        _lessonMeta,
        lesson.isAcceptableOrUnknown(data['lesson']!, _lessonMeta),
      );
    }
    if (data.containsKey('priorities')) {
      context.handle(
        _prioritiesMeta,
        priorities.isAcceptableOrUnknown(data['priorities']!, _prioritiesMeta),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {monthKey};
  @override
  MonthlyReview map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MonthlyReview(
      monthKey: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}month_key'],
      )!,
      proudTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proud_tags'],
      )!,
      proudNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}proud_note'],
      ),
      heldBackTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}held_back_tags'],
      )!,
      heldBackNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}held_back_note'],
      ),
      differentTags: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}different_tags'],
      )!,
      differentNote: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}different_note'],
      ),
      lesson: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}lesson'],
      ),
      priorities: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}priorities'],
      )!,
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
      ),
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $MonthlyReviewsTable createAlias(String alias) {
    return $MonthlyReviewsTable(attachedDatabase, alias);
  }
}

class MonthlyReview extends DataClass implements Insertable<MonthlyReview> {
  final String monthKey;
  final String proudTags;
  final String? proudNote;
  final String heldBackTags;
  final String? heldBackNote;
  final String differentTags;
  final String? differentNote;
  final String? lesson;
  final String priorities;
  final DateTime? completedAt;
  final DateTime updatedAt;
  const MonthlyReview({
    required this.monthKey,
    required this.proudTags,
    this.proudNote,
    required this.heldBackTags,
    this.heldBackNote,
    required this.differentTags,
    this.differentNote,
    this.lesson,
    required this.priorities,
    this.completedAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['month_key'] = Variable<String>(monthKey);
    map['proud_tags'] = Variable<String>(proudTags);
    if (!nullToAbsent || proudNote != null) {
      map['proud_note'] = Variable<String>(proudNote);
    }
    map['held_back_tags'] = Variable<String>(heldBackTags);
    if (!nullToAbsent || heldBackNote != null) {
      map['held_back_note'] = Variable<String>(heldBackNote);
    }
    map['different_tags'] = Variable<String>(differentTags);
    if (!nullToAbsent || differentNote != null) {
      map['different_note'] = Variable<String>(differentNote);
    }
    if (!nullToAbsent || lesson != null) {
      map['lesson'] = Variable<String>(lesson);
    }
    map['priorities'] = Variable<String>(priorities);
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MonthlyReviewsCompanion toCompanion(bool nullToAbsent) {
    return MonthlyReviewsCompanion(
      monthKey: Value(monthKey),
      proudTags: Value(proudTags),
      proudNote: proudNote == null && nullToAbsent
          ? const Value.absent()
          : Value(proudNote),
      heldBackTags: Value(heldBackTags),
      heldBackNote: heldBackNote == null && nullToAbsent
          ? const Value.absent()
          : Value(heldBackNote),
      differentTags: Value(differentTags),
      differentNote: differentNote == null && nullToAbsent
          ? const Value.absent()
          : Value(differentNote),
      lesson: lesson == null && nullToAbsent
          ? const Value.absent()
          : Value(lesson),
      priorities: Value(priorities),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MonthlyReview.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MonthlyReview(
      monthKey: serializer.fromJson<String>(json['monthKey']),
      proudTags: serializer.fromJson<String>(json['proudTags']),
      proudNote: serializer.fromJson<String?>(json['proudNote']),
      heldBackTags: serializer.fromJson<String>(json['heldBackTags']),
      heldBackNote: serializer.fromJson<String?>(json['heldBackNote']),
      differentTags: serializer.fromJson<String>(json['differentTags']),
      differentNote: serializer.fromJson<String?>(json['differentNote']),
      lesson: serializer.fromJson<String?>(json['lesson']),
      priorities: serializer.fromJson<String>(json['priorities']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'monthKey': serializer.toJson<String>(monthKey),
      'proudTags': serializer.toJson<String>(proudTags),
      'proudNote': serializer.toJson<String?>(proudNote),
      'heldBackTags': serializer.toJson<String>(heldBackTags),
      'heldBackNote': serializer.toJson<String?>(heldBackNote),
      'differentTags': serializer.toJson<String>(differentTags),
      'differentNote': serializer.toJson<String?>(differentNote),
      'lesson': serializer.toJson<String?>(lesson),
      'priorities': serializer.toJson<String>(priorities),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MonthlyReview copyWith({
    String? monthKey,
    String? proudTags,
    Value<String?> proudNote = const Value.absent(),
    String? heldBackTags,
    Value<String?> heldBackNote = const Value.absent(),
    String? differentTags,
    Value<String?> differentNote = const Value.absent(),
    Value<String?> lesson = const Value.absent(),
    String? priorities,
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? updatedAt,
  }) => MonthlyReview(
    monthKey: monthKey ?? this.monthKey,
    proudTags: proudTags ?? this.proudTags,
    proudNote: proudNote.present ? proudNote.value : this.proudNote,
    heldBackTags: heldBackTags ?? this.heldBackTags,
    heldBackNote: heldBackNote.present ? heldBackNote.value : this.heldBackNote,
    differentTags: differentTags ?? this.differentTags,
    differentNote: differentNote.present
        ? differentNote.value
        : this.differentNote,
    lesson: lesson.present ? lesson.value : this.lesson,
    priorities: priorities ?? this.priorities,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MonthlyReview copyWithCompanion(MonthlyReviewsCompanion data) {
    return MonthlyReview(
      monthKey: data.monthKey.present ? data.monthKey.value : this.monthKey,
      proudTags: data.proudTags.present ? data.proudTags.value : this.proudTags,
      proudNote: data.proudNote.present ? data.proudNote.value : this.proudNote,
      heldBackTags: data.heldBackTags.present
          ? data.heldBackTags.value
          : this.heldBackTags,
      heldBackNote: data.heldBackNote.present
          ? data.heldBackNote.value
          : this.heldBackNote,
      differentTags: data.differentTags.present
          ? data.differentTags.value
          : this.differentTags,
      differentNote: data.differentNote.present
          ? data.differentNote.value
          : this.differentNote,
      lesson: data.lesson.present ? data.lesson.value : this.lesson,
      priorities: data.priorities.present
          ? data.priorities.value
          : this.priorities,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReview(')
          ..write('monthKey: $monthKey, ')
          ..write('proudTags: $proudTags, ')
          ..write('proudNote: $proudNote, ')
          ..write('heldBackTags: $heldBackTags, ')
          ..write('heldBackNote: $heldBackNote, ')
          ..write('differentTags: $differentTags, ')
          ..write('differentNote: $differentNote, ')
          ..write('lesson: $lesson, ')
          ..write('priorities: $priorities, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    monthKey,
    proudTags,
    proudNote,
    heldBackTags,
    heldBackNote,
    differentTags,
    differentNote,
    lesson,
    priorities,
    completedAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MonthlyReview &&
          other.monthKey == this.monthKey &&
          other.proudTags == this.proudTags &&
          other.proudNote == this.proudNote &&
          other.heldBackTags == this.heldBackTags &&
          other.heldBackNote == this.heldBackNote &&
          other.differentTags == this.differentTags &&
          other.differentNote == this.differentNote &&
          other.lesson == this.lesson &&
          other.priorities == this.priorities &&
          other.completedAt == this.completedAt &&
          other.updatedAt == this.updatedAt);
}

class MonthlyReviewsCompanion extends UpdateCompanion<MonthlyReview> {
  final Value<String> monthKey;
  final Value<String> proudTags;
  final Value<String?> proudNote;
  final Value<String> heldBackTags;
  final Value<String?> heldBackNote;
  final Value<String> differentTags;
  final Value<String?> differentNote;
  final Value<String?> lesson;
  final Value<String> priorities;
  final Value<DateTime?> completedAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const MonthlyReviewsCompanion({
    this.monthKey = const Value.absent(),
    this.proudTags = const Value.absent(),
    this.proudNote = const Value.absent(),
    this.heldBackTags = const Value.absent(),
    this.heldBackNote = const Value.absent(),
    this.differentTags = const Value.absent(),
    this.differentNote = const Value.absent(),
    this.lesson = const Value.absent(),
    this.priorities = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  MonthlyReviewsCompanion.insert({
    required String monthKey,
    this.proudTags = const Value.absent(),
    this.proudNote = const Value.absent(),
    this.heldBackTags = const Value.absent(),
    this.heldBackNote = const Value.absent(),
    this.differentTags = const Value.absent(),
    this.differentNote = const Value.absent(),
    this.lesson = const Value.absent(),
    this.priorities = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime updatedAt,
    this.rowid = const Value.absent(),
  }) : monthKey = Value(monthKey),
       updatedAt = Value(updatedAt);
  static Insertable<MonthlyReview> custom({
    Expression<String>? monthKey,
    Expression<String>? proudTags,
    Expression<String>? proudNote,
    Expression<String>? heldBackTags,
    Expression<String>? heldBackNote,
    Expression<String>? differentTags,
    Expression<String>? differentNote,
    Expression<String>? lesson,
    Expression<String>? priorities,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (monthKey != null) 'month_key': monthKey,
      if (proudTags != null) 'proud_tags': proudTags,
      if (proudNote != null) 'proud_note': proudNote,
      if (heldBackTags != null) 'held_back_tags': heldBackTags,
      if (heldBackNote != null) 'held_back_note': heldBackNote,
      if (differentTags != null) 'different_tags': differentTags,
      if (differentNote != null) 'different_note': differentNote,
      if (lesson != null) 'lesson': lesson,
      if (priorities != null) 'priorities': priorities,
      if (completedAt != null) 'completed_at': completedAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  MonthlyReviewsCompanion copyWith({
    Value<String>? monthKey,
    Value<String>? proudTags,
    Value<String?>? proudNote,
    Value<String>? heldBackTags,
    Value<String?>? heldBackNote,
    Value<String>? differentTags,
    Value<String?>? differentNote,
    Value<String?>? lesson,
    Value<String>? priorities,
    Value<DateTime?>? completedAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return MonthlyReviewsCompanion(
      monthKey: monthKey ?? this.monthKey,
      proudTags: proudTags ?? this.proudTags,
      proudNote: proudNote ?? this.proudNote,
      heldBackTags: heldBackTags ?? this.heldBackTags,
      heldBackNote: heldBackNote ?? this.heldBackNote,
      differentTags: differentTags ?? this.differentTags,
      differentNote: differentNote ?? this.differentNote,
      lesson: lesson ?? this.lesson,
      priorities: priorities ?? this.priorities,
      completedAt: completedAt ?? this.completedAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (monthKey.present) {
      map['month_key'] = Variable<String>(monthKey.value);
    }
    if (proudTags.present) {
      map['proud_tags'] = Variable<String>(proudTags.value);
    }
    if (proudNote.present) {
      map['proud_note'] = Variable<String>(proudNote.value);
    }
    if (heldBackTags.present) {
      map['held_back_tags'] = Variable<String>(heldBackTags.value);
    }
    if (heldBackNote.present) {
      map['held_back_note'] = Variable<String>(heldBackNote.value);
    }
    if (differentTags.present) {
      map['different_tags'] = Variable<String>(differentTags.value);
    }
    if (differentNote.present) {
      map['different_note'] = Variable<String>(differentNote.value);
    }
    if (lesson.present) {
      map['lesson'] = Variable<String>(lesson.value);
    }
    if (priorities.present) {
      map['priorities'] = Variable<String>(priorities.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MonthlyReviewsCompanion(')
          ..write('monthKey: $monthKey, ')
          ..write('proudTags: $proudTags, ')
          ..write('proudNote: $proudNote, ')
          ..write('heldBackTags: $heldBackTags, ')
          ..write('heldBackNote: $heldBackNote, ')
          ..write('differentTags: $differentTags, ')
          ..write('differentNote: $differentNote, ')
          ..write('lesson: $lesson, ')
          ..write('priorities: $priorities, ')
          ..write('completedAt: $completedAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $RemindersTable extends Reminders
    with TableInfo<$RemindersTable, Reminder> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RemindersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<ReminderKind, String> kind =
      GeneratedColumn<String>(
        'kind',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ReminderKind>($RemindersTable.$converterkind);
  static const VerificationMeta _enabledMeta = const VerificationMeta(
    'enabled',
  );
  @override
  late final GeneratedColumn<bool> enabled = GeneratedColumn<bool>(
    'enabled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("enabled" IN (0, 1))',
    ),
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _minuteOfDayMeta = const VerificationMeta(
    'minuteOfDay',
  );
  @override
  late final GeneratedColumn<int> minuteOfDay = GeneratedColumn<int>(
    'minute_of_day',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _weekdaysMeta = const VerificationMeta(
    'weekdays',
  );
  @override
  late final GeneratedColumn<int> weekdays = GeneratedColumn<int>(
    'weekdays',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(127),
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES habits (id) ON DELETE CASCADE',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    kind,
    enabled,
    minuteOfDay,
    weekdays,
    habitId,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'reminders';
  @override
  VerificationContext validateIntegrity(
    Insertable<Reminder> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('enabled')) {
      context.handle(
        _enabledMeta,
        enabled.isAcceptableOrUnknown(data['enabled']!, _enabledMeta),
      );
    }
    if (data.containsKey('minute_of_day')) {
      context.handle(
        _minuteOfDayMeta,
        minuteOfDay.isAcceptableOrUnknown(
          data['minute_of_day']!,
          _minuteOfDayMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_minuteOfDayMeta);
    }
    if (data.containsKey('weekdays')) {
      context.handle(
        _weekdaysMeta,
        weekdays.isAcceptableOrUnknown(data['weekdays']!, _weekdaysMeta),
      );
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Reminder map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Reminder(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      kind: $RemindersTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      enabled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}enabled'],
      )!,
      minuteOfDay: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}minute_of_day'],
      )!,
      weekdays: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}weekdays'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      ),
    );
  }

  @override
  $RemindersTable createAlias(String alias) {
    return $RemindersTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<ReminderKind, String, String> $converterkind =
      const EnumNameConverter<ReminderKind>(ReminderKind.values);
}

class Reminder extends DataClass implements Insertable<Reminder> {
  final String id;
  final ReminderKind kind;
  final bool enabled;
  final int minuteOfDay;
  final int weekdays;
  final String? habitId;
  const Reminder({
    required this.id,
    required this.kind,
    required this.enabled,
    required this.minuteOfDay,
    required this.weekdays,
    this.habitId,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    {
      map['kind'] = Variable<String>(
        $RemindersTable.$converterkind.toSql(kind),
      );
    }
    map['enabled'] = Variable<bool>(enabled);
    map['minute_of_day'] = Variable<int>(minuteOfDay);
    map['weekdays'] = Variable<int>(weekdays);
    if (!nullToAbsent || habitId != null) {
      map['habit_id'] = Variable<String>(habitId);
    }
    return map;
  }

  RemindersCompanion toCompanion(bool nullToAbsent) {
    return RemindersCompanion(
      id: Value(id),
      kind: Value(kind),
      enabled: Value(enabled),
      minuteOfDay: Value(minuteOfDay),
      weekdays: Value(weekdays),
      habitId: habitId == null && nullToAbsent
          ? const Value.absent()
          : Value(habitId),
    );
  }

  factory Reminder.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Reminder(
      id: serializer.fromJson<String>(json['id']),
      kind: $RemindersTable.$converterkind.fromJson(
        serializer.fromJson<String>(json['kind']),
      ),
      enabled: serializer.fromJson<bool>(json['enabled']),
      minuteOfDay: serializer.fromJson<int>(json['minuteOfDay']),
      weekdays: serializer.fromJson<int>(json['weekdays']),
      habitId: serializer.fromJson<String?>(json['habitId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'kind': serializer.toJson<String>(
        $RemindersTable.$converterkind.toJson(kind),
      ),
      'enabled': serializer.toJson<bool>(enabled),
      'minuteOfDay': serializer.toJson<int>(minuteOfDay),
      'weekdays': serializer.toJson<int>(weekdays),
      'habitId': serializer.toJson<String?>(habitId),
    };
  }

  Reminder copyWith({
    String? id,
    ReminderKind? kind,
    bool? enabled,
    int? minuteOfDay,
    int? weekdays,
    Value<String?> habitId = const Value.absent(),
  }) => Reminder(
    id: id ?? this.id,
    kind: kind ?? this.kind,
    enabled: enabled ?? this.enabled,
    minuteOfDay: minuteOfDay ?? this.minuteOfDay,
    weekdays: weekdays ?? this.weekdays,
    habitId: habitId.present ? habitId.value : this.habitId,
  );
  Reminder copyWithCompanion(RemindersCompanion data) {
    return Reminder(
      id: data.id.present ? data.id.value : this.id,
      kind: data.kind.present ? data.kind.value : this.kind,
      enabled: data.enabled.present ? data.enabled.value : this.enabled,
      minuteOfDay: data.minuteOfDay.present
          ? data.minuteOfDay.value
          : this.minuteOfDay,
      weekdays: data.weekdays.present ? data.weekdays.value : this.weekdays,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Reminder(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('enabled: $enabled, ')
          ..write('minuteOfDay: $minuteOfDay, ')
          ..write('weekdays: $weekdays, ')
          ..write('habitId: $habitId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, kind, enabled, minuteOfDay, weekdays, habitId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Reminder &&
          other.id == this.id &&
          other.kind == this.kind &&
          other.enabled == this.enabled &&
          other.minuteOfDay == this.minuteOfDay &&
          other.weekdays == this.weekdays &&
          other.habitId == this.habitId);
}

class RemindersCompanion extends UpdateCompanion<Reminder> {
  final Value<String> id;
  final Value<ReminderKind> kind;
  final Value<bool> enabled;
  final Value<int> minuteOfDay;
  final Value<int> weekdays;
  final Value<String?> habitId;
  final Value<int> rowid;
  const RemindersCompanion({
    this.id = const Value.absent(),
    this.kind = const Value.absent(),
    this.enabled = const Value.absent(),
    this.minuteOfDay = const Value.absent(),
    this.weekdays = const Value.absent(),
    this.habitId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  RemindersCompanion.insert({
    required String id,
    required ReminderKind kind,
    this.enabled = const Value.absent(),
    required int minuteOfDay,
    this.weekdays = const Value.absent(),
    this.habitId = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       kind = Value(kind),
       minuteOfDay = Value(minuteOfDay);
  static Insertable<Reminder> custom({
    Expression<String>? id,
    Expression<String>? kind,
    Expression<bool>? enabled,
    Expression<int>? minuteOfDay,
    Expression<int>? weekdays,
    Expression<String>? habitId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (kind != null) 'kind': kind,
      if (enabled != null) 'enabled': enabled,
      if (minuteOfDay != null) 'minute_of_day': minuteOfDay,
      if (weekdays != null) 'weekdays': weekdays,
      if (habitId != null) 'habit_id': habitId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  RemindersCompanion copyWith({
    Value<String>? id,
    Value<ReminderKind>? kind,
    Value<bool>? enabled,
    Value<int>? minuteOfDay,
    Value<int>? weekdays,
    Value<String?>? habitId,
    Value<int>? rowid,
  }) {
    return RemindersCompanion(
      id: id ?? this.id,
      kind: kind ?? this.kind,
      enabled: enabled ?? this.enabled,
      minuteOfDay: minuteOfDay ?? this.minuteOfDay,
      weekdays: weekdays ?? this.weekdays,
      habitId: habitId ?? this.habitId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $RemindersTable.$converterkind.toSql(kind.value),
      );
    }
    if (enabled.present) {
      map['enabled'] = Variable<bool>(enabled.value);
    }
    if (minuteOfDay.present) {
      map['minute_of_day'] = Variable<int>(minuteOfDay.value);
    }
    if (weekdays.present) {
      map['weekdays'] = Variable<int>(weekdays.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RemindersCompanion(')
          ..write('id: $id, ')
          ..write('kind: $kind, ')
          ..write('enabled: $enabled, ')
          ..write('minuteOfDay: $minuteOfDay, ')
          ..write('weekdays: $weekdays, ')
          ..write('habitId: $habitId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ActivityEventsTable extends ActivityEvents
    with TableInfo<$ActivityEventsTable, ActivityEvent> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ActivityEventsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<LifeArea?, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<LifeArea?>($ActivityEventsTable.$converterarean);
  @override
  late final GeneratedColumnWithTypeConverter<ActivityType, String> type =
      GeneratedColumn<String>(
        'type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<ActivityType>($ActivityEventsTable.$convertertype);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _subtitleMeta = const VerificationMeta(
    'subtitle',
  );
  @override
  late final GeneratedColumn<String> subtitle = GeneratedColumn<String>(
    'subtitle',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _amountMinorMeta = const VerificationMeta(
    'amountMinor',
  );
  @override
  late final GeneratedColumn<int> amountMinor = GeneratedColumn<int>(
    'amount_minor',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityTypeMeta = const VerificationMeta(
    'entityType',
  );
  @override
  late final GeneratedColumn<String> entityType = GeneratedColumn<String>(
    'entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _entityIdMeta = const VerificationMeta(
    'entityId',
  );
  @override
  late final GeneratedColumn<String> entityId = GeneratedColumn<String>(
    'entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _factsMeta = const VerificationMeta('facts');
  @override
  late final GeneratedColumn<String> facts = GeneratedColumn<String>(
    'facts',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _occurredAtMeta = const VerificationMeta(
    'occurredAt',
  );
  @override
  late final GeneratedColumn<DateTime> occurredAt = GeneratedColumn<DateTime>(
    'occurred_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    area,
    type,
    title,
    subtitle,
    amountMinor,
    entityType,
    entityId,
    facts,
    occurredAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'activity_events';
  @override
  VerificationContext validateIntegrity(
    Insertable<ActivityEvent> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('subtitle')) {
      context.handle(
        _subtitleMeta,
        subtitle.isAcceptableOrUnknown(data['subtitle']!, _subtitleMeta),
      );
    }
    if (data.containsKey('amount_minor')) {
      context.handle(
        _amountMinorMeta,
        amountMinor.isAcceptableOrUnknown(
          data['amount_minor']!,
          _amountMinorMeta,
        ),
      );
    }
    if (data.containsKey('entity_type')) {
      context.handle(
        _entityTypeMeta,
        entityType.isAcceptableOrUnknown(data['entity_type']!, _entityTypeMeta),
      );
    }
    if (data.containsKey('entity_id')) {
      context.handle(
        _entityIdMeta,
        entityId.isAcceptableOrUnknown(data['entity_id']!, _entityIdMeta),
      );
    }
    if (data.containsKey('facts')) {
      context.handle(
        _factsMeta,
        facts.isAcceptableOrUnknown(data['facts']!, _factsMeta),
      );
    }
    if (data.containsKey('occurred_at')) {
      context.handle(
        _occurredAtMeta,
        occurredAt.isAcceptableOrUnknown(data['occurred_at']!, _occurredAtMeta),
      );
    } else if (isInserting) {
      context.missing(_occurredAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  ActivityEvent map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ActivityEvent(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      area: $ActivityEventsTable.$converterarean.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        ),
      ),
      type: $ActivityEventsTable.$convertertype.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}type'],
        )!,
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      subtitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}subtitle'],
      ),
      amountMinor: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount_minor'],
      ),
      entityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_type'],
      ),
      entityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}entity_id'],
      ),
      facts: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}facts'],
      ),
      occurredAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}occurred_at'],
      )!,
    );
  }

  @override
  $ActivityEventsTable createAlias(String alias) {
    return $ActivityEventsTable(attachedDatabase, alias);
  }

  static JsonTypeConverter2<LifeArea, String, String> $converterarea =
      const EnumNameConverter<LifeArea>(LifeArea.values);
  static JsonTypeConverter2<LifeArea?, String?, String?> $converterarean =
      JsonTypeConverter2.asNullable($converterarea);
  static JsonTypeConverter2<ActivityType, String, String> $convertertype =
      const EnumNameConverter<ActivityType>(ActivityType.values);
}

class ActivityEvent extends DataClass implements Insertable<ActivityEvent> {
  final String id;
  final LifeArea? area;
  final ActivityType type;
  final String title;
  final String? subtitle;
  final int? amountMinor;
  final String? entityType;
  final String? entityId;

  /// JSON facts (minutes, rating, kind…) used to render system titles in the
  /// active language; [title] and [subtitle] keep a readable fallback.
  final String? facts;
  final DateTime occurredAt;
  const ActivityEvent({
    required this.id,
    this.area,
    required this.type,
    required this.title,
    this.subtitle,
    this.amountMinor,
    this.entityType,
    this.entityId,
    this.facts,
    required this.occurredAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    if (!nullToAbsent || area != null) {
      map['area'] = Variable<String>(
        $ActivityEventsTable.$converterarean.toSql(area),
      );
    }
    {
      map['type'] = Variable<String>(
        $ActivityEventsTable.$convertertype.toSql(type),
      );
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || subtitle != null) {
      map['subtitle'] = Variable<String>(subtitle);
    }
    if (!nullToAbsent || amountMinor != null) {
      map['amount_minor'] = Variable<int>(amountMinor);
    }
    if (!nullToAbsent || entityType != null) {
      map['entity_type'] = Variable<String>(entityType);
    }
    if (!nullToAbsent || entityId != null) {
      map['entity_id'] = Variable<String>(entityId);
    }
    if (!nullToAbsent || facts != null) {
      map['facts'] = Variable<String>(facts);
    }
    map['occurred_at'] = Variable<DateTime>(occurredAt);
    return map;
  }

  ActivityEventsCompanion toCompanion(bool nullToAbsent) {
    return ActivityEventsCompanion(
      id: Value(id),
      area: area == null && nullToAbsent ? const Value.absent() : Value(area),
      type: Value(type),
      title: Value(title),
      subtitle: subtitle == null && nullToAbsent
          ? const Value.absent()
          : Value(subtitle),
      amountMinor: amountMinor == null && nullToAbsent
          ? const Value.absent()
          : Value(amountMinor),
      entityType: entityType == null && nullToAbsent
          ? const Value.absent()
          : Value(entityType),
      entityId: entityId == null && nullToAbsent
          ? const Value.absent()
          : Value(entityId),
      facts: facts == null && nullToAbsent
          ? const Value.absent()
          : Value(facts),
      occurredAt: Value(occurredAt),
    );
  }

  factory ActivityEvent.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ActivityEvent(
      id: serializer.fromJson<String>(json['id']),
      area: $ActivityEventsTable.$converterarean.fromJson(
        serializer.fromJson<String?>(json['area']),
      ),
      type: $ActivityEventsTable.$convertertype.fromJson(
        serializer.fromJson<String>(json['type']),
      ),
      title: serializer.fromJson<String>(json['title']),
      subtitle: serializer.fromJson<String?>(json['subtitle']),
      amountMinor: serializer.fromJson<int?>(json['amountMinor']),
      entityType: serializer.fromJson<String?>(json['entityType']),
      entityId: serializer.fromJson<String?>(json['entityId']),
      facts: serializer.fromJson<String?>(json['facts']),
      occurredAt: serializer.fromJson<DateTime>(json['occurredAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'area': serializer.toJson<String?>(
        $ActivityEventsTable.$converterarean.toJson(area),
      ),
      'type': serializer.toJson<String>(
        $ActivityEventsTable.$convertertype.toJson(type),
      ),
      'title': serializer.toJson<String>(title),
      'subtitle': serializer.toJson<String?>(subtitle),
      'amountMinor': serializer.toJson<int?>(amountMinor),
      'entityType': serializer.toJson<String?>(entityType),
      'entityId': serializer.toJson<String?>(entityId),
      'facts': serializer.toJson<String?>(facts),
      'occurredAt': serializer.toJson<DateTime>(occurredAt),
    };
  }

  ActivityEvent copyWith({
    String? id,
    Value<LifeArea?> area = const Value.absent(),
    ActivityType? type,
    String? title,
    Value<String?> subtitle = const Value.absent(),
    Value<int?> amountMinor = const Value.absent(),
    Value<String?> entityType = const Value.absent(),
    Value<String?> entityId = const Value.absent(),
    Value<String?> facts = const Value.absent(),
    DateTime? occurredAt,
  }) => ActivityEvent(
    id: id ?? this.id,
    area: area.present ? area.value : this.area,
    type: type ?? this.type,
    title: title ?? this.title,
    subtitle: subtitle.present ? subtitle.value : this.subtitle,
    amountMinor: amountMinor.present ? amountMinor.value : this.amountMinor,
    entityType: entityType.present ? entityType.value : this.entityType,
    entityId: entityId.present ? entityId.value : this.entityId,
    facts: facts.present ? facts.value : this.facts,
    occurredAt: occurredAt ?? this.occurredAt,
  );
  ActivityEvent copyWithCompanion(ActivityEventsCompanion data) {
    return ActivityEvent(
      id: data.id.present ? data.id.value : this.id,
      area: data.area.present ? data.area.value : this.area,
      type: data.type.present ? data.type.value : this.type,
      title: data.title.present ? data.title.value : this.title,
      subtitle: data.subtitle.present ? data.subtitle.value : this.subtitle,
      amountMinor: data.amountMinor.present
          ? data.amountMinor.value
          : this.amountMinor,
      entityType: data.entityType.present
          ? data.entityType.value
          : this.entityType,
      entityId: data.entityId.present ? data.entityId.value : this.entityId,
      facts: data.facts.present ? data.facts.value : this.facts,
      occurredAt: data.occurredAt.present
          ? data.occurredAt.value
          : this.occurredAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEvent(')
          ..write('id: $id, ')
          ..write('area: $area, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('facts: $facts, ')
          ..write('occurredAt: $occurredAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    area,
    type,
    title,
    subtitle,
    amountMinor,
    entityType,
    entityId,
    facts,
    occurredAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ActivityEvent &&
          other.id == this.id &&
          other.area == this.area &&
          other.type == this.type &&
          other.title == this.title &&
          other.subtitle == this.subtitle &&
          other.amountMinor == this.amountMinor &&
          other.entityType == this.entityType &&
          other.entityId == this.entityId &&
          other.facts == this.facts &&
          other.occurredAt == this.occurredAt);
}

class ActivityEventsCompanion extends UpdateCompanion<ActivityEvent> {
  final Value<String> id;
  final Value<LifeArea?> area;
  final Value<ActivityType> type;
  final Value<String> title;
  final Value<String?> subtitle;
  final Value<int?> amountMinor;
  final Value<String?> entityType;
  final Value<String?> entityId;
  final Value<String?> facts;
  final Value<DateTime> occurredAt;
  final Value<int> rowid;
  const ActivityEventsCompanion({
    this.id = const Value.absent(),
    this.area = const Value.absent(),
    this.type = const Value.absent(),
    this.title = const Value.absent(),
    this.subtitle = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.facts = const Value.absent(),
    this.occurredAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ActivityEventsCompanion.insert({
    required String id,
    this.area = const Value.absent(),
    required ActivityType type,
    required String title,
    this.subtitle = const Value.absent(),
    this.amountMinor = const Value.absent(),
    this.entityType = const Value.absent(),
    this.entityId = const Value.absent(),
    this.facts = const Value.absent(),
    required DateTime occurredAt,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       type = Value(type),
       title = Value(title),
       occurredAt = Value(occurredAt);
  static Insertable<ActivityEvent> custom({
    Expression<String>? id,
    Expression<String>? area,
    Expression<String>? type,
    Expression<String>? title,
    Expression<String>? subtitle,
    Expression<int>? amountMinor,
    Expression<String>? entityType,
    Expression<String>? entityId,
    Expression<String>? facts,
    Expression<DateTime>? occurredAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (area != null) 'area': area,
      if (type != null) 'type': type,
      if (title != null) 'title': title,
      if (subtitle != null) 'subtitle': subtitle,
      if (amountMinor != null) 'amount_minor': amountMinor,
      if (entityType != null) 'entity_type': entityType,
      if (entityId != null) 'entity_id': entityId,
      if (facts != null) 'facts': facts,
      if (occurredAt != null) 'occurred_at': occurredAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ActivityEventsCompanion copyWith({
    Value<String>? id,
    Value<LifeArea?>? area,
    Value<ActivityType>? type,
    Value<String>? title,
    Value<String?>? subtitle,
    Value<int?>? amountMinor,
    Value<String?>? entityType,
    Value<String?>? entityId,
    Value<String?>? facts,
    Value<DateTime>? occurredAt,
    Value<int>? rowid,
  }) {
    return ActivityEventsCompanion(
      id: id ?? this.id,
      area: area ?? this.area,
      type: type ?? this.type,
      title: title ?? this.title,
      subtitle: subtitle ?? this.subtitle,
      amountMinor: amountMinor ?? this.amountMinor,
      entityType: entityType ?? this.entityType,
      entityId: entityId ?? this.entityId,
      facts: facts ?? this.facts,
      occurredAt: occurredAt ?? this.occurredAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $ActivityEventsTable.$converterarean.toSql(area.value),
      );
    }
    if (type.present) {
      map['type'] = Variable<String>(
        $ActivityEventsTable.$convertertype.toSql(type.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (subtitle.present) {
      map['subtitle'] = Variable<String>(subtitle.value);
    }
    if (amountMinor.present) {
      map['amount_minor'] = Variable<int>(amountMinor.value);
    }
    if (entityType.present) {
      map['entity_type'] = Variable<String>(entityType.value);
    }
    if (entityId.present) {
      map['entity_id'] = Variable<String>(entityId.value);
    }
    if (facts.present) {
      map['facts'] = Variable<String>(facts.value);
    }
    if (occurredAt.present) {
      map['occurred_at'] = Variable<DateTime>(occurredAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ActivityEventsCompanion(')
          ..write('id: $id, ')
          ..write('area: $area, ')
          ..write('type: $type, ')
          ..write('title: $title, ')
          ..write('subtitle: $subtitle, ')
          ..write('amountMinor: $amountMinor, ')
          ..write('entityType: $entityType, ')
          ..write('entityId: $entityId, ')
          ..write('facts: $facts, ')
          ..write('occurredAt: $occurredAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $AppSettingsTable extends AppSettings
    with TableInfo<$AppSettingsTable, AppSetting> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AppSettingsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _keyMeta = const VerificationMeta('key');
  @override
  late final GeneratedColumn<String> key = GeneratedColumn<String>(
    'key',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _valueMeta = const VerificationMeta('value');
  @override
  late final GeneratedColumn<String> value = GeneratedColumn<String>(
    'value',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [key, value];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'app_settings';
  @override
  VerificationContext validateIntegrity(
    Insertable<AppSetting> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('key')) {
      context.handle(
        _keyMeta,
        key.isAcceptableOrUnknown(data['key']!, _keyMeta),
      );
    } else if (isInserting) {
      context.missing(_keyMeta);
    }
    if (data.containsKey('value')) {
      context.handle(
        _valueMeta,
        value.isAcceptableOrUnknown(data['value']!, _valueMeta),
      );
    } else if (isInserting) {
      context.missing(_valueMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {key};
  @override
  AppSetting map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AppSetting(
      key: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}key'],
      )!,
      value: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}value'],
      )!,
    );
  }

  @override
  $AppSettingsTable createAlias(String alias) {
    return $AppSettingsTable(attachedDatabase, alias);
  }
}

class AppSetting extends DataClass implements Insertable<AppSetting> {
  final String key;
  final String value;
  const AppSetting({required this.key, required this.value});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['key'] = Variable<String>(key);
    map['value'] = Variable<String>(value);
    return map;
  }

  AppSettingsCompanion toCompanion(bool nullToAbsent) {
    return AppSettingsCompanion(key: Value(key), value: Value(value));
  }

  factory AppSetting.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AppSetting(
      key: serializer.fromJson<String>(json['key']),
      value: serializer.fromJson<String>(json['value']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'key': serializer.toJson<String>(key),
      'value': serializer.toJson<String>(value),
    };
  }

  AppSetting copyWith({String? key, String? value}) =>
      AppSetting(key: key ?? this.key, value: value ?? this.value);
  AppSetting copyWithCompanion(AppSettingsCompanion data) {
    return AppSetting(
      key: data.key.present ? data.key.value : this.key,
      value: data.value.present ? data.value.value : this.value,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AppSetting(')
          ..write('key: $key, ')
          ..write('value: $value')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(key, value);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AppSetting &&
          other.key == this.key &&
          other.value == this.value);
}

class AppSettingsCompanion extends UpdateCompanion<AppSetting> {
  final Value<String> key;
  final Value<String> value;
  final Value<int> rowid;
  const AppSettingsCompanion({
    this.key = const Value.absent(),
    this.value = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  AppSettingsCompanion.insert({
    required String key,
    required String value,
    this.rowid = const Value.absent(),
  }) : key = Value(key),
       value = Value(value);
  static Insertable<AppSetting> custom({
    Expression<String>? key,
    Expression<String>? value,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (key != null) 'key': key,
      if (value != null) 'value': value,
      if (rowid != null) 'rowid': rowid,
    });
  }

  AppSettingsCompanion copyWith({
    Value<String>? key,
    Value<String>? value,
    Value<int>? rowid,
  }) {
    return AppSettingsCompanion(
      key: key ?? this.key,
      value: value ?? this.value,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (key.present) {
      map['key'] = Variable<String>(key.value);
    }
    if (value.present) {
      map['value'] = Variable<String>(value.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AppSettingsCompanion(')
          ..write('key: $key, ')
          ..write('value: $value, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $UserProfilesTable userProfiles = $UserProfilesTable(this);
  late final $GoalsTable goals = $GoalsTable(this);
  late final $GoalActionsTable goalActions = $GoalActionsTable(this);
  late final $GoalMilestonesTable goalMilestones = $GoalMilestonesTable(this);
  late final $GoalProgressEventsTable goalProgressEvents =
      $GoalProgressEventsTable(this);
  late final $TasksTable tasks = $TasksTable(this);
  late final $MorningCheckInsTable morningCheckIns = $MorningCheckInsTable(
    this,
  );
  late final $NightReviewsTable nightReviews = $NightReviewsTable(this);
  late final $QuranLogsTable quranLogs = $QuranLogsTable(this);
  late final $WorkActivitiesTable workActivities = $WorkActivitiesTable(this);
  late final $FinanceTransactionsTable financeTransactions =
      $FinanceTransactionsTable(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $HabitLogsTable habitLogs = $HabitLogsTable(this);
  late final $WorkoutLogsTable workoutLogs = $WorkoutLogsTable(this);
  late final $WalkingLogsTable walkingLogs = $WalkingLogsTable(this);
  late final $SleepLogsTable sleepLogs = $SleepLogsTable(this);
  late final $LearningResourcesTable learningResources =
      $LearningResourcesTable(this);
  late final $LearningSessionsTable learningSessions = $LearningSessionsTable(
    this,
  );
  late final $NotesTable notes = $NotesTable(this);
  late final $WeeklyReviewsTable weeklyReviews = $WeeklyReviewsTable(this);
  late final $MonthlyReviewsTable monthlyReviews = $MonthlyReviewsTable(this);
  late final $RemindersTable reminders = $RemindersTable(this);
  late final $ActivityEventsTable activityEvents = $ActivityEventsTable(this);
  late final $AppSettingsTable appSettings = $AppSettingsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userProfiles,
    goals,
    goalActions,
    goalMilestones,
    goalProgressEvents,
    tasks,
    morningCheckIns,
    nightReviews,
    quranLogs,
    workActivities,
    financeTransactions,
    habits,
    habitLogs,
    workoutLogs,
    walkingLogs,
    sleepLogs,
    learningResources,
    learningSessions,
    notes,
    weeklyReviews,
    monthlyReviews,
    reminders,
    activityEvents,
    appSettings,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goal_actions', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goal_milestones', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('goal_progress_events', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('tasks', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('quran_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('work_activities', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('finance_transactions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('habit_logs', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('workout_logs', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'learning_resources',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learning_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'goals',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('learning_sessions', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'habits',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('reminders', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$UserProfilesTableCreateCompanionBuilder =
    UserProfilesCompanion Function({
      required String id,
      required String name,
      Value<String?> email,
      Value<String?> role,
      Value<String?> intention,
      Value<int> avatarColor,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$UserProfilesTableUpdateCompanionBuilder =
    UserProfilesCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<String?> email,
      Value<String?> role,
      Value<String?> intention,
      Value<int> avatarColor,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$UserProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$UserProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$UserProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $UserProfilesTable> {
  $$UserProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get intention =>
      $composableBuilder(column: $table.intention, builder: (column) => column);

  GeneratedColumn<int> get avatarColor => $composableBuilder(
    column: $table.avatarColor,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$UserProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $UserProfilesTable,
          UserProfile,
          $$UserProfilesTableFilterComposer,
          $$UserProfilesTableOrderingComposer,
          $$UserProfilesTableAnnotationComposer,
          $$UserProfilesTableCreateCompanionBuilder,
          $$UserProfilesTableUpdateCompanionBuilder,
          (
            UserProfile,
            BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
          ),
          UserProfile,
          PrefetchHooks Function()
        > {
  $$UserProfilesTableTableManager(_$AppDatabase db, $UserProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$UserProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$UserProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$UserProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<String?> email = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<int> avatarColor = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion(
                id: id,
                name: name,
                email: email,
                role: role,
                intention: intention,
                avatarColor: avatarColor,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<String?> email = const Value.absent(),
                Value<String?> role = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<int> avatarColor = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => UserProfilesCompanion.insert(
                id: id,
                name: name,
                email: email,
                role: role,
                intention: intention,
                avatarColor: avatarColor,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$UserProfilesTable, UserProfile>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $UserProfilesTable,
                    UserProfile
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$UserProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $UserProfilesTable,
      UserProfile,
      $$UserProfilesTableFilterComposer,
      $$UserProfilesTableOrderingComposer,
      $$UserProfilesTableAnnotationComposer,
      $$UserProfilesTableCreateCompanionBuilder,
      $$UserProfilesTableUpdateCompanionBuilder,
      (
        UserProfile,
        BaseReferences<_$AppDatabase, $UserProfilesTable, UserProfile>,
      ),
      UserProfile,
      PrefetchHooks Function()
    >;
typedef $$GoalsTableCreateCompanionBuilder = GoalsCompanion Function({
  required String id,
  required String title,
  Value<String?> description,
  required LifeArea area,
  required GoalType type,
  Value<String> unit,
  Value<double> targetValue,
  Value<double> startValue,
  Value<GoalFrequency> frequency,
  Value<int> periodTarget,
  Value<DateTime?> targetDate,
  Value<String?> why,
  Value<GoalStatus> status,
  Value<bool> isPrimary,
  required DateTime createdAt,
  required DateTime updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});
typedef $$GoalsTableUpdateCompanionBuilder = GoalsCompanion Function({
  Value<String> id,
  Value<String> title,
  Value<String?> description,
  Value<LifeArea> area,
  Value<GoalType> type,
  Value<String> unit,
  Value<double> targetValue,
  Value<double> startValue,
  Value<GoalFrequency> frequency,
  Value<int> periodTarget,
  Value<DateTime?> targetDate,
  Value<String?> why,
  Value<GoalStatus> status,
  Value<bool> isPrimary,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<DateTime?> completedAt,
  Value<int> rowid,
});

final class $$GoalsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalsTable, Goal> {
  $$GoalsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$GoalActionsTable, List<GoalAction>>
  _goalActionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.goalActions,
    aliasName: 'goals__id__goal_actions__goal_id',
  );

  $$GoalActionsTableProcessedTableManager get goalActionsRefs {
    final manager = $$GoalActionsTableTableManager(
      $_db,
      $_db.goalActions,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalActionsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalMilestonesTable, List<GoalMilestone>>
  _goalMilestonesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.goalMilestones,
    aliasName: 'goals__id__goal_milestones__goal_id',
  );

  $$GoalMilestonesTableProcessedTableManager get goalMilestonesRefs {
    final manager = $$GoalMilestonesTableTableManager(
      $_db,
      $_db.goalMilestones,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_goalMilestonesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$GoalProgressEventsTable, List<GoalProgressEvent>>
  _goalProgressEventsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.goalProgressEvents,
        aliasName: 'goals__id__goal_progress_events__goal_id',
      );

  $$GoalProgressEventsTableProcessedTableManager get goalProgressEventsRefs {
    final manager = $$GoalProgressEventsTableTableManager(
      $_db,
      $_db.goalProgressEvents,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _goalProgressEventsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$TasksTable, List<Task>> _tasksRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.tasks,
    aliasName: 'goals__id__tasks__goal_id',
  );

  $$TasksTableProcessedTableManager get tasksRefs {
    final manager = $$TasksTableTableManager(
      $_db,
      $_db.tasks,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_tasksRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$QuranLogsTable, List<QuranLog>>
  _quranLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.quranLogs,
    aliasName: 'goals__id__quran_logs__goal_id',
  );

  $$QuranLogsTableProcessedTableManager get quranLogsRefs {
    final manager = $$QuranLogsTableTableManager(
      $_db,
      $_db.quranLogs,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_quranLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkActivitiesTable, List<WorkActivity>>
  _workActivitiesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workActivities,
    aliasName: 'goals__id__work_activities__goal_id',
  );

  $$WorkActivitiesTableProcessedTableManager get workActivitiesRefs {
    final manager = $$WorkActivitiesTableTableManager(
      $_db,
      $_db.workActivities,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_workActivitiesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $FinanceTransactionsTable,
    List<FinanceTransaction>
  >
  _financeTransactionsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.financeTransactions,
        aliasName: 'goals__id__finance_transactions__goal_id',
      );

  $$FinanceTransactionsTableProcessedTableManager get financeTransactionsRefs {
    final manager = $$FinanceTransactionsTableTableManager(
      $_db,
      $_db.financeTransactions,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _financeTransactionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$WorkoutLogsTable, List<WorkoutLog>>
  _workoutLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.workoutLogs,
    aliasName: 'goals__id__workout_logs__goal_id',
  );

  $$WorkoutLogsTableProcessedTableManager get workoutLogsRefs {
    final manager = $$WorkoutLogsTableTableManager(
      $_db,
      $_db.workoutLogs,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_workoutLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$LearningSessionsTable, List<LearningSession>>
  _learningSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.learningSessions,
    aliasName: 'goals__id__learning_sessions__goal_id',
  );

  $$LearningSessionsTableProcessedTableManager get learningSessionsRefs {
    final manager = $$LearningSessionsTableTableManager(
      $_db,
      $_db.learningSessions,
    ).filter((f) => f.goalId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GoalsTableFilterComposer extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LifeArea, LifeArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<GoalType, GoalType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalFrequency, GoalFrequency, String>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get periodTarget => $composableBuilder(
    column: $table.periodTarget,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalStatus, GoalStatus, String> get status =>
      $composableBuilder(
        column: $table.status,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> goalActionsRefs(
    Expression<bool> Function($$GoalActionsTableFilterComposer f) f,
  ) {
    final $$GoalActionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalActions,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalActionsTableFilterComposer(
            $db: $db,
            $table: $db.goalActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalMilestonesRefs(
    Expression<bool> Function($$GoalMilestonesTableFilterComposer f) f,
  ) {
    final $$GoalMilestonesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalMilestones,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalMilestonesTableFilterComposer(
            $db: $db,
            $table: $db.goalMilestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> goalProgressEventsRefs(
    Expression<bool> Function($$GoalProgressEventsTableFilterComposer f) f,
  ) {
    final $$GoalProgressEventsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalProgressEvents,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalProgressEventsTableFilterComposer(
            $db: $db,
            $table: $db.goalProgressEvents,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> tasksRefs(
    Expression<bool> Function($$TasksTableFilterComposer f) f,
  ) {
    final $$TasksTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableFilterComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> quranLogsRefs(
    Expression<bool> Function($$QuranLogsTableFilterComposer f) f,
  ) {
    final $$QuranLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quranLogs,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuranLogsTableFilterComposer(
            $db: $db,
            $table: $db.quranLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workActivitiesRefs(
    Expression<bool> Function($$WorkActivitiesTableFilterComposer f) f,
  ) {
    final $$WorkActivitiesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workActivities,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkActivitiesTableFilterComposer(
            $db: $db,
            $table: $db.workActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> financeTransactionsRefs(
    Expression<bool> Function($$FinanceTransactionsTableFilterComposer f) f,
  ) {
    final $$FinanceTransactionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.financeTransactions,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$FinanceTransactionsTableFilterComposer(
            $db: $db,
            $table: $db.financeTransactions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> workoutLogsRefs(
    Expression<bool> Function($$WorkoutLogsTableFilterComposer f) f,
  ) {
    final $$WorkoutLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableFilterComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> learningSessionsRefs(
    Expression<bool> Function($$LearningSessionsTableFilterComposer f) f,
  ) {
    final $$LearningSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningSessions,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningSessionsTableFilterComposer(
            $db: $db,
            $table: $db.learningSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get unit => $composableBuilder(
    column: $table.unit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get periodTarget => $composableBuilder(
    column: $table.periodTarget,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get why => $composableBuilder(
    column: $table.why,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isPrimary => $composableBuilder(
    column: $table.isPrimary,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GoalsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalsTable> {
  $$GoalsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<LifeArea, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get unit =>
      $composableBuilder(column: $table.unit, builder: (column) => column);

  GeneratedColumn<double> get targetValue => $composableBuilder(
    column: $table.targetValue,
    builder: (column) => column,
  );

  GeneratedColumn<double> get startValue => $composableBuilder(
    column: $table.startValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<GoalFrequency, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<int> get periodTarget => $composableBuilder(
    column: $table.periodTarget,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get why =>
      $composableBuilder(column: $table.why, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isPrimary =>
      $composableBuilder(column: $table.isPrimary, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  Expression<T> goalActionsRefs<T extends Object>(
    Expression<T> Function($$GoalActionsTableAnnotationComposer a) f,
  ) {
    final $$GoalActionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalActions,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalActionsTableAnnotationComposer(
            $db: $db,
            $table: $db.goalActions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalMilestonesRefs<T extends Object>(
    Expression<T> Function($$GoalMilestonesTableAnnotationComposer a) f,
  ) {
    final $$GoalMilestonesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.goalMilestones,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalMilestonesTableAnnotationComposer(
            $db: $db,
            $table: $db.goalMilestones,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> goalProgressEventsRefs<T extends Object>(
    Expression<T> Function($$GoalProgressEventsTableAnnotationComposer a) f,
  ) {
    final $$GoalProgressEventsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.goalProgressEvents,
          getReferencedColumn: (t) => t.goalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$GoalProgressEventsTableAnnotationComposer(
                $db: $db,
                $table: $db.goalProgressEvents,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> tasksRefs<T extends Object>(
    Expression<T> Function($$TasksTableAnnotationComposer a) f,
  ) {
    final $$TasksTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.tasks,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TasksTableAnnotationComposer(
            $db: $db,
            $table: $db.tasks,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> quranLogsRefs<T extends Object>(
    Expression<T> Function($$QuranLogsTableAnnotationComposer a) f,
  ) {
    final $$QuranLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.quranLogs,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$QuranLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.quranLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> workActivitiesRefs<T extends Object>(
    Expression<T> Function($$WorkActivitiesTableAnnotationComposer a) f,
  ) {
    final $$WorkActivitiesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workActivities,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkActivitiesTableAnnotationComposer(
            $db: $db,
            $table: $db.workActivities,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> financeTransactionsRefs<T extends Object>(
    Expression<T> Function($$FinanceTransactionsTableAnnotationComposer a) f,
  ) {
    final $$FinanceTransactionsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.financeTransactions,
          getReferencedColumn: (t) => t.goalId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$FinanceTransactionsTableAnnotationComposer(
                $db: $db,
                $table: $db.financeTransactions,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }

  Expression<T> workoutLogsRefs<T extends Object>(
    Expression<T> Function($$WorkoutLogsTableAnnotationComposer a) f,
  ) {
    final $$WorkoutLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.workoutLogs,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$WorkoutLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.workoutLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> learningSessionsRefs<T extends Object>(
    Expression<T> Function($$LearningSessionsTableAnnotationComposer a) f,
  ) {
    final $$LearningSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningSessions,
      getReferencedColumn: (t) => t.goalId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$GoalsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalsTable,
          Goal,
          $$GoalsTableFilterComposer,
          $$GoalsTableOrderingComposer,
          $$GoalsTableAnnotationComposer,
          $$GoalsTableCreateCompanionBuilder,
          $$GoalsTableUpdateCompanionBuilder,
          (Goal, $$GoalsTableReferences),
          Goal,
          PrefetchHooks Function({
            bool goalActionsRefs,
            bool goalMilestonesRefs,
            bool goalProgressEventsRefs,
            bool tasksRefs,
            bool quranLogsRefs,
            bool workActivitiesRefs,
            bool financeTransactionsRefs,
            bool workoutLogsRefs,
            bool learningSessionsRefs,
          })
        > {
  $$GoalsTableTableManager(_$AppDatabase db, $GoalsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<LifeArea> area = const Value.absent(),
                Value<GoalType> type = const Value.absent(),
                Value<String> unit = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<double> startValue = const Value.absent(),
                Value<GoalFrequency> frequency = const Value.absent(),
                Value<int> periodTarget = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<String?> why = const Value.absent(),
                Value<GoalStatus> status = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion(
                id: id,
                title: title,
                description: description,
                area: area,
                type: type,
                unit: unit,
                targetValue: targetValue,
                startValue: startValue,
                frequency: frequency,
                periodTarget: periodTarget,
                targetDate: targetDate,
                why: why,
                status: status,
                isPrimary: isPrimary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                Value<String?> description = const Value.absent(),
                required LifeArea area,
                required GoalType type,
                Value<String> unit = const Value.absent(),
                Value<double> targetValue = const Value.absent(),
                Value<double> startValue = const Value.absent(),
                Value<GoalFrequency> frequency = const Value.absent(),
                Value<int> periodTarget = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<String?> why = const Value.absent(),
                Value<GoalStatus> status = const Value.absent(),
                Value<bool> isPrimary = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalsCompanion.insert(
                id: id,
                title: title,
                description: description,
                area: area,
                type: type,
                unit: unit,
                targetValue: targetValue,
                startValue: startValue,
                frequency: frequency,
                periodTarget: periodTarget,
                targetDate: targetDate,
                why: why,
                status: status,
                isPrimary: isPrimary,
                createdAt: createdAt,
                updatedAt: updatedAt,
                completedAt: completedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalsTable, Goal>(table),
                  $$GoalsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                goalActionsRefs = false,
                goalMilestonesRefs = false,
                goalProgressEventsRefs = false,
                tasksRefs = false,
                quranLogsRefs = false,
                workActivitiesRefs = false,
                financeTransactionsRefs = false,
                workoutLogsRefs = false,
                learningSessionsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (goalActionsRefs) db.goalActions,
                    if (goalMilestonesRefs) db.goalMilestones,
                    if (goalProgressEventsRefs) db.goalProgressEvents,
                    if (tasksRefs) db.tasks,
                    if (quranLogsRefs) db.quranLogs,
                    if (workActivitiesRefs) db.workActivities,
                    if (financeTransactionsRefs) db.financeTransactions,
                    if (workoutLogsRefs) db.workoutLogs,
                    if (learningSessionsRefs) db.learningSessions,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (goalActionsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          GoalAction
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._goalActionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).goalActionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalMilestonesRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          GoalMilestone
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._goalMilestonesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).goalMilestonesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (goalProgressEventsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          GoalProgressEvent
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._goalProgressEventsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).goalProgressEventsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (tasksRefs)
                        await $_getPrefetchedData<Goal, $GoalsTable, Task>(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._tasksRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(db, table, p0).tasksRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (quranLogsRefs)
                        await $_getPrefetchedData<Goal, $GoalsTable, QuranLog>(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._quranLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).quranLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workActivitiesRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          WorkActivity
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._workActivitiesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).workActivitiesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (financeTransactionsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          FinanceTransaction
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._financeTransactionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).financeTransactionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (workoutLogsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          WorkoutLog
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._workoutLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).workoutLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (learningSessionsRefs)
                        await $_getPrefetchedData<
                          Goal,
                          $GoalsTable,
                          LearningSession
                        >(
                          currentTable: table,
                          referencedTable: $$GoalsTableReferences
                              ._learningSessionsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$GoalsTableReferences(
                                db,
                                table,
                                p0,
                              ).learningSessionsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.goalId == item.id,
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

typedef $$GoalsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalsTable,
      Goal,
      $$GoalsTableFilterComposer,
      $$GoalsTableOrderingComposer,
      $$GoalsTableAnnotationComposer,
      $$GoalsTableCreateCompanionBuilder,
      $$GoalsTableUpdateCompanionBuilder,
      (Goal, $$GoalsTableReferences),
      Goal,
      PrefetchHooks Function({
        bool goalActionsRefs,
        bool goalMilestonesRefs,
        bool goalProgressEventsRefs,
        bool tasksRefs,
        bool quranLogsRefs,
        bool workActivitiesRefs,
        bool financeTransactionsRefs,
        bool workoutLogsRefs,
        bool learningSessionsRefs,
      })
    >;
typedef $$GoalActionsTableCreateCompanionBuilder =
    GoalActionsCompanion Function({
      required String id,
      required String goalId,
      required String title,
      Value<String?> detail,
      Value<GoalFrequency> frequency,
      Value<DateTime?> lastCompletedAt,
      Value<int> sortOrder,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$GoalActionsTableUpdateCompanionBuilder =
    GoalActionsCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<String> title,
      Value<String?> detail,
      Value<GoalFrequency> frequency,
      Value<DateTime?> lastCompletedAt,
      Value<int> sortOrder,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$GoalActionsTableReferences
    extends BaseReferences<_$AppDatabase, $GoalActionsTable, GoalAction> {
  $$GoalActionsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('goal_actions__goal_id__goals__id');

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<String>('goal_id')!;

    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalActionsTableFilterComposer
    extends Composer<_$AppDatabase, $GoalActionsTable> {
  $$GoalActionsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<GoalFrequency, GoalFrequency, String>
  get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalActionsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalActionsTable> {
  $$GoalActionsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get frequency => $composableBuilder(
    column: $table.frequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalActionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalActionsTable> {
  $$GoalActionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumnWithTypeConverter<GoalFrequency, String> get frequency =>
      $composableBuilder(column: $table.frequency, builder: (column) => column);

  GeneratedColumn<DateTime> get lastCompletedAt => $composableBuilder(
    column: $table.lastCompletedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalActionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalActionsTable,
          GoalAction,
          $$GoalActionsTableFilterComposer,
          $$GoalActionsTableOrderingComposer,
          $$GoalActionsTableAnnotationComposer,
          $$GoalActionsTableCreateCompanionBuilder,
          $$GoalActionsTableUpdateCompanionBuilder,
          (GoalAction, $$GoalActionsTableReferences),
          GoalAction,
          PrefetchHooks Function({bool goalId})
        > {
  $$GoalActionsTableTableManager(_$AppDatabase db, $GoalActionsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalActionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalActionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalActionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<GoalFrequency> frequency = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalActionsCompanion(
                id: id,
                goalId: goalId,
                title: title,
                detail: detail,
                frequency: frequency,
                lastCompletedAt: lastCompletedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required String title,
                Value<String?> detail = const Value.absent(),
                Value<GoalFrequency> frequency = const Value.absent(),
                Value<DateTime?> lastCompletedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalActionsCompanion.insert(
                id: id,
                goalId: goalId,
                title: title,
                detail: detail,
                frequency: frequency,
                lastCompletedAt: lastCompletedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalActionsTable, GoalAction>(table),
                  $$GoalActionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$GoalActionsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$GoalActionsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$GoalActionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalActionsTable,
      GoalAction,
      $$GoalActionsTableFilterComposer,
      $$GoalActionsTableOrderingComposer,
      $$GoalActionsTableAnnotationComposer,
      $$GoalActionsTableCreateCompanionBuilder,
      $$GoalActionsTableUpdateCompanionBuilder,
      (GoalAction, $$GoalActionsTableReferences),
      GoalAction,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$GoalMilestonesTableCreateCompanionBuilder =
    GoalMilestonesCompanion Function({
      required String id,
      required String goalId,
      required String title,
      Value<DateTime?> targetDate,
      Value<DateTime?> completedAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });
typedef $$GoalMilestonesTableUpdateCompanionBuilder =
    GoalMilestonesCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<String> title,
      Value<DateTime?> targetDate,
      Value<DateTime?> completedAt,
      Value<int> sortOrder,
      Value<int> rowid,
    });

final class $$GoalMilestonesTableReferences
    extends BaseReferences<_$AppDatabase, $GoalMilestonesTable, GoalMilestone> {
  $$GoalMilestonesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('goal_milestones__goal_id__goals__id');

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<String>('goal_id')!;

    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalMilestonesTableFilterComposer
    extends Composer<_$AppDatabase, $GoalMilestonesTable> {
  $$GoalMilestonesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalMilestonesTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalMilestonesTable> {
  $$GoalMilestonesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalMilestonesTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalMilestonesTable> {
  $$GoalMilestonesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<DateTime> get targetDate => $composableBuilder(
    column: $table.targetDate,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalMilestonesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalMilestonesTable,
          GoalMilestone,
          $$GoalMilestonesTableFilterComposer,
          $$GoalMilestonesTableOrderingComposer,
          $$GoalMilestonesTableAnnotationComposer,
          $$GoalMilestonesTableCreateCompanionBuilder,
          $$GoalMilestonesTableUpdateCompanionBuilder,
          (GoalMilestone, $$GoalMilestonesTableReferences),
          GoalMilestone,
          PrefetchHooks Function({bool goalId})
        > {
  $$GoalMilestonesTableTableManager(
    _$AppDatabase db,
    $GoalMilestonesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalMilestonesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalMilestonesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalMilestonesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalMilestonesCompanion(
                id: id,
                goalId: goalId,
                title: title,
                targetDate: targetDate,
                completedAt: completedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required String title,
                Value<DateTime?> targetDate = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalMilestonesCompanion.insert(
                id: id,
                goalId: goalId,
                title: title,
                targetDate: targetDate,
                completedAt: completedAt,
                sortOrder: sortOrder,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalMilestonesTable, GoalMilestone>(table),
                  $$GoalMilestonesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$GoalMilestonesTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$GoalMilestonesTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$GoalMilestonesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalMilestonesTable,
      GoalMilestone,
      $$GoalMilestonesTableFilterComposer,
      $$GoalMilestonesTableOrderingComposer,
      $$GoalMilestonesTableAnnotationComposer,
      $$GoalMilestonesTableCreateCompanionBuilder,
      $$GoalMilestonesTableUpdateCompanionBuilder,
      (GoalMilestone, $$GoalMilestonesTableReferences),
      GoalMilestone,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$GoalProgressEventsTableCreateCompanionBuilder =
    GoalProgressEventsCompanion Function({
      required String id,
      required String goalId,
      required double delta,
      Value<String?> note,
      Value<ProgressSource> source,
      Value<String?> sourceId,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$GoalProgressEventsTableUpdateCompanionBuilder =
    GoalProgressEventsCompanion Function({
      Value<String> id,
      Value<String> goalId,
      Value<double> delta,
      Value<String?> note,
      Value<ProgressSource> source,
      Value<String?> sourceId,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$GoalProgressEventsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $GoalProgressEventsTable,
          GoalProgressEvent
        > {
  $$GoalProgressEventsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('goal_progress_events__goal_id__goals__id');

  $$GoalsTableProcessedTableManager get goalId {
    final $_column = $_itemColumn<String>('goal_id')!;

    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$GoalProgressEventsTableFilterComposer
    extends Composer<_$AppDatabase, $GoalProgressEventsTable> {
  $$GoalProgressEventsTableFilterComposer({
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

  ColumnFilters<double> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ProgressSource, ProgressSource, String>
  get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalProgressEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $GoalProgressEventsTable> {
  $$GoalProgressEventsTableOrderingComposer({
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

  ColumnOrderings<double> get delta => $composableBuilder(
    column: $table.delta,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get source => $composableBuilder(
    column: $table.source,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceId => $composableBuilder(
    column: $table.sourceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalProgressEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GoalProgressEventsTable> {
  $$GoalProgressEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<double> get delta =>
      $composableBuilder(column: $table.delta, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ProgressSource, String> get source =>
      $composableBuilder(column: $table.source, builder: (column) => column);

  GeneratedColumn<String> get sourceId =>
      $composableBuilder(column: $table.sourceId, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$GoalProgressEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GoalProgressEventsTable,
          GoalProgressEvent,
          $$GoalProgressEventsTableFilterComposer,
          $$GoalProgressEventsTableOrderingComposer,
          $$GoalProgressEventsTableAnnotationComposer,
          $$GoalProgressEventsTableCreateCompanionBuilder,
          $$GoalProgressEventsTableUpdateCompanionBuilder,
          (GoalProgressEvent, $$GoalProgressEventsTableReferences),
          GoalProgressEvent,
          PrefetchHooks Function({bool goalId})
        > {
  $$GoalProgressEventsTableTableManager(
    _$AppDatabase db,
    $GoalProgressEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GoalProgressEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GoalProgressEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GoalProgressEventsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> goalId = const Value.absent(),
                Value<double> delta = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<ProgressSource> source = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GoalProgressEventsCompanion(
                id: id,
                goalId: goalId,
                delta: delta,
                note: note,
                source: source,
                sourceId: sourceId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String goalId,
                required double delta,
                Value<String?> note = const Value.absent(),
                Value<ProgressSource> source = const Value.absent(),
                Value<String?> sourceId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => GoalProgressEventsCompanion.insert(
                id: id,
                goalId: goalId,
                delta: delta,
                note: note,
                source: source,
                sourceId: sourceId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GoalProgressEventsTable, GoalProgressEvent>(
                    table,
                  ),
                  $$GoalProgressEventsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$GoalProgressEventsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$GoalProgressEventsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$GoalProgressEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GoalProgressEventsTable,
      GoalProgressEvent,
      $$GoalProgressEventsTableFilterComposer,
      $$GoalProgressEventsTableOrderingComposer,
      $$GoalProgressEventsTableAnnotationComposer,
      $$GoalProgressEventsTableCreateCompanionBuilder,
      $$GoalProgressEventsTableUpdateCompanionBuilder,
      (GoalProgressEvent, $$GoalProgressEventsTableReferences),
      GoalProgressEvent,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$TasksTableCreateCompanionBuilder = TasksCompanion Function({
  required String id,
  required String dayKey,
  required String title,
  required LifeArea area,
  Value<String?> goalId,
  Value<int?> scheduledMinute,
  Value<int?> durationMinutes,
  Value<String?> badge,
  Value<String?> note,
  Value<int?> priorityRank,
  Value<DateTime?> completedAt,
  Value<int> sortOrder,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$TasksTableUpdateCompanionBuilder = TasksCompanion Function({
  Value<String> id,
  Value<String> dayKey,
  Value<String> title,
  Value<LifeArea> area,
  Value<String?> goalId,
  Value<int?> scheduledMinute,
  Value<int?> durationMinutes,
  Value<String?> badge,
  Value<String?> note,
  Value<int?> priorityRank,
  Value<DateTime?> completedAt,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$TasksTableReferences
    extends BaseReferences<_$AppDatabase, $TasksTable, Task> {
  $$TasksTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('tasks__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TasksTableFilterComposer extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableFilterComposer({
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

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LifeArea, LifeArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get scheduledMinute => $composableBuilder(
    column: $table.scheduledMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get priorityRank => $composableBuilder(
    column: $table.priorityRank,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableOrderingComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableOrderingComposer({
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

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get scheduledMinute => $composableBuilder(
    column: $table.scheduledMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get badge => $composableBuilder(
    column: $table.badge,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get priorityRank => $composableBuilder(
    column: $table.priorityRank,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableAnnotationComposer
    extends Composer<_$AppDatabase, $TasksTable> {
  $$TasksTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LifeArea, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<int> get scheduledMinute => $composableBuilder(
    column: $table.scheduledMinute,
    builder: (column) => column,
  );

  GeneratedColumn<int> get durationMinutes => $composableBuilder(
    column: $table.durationMinutes,
    builder: (column) => column,
  );

  GeneratedColumn<String> get badge =>
      $composableBuilder(column: $table.badge, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<int> get priorityRank => $composableBuilder(
    column: $table.priorityRank,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TasksTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TasksTable,
          Task,
          $$TasksTableFilterComposer,
          $$TasksTableOrderingComposer,
          $$TasksTableAnnotationComposer,
          $$TasksTableCreateCompanionBuilder,
          $$TasksTableUpdateCompanionBuilder,
          (Task, $$TasksTableReferences),
          Task,
          PrefetchHooks Function({bool goalId})
        > {
  $$TasksTableTableManager(_$AppDatabase db, $TasksTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TasksTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TasksTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TasksTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<LifeArea> area = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<int?> scheduledMinute = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> badge = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> priorityRank = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion(
                id: id,
                dayKey: dayKey,
                title: title,
                area: area,
                goalId: goalId,
                scheduledMinute: scheduledMinute,
                durationMinutes: durationMinutes,
                badge: badge,
                note: note,
                priorityRank: priorityRank,
                completedAt: completedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dayKey,
                required String title,
                required LifeArea area,
                Value<String?> goalId = const Value.absent(),
                Value<int?> scheduledMinute = const Value.absent(),
                Value<int?> durationMinutes = const Value.absent(),
                Value<String?> badge = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<int?> priorityRank = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => TasksCompanion.insert(
                id: id,
                dayKey: dayKey,
                title: title,
                area: area,
                goalId: goalId,
                scheduledMinute: scheduledMinute,
                durationMinutes: durationMinutes,
                badge: badge,
                note: note,
                priorityRank: priorityRank,
                completedAt: completedAt,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TasksTable, Task>(table),
                  $$TasksTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$TasksTableReferences._goalIdTable(
                          db,
                        ),
                        referencedColumn: $$TasksTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$TasksTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TasksTable,
      Task,
      $$TasksTableFilterComposer,
      $$TasksTableOrderingComposer,
      $$TasksTableAnnotationComposer,
      $$TasksTableCreateCompanionBuilder,
      $$TasksTableUpdateCompanionBuilder,
      (Task, $$TasksTableReferences),
      Task,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$MorningCheckInsTableCreateCompanionBuilder =
    MorningCheckInsCompanion Function({
      required String dayKey,
      required Energy energy,
      required Capacity capacity,
      Value<String?> intention,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$MorningCheckInsTableUpdateCompanionBuilder =
    MorningCheckInsCompanion Function({
      Value<String> dayKey,
      Value<Energy> energy,
      Value<Capacity> capacity,
      Value<String?> intention,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$MorningCheckInsTableFilterComposer
    extends Composer<_$AppDatabase, $MorningCheckInsTable> {
  $$MorningCheckInsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Energy, Energy, String> get energy =>
      $composableBuilder(
        column: $table.energy,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<Capacity, Capacity, String> get capacity =>
      $composableBuilder(
        column: $table.capacity,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MorningCheckInsTableOrderingComposer
    extends Composer<_$AppDatabase, $MorningCheckInsTable> {
  $$MorningCheckInsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get capacity => $composableBuilder(
    column: $table.capacity,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get intention => $composableBuilder(
    column: $table.intention,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MorningCheckInsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MorningCheckInsTable> {
  $$MorningCheckInsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Energy, String> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Capacity, String> get capacity =>
      $composableBuilder(column: $table.capacity, builder: (column) => column);

  GeneratedColumn<String> get intention =>
      $composableBuilder(column: $table.intention, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$MorningCheckInsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MorningCheckInsTable,
          MorningCheckIn,
          $$MorningCheckInsTableFilterComposer,
          $$MorningCheckInsTableOrderingComposer,
          $$MorningCheckInsTableAnnotationComposer,
          $$MorningCheckInsTableCreateCompanionBuilder,
          $$MorningCheckInsTableUpdateCompanionBuilder,
          (
            MorningCheckIn,
            BaseReferences<
              _$AppDatabase,
              $MorningCheckInsTable,
              MorningCheckIn
            >,
          ),
          MorningCheckIn,
          PrefetchHooks Function()
        > {
  $$MorningCheckInsTableTableManager(
    _$AppDatabase db,
    $MorningCheckInsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MorningCheckInsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MorningCheckInsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MorningCheckInsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dayKey = const Value.absent(),
                Value<Energy> energy = const Value.absent(),
                Value<Capacity> capacity = const Value.absent(),
                Value<String?> intention = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MorningCheckInsCompanion(
                dayKey: dayKey,
                energy: energy,
                capacity: capacity,
                intention: intention,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dayKey,
                required Energy energy,
                required Capacity capacity,
                Value<String?> intention = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => MorningCheckInsCompanion.insert(
                dayKey: dayKey,
                energy: energy,
                capacity: capacity,
                intention: intention,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MorningCheckInsTable, MorningCheckIn>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MorningCheckInsTable,
                    MorningCheckIn
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MorningCheckInsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MorningCheckInsTable,
      MorningCheckIn,
      $$MorningCheckInsTableFilterComposer,
      $$MorningCheckInsTableOrderingComposer,
      $$MorningCheckInsTableAnnotationComposer,
      $$MorningCheckInsTableCreateCompanionBuilder,
      $$MorningCheckInsTableUpdateCompanionBuilder,
      (
        MorningCheckIn,
        BaseReferences<_$AppDatabase, $MorningCheckInsTable, MorningCheckIn>,
      ),
      MorningCheckIn,
      PrefetchHooks Function()
    >;
typedef $$NightReviewsTableCreateCompanionBuilder =
    NightReviewsCompanion Function({
      required String dayKey,
      required int rating,
      Value<String> wentWellTags,
      Value<String?> wentWellNote,
      Value<String> betterTags,
      Value<String?> betterNote,
      Value<String?> biggestWin,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$NightReviewsTableUpdateCompanionBuilder =
    NightReviewsCompanion Function({
      Value<String> dayKey,
      Value<int> rating,
      Value<String> wentWellTags,
      Value<String?> wentWellNote,
      Value<String> betterTags,
      Value<String?> betterNote,
      Value<String?> biggestWin,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

class $$NightReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $NightReviewsTable> {
  $$NightReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get betterTags => $composableBuilder(
    column: $table.betterTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get betterNote => $composableBuilder(
    column: $table.betterNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NightReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $NightReviewsTable> {
  $$NightReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get rating => $composableBuilder(
    column: $table.rating,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get betterTags => $composableBuilder(
    column: $table.betterTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get betterNote => $composableBuilder(
    column: $table.betterNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NightReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $NightReviewsTable> {
  $$NightReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<int> get rating =>
      $composableBuilder(column: $table.rating, builder: (column) => column);

  GeneratedColumn<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get betterTags => $composableBuilder(
    column: $table.betterTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get betterNote => $composableBuilder(
    column: $table.betterNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NightReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NightReviewsTable,
          NightReview,
          $$NightReviewsTableFilterComposer,
          $$NightReviewsTableOrderingComposer,
          $$NightReviewsTableAnnotationComposer,
          $$NightReviewsTableCreateCompanionBuilder,
          $$NightReviewsTableUpdateCompanionBuilder,
          (
            NightReview,
            BaseReferences<_$AppDatabase, $NightReviewsTable, NightReview>,
          ),
          NightReview,
          PrefetchHooks Function()
        > {
  $$NightReviewsTableTableManager(_$AppDatabase db, $NightReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NightReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NightReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NightReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> dayKey = const Value.absent(),
                Value<int> rating = const Value.absent(),
                Value<String> wentWellTags = const Value.absent(),
                Value<String?> wentWellNote = const Value.absent(),
                Value<String> betterTags = const Value.absent(),
                Value<String?> betterNote = const Value.absent(),
                Value<String?> biggestWin = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NightReviewsCompanion(
                dayKey: dayKey,
                rating: rating,
                wentWellTags: wentWellTags,
                wentWellNote: wentWellNote,
                betterTags: betterTags,
                betterNote: betterNote,
                biggestWin: biggestWin,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String dayKey,
                required int rating,
                Value<String> wentWellTags = const Value.absent(),
                Value<String?> wentWellNote = const Value.absent(),
                Value<String> betterTags = const Value.absent(),
                Value<String?> betterNote = const Value.absent(),
                Value<String?> biggestWin = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NightReviewsCompanion.insert(
                dayKey: dayKey,
                rating: rating,
                wentWellTags: wentWellTags,
                wentWellNote: wentWellNote,
                betterTags: betterTags,
                betterNote: betterNote,
                biggestWin: biggestWin,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NightReviewsTable, NightReview>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $NightReviewsTable,
                    NightReview
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NightReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NightReviewsTable,
      NightReview,
      $$NightReviewsTableFilterComposer,
      $$NightReviewsTableOrderingComposer,
      $$NightReviewsTableAnnotationComposer,
      $$NightReviewsTableCreateCompanionBuilder,
      $$NightReviewsTableUpdateCompanionBuilder,
      (
        NightReview,
        BaseReferences<_$AppDatabase, $NightReviewsTable, NightReview>,
      ),
      NightReview,
      PrefetchHooks Function()
    >;
typedef $$QuranLogsTableCreateCompanionBuilder = QuranLogsCompanion Function({
  required String id,
  required QuranKind kind,
  Value<double> pages,
  Value<int> minutes,
  Value<String?> surah,
  Value<String?> note,
  Value<String?> goalId,
  required DateTime occurredAt,
  Value<int> rowid,
});
typedef $$QuranLogsTableUpdateCompanionBuilder = QuranLogsCompanion Function({
  Value<String> id,
  Value<QuranKind> kind,
  Value<double> pages,
  Value<int> minutes,
  Value<String?> surah,
  Value<String?> note,
  Value<String?> goalId,
  Value<DateTime> occurredAt,
  Value<int> rowid,
});

final class $$QuranLogsTableReferences
    extends BaseReferences<_$AppDatabase, $QuranLogsTable, QuranLog> {
  $$QuranLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('quran_logs__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$QuranLogsTableFilterComposer
    extends Composer<_$AppDatabase, $QuranLogsTable> {
  $$QuranLogsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<QuranKind, QuranKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<double> get pages => $composableBuilder(
    column: $table.pages,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuranLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $QuranLogsTable> {
  $$QuranLogsTableOrderingComposer({
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

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get pages => $composableBuilder(
    column: $table.pages,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get surah => $composableBuilder(
    column: $table.surah,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuranLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $QuranLogsTable> {
  $$QuranLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<QuranKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<double> get pages =>
      $composableBuilder(column: $table.pages, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<String> get surah =>
      $composableBuilder(column: $table.surah, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$QuranLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $QuranLogsTable,
          QuranLog,
          $$QuranLogsTableFilterComposer,
          $$QuranLogsTableOrderingComposer,
          $$QuranLogsTableAnnotationComposer,
          $$QuranLogsTableCreateCompanionBuilder,
          $$QuranLogsTableUpdateCompanionBuilder,
          (QuranLog, $$QuranLogsTableReferences),
          QuranLog,
          PrefetchHooks Function({bool goalId})
        > {
  $$QuranLogsTableTableManager(_$AppDatabase db, $QuranLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$QuranLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$QuranLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$QuranLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<QuranKind> kind = const Value.absent(),
                Value<double> pages = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<String?> surah = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => QuranLogsCompanion(
                id: id,
                kind: kind,
                pages: pages,
                minutes: minutes,
                surah: surah,
                note: note,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required QuranKind kind,
                Value<double> pages = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<String?> surah = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => QuranLogsCompanion.insert(
                id: id,
                kind: kind,
                pages: pages,
                minutes: minutes,
                surah: surah,
                note: note,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$QuranLogsTable, QuranLog>(table),
                  $$QuranLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$QuranLogsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$QuranLogsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$QuranLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $QuranLogsTable,
      QuranLog,
      $$QuranLogsTableFilterComposer,
      $$QuranLogsTableOrderingComposer,
      $$QuranLogsTableAnnotationComposer,
      $$QuranLogsTableCreateCompanionBuilder,
      $$QuranLogsTableUpdateCompanionBuilder,
      (QuranLog, $$QuranLogsTableReferences),
      QuranLog,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$WorkActivitiesTableCreateCompanionBuilder =
    WorkActivitiesCompanion Function({
      required String id,
      required WorkKind kind,
      required String title,
      Value<String?> counterpart,
      Value<String?> detail,
      Value<int?> valueMinor,
      Value<int?> minutes,
      Value<DateTime?> scheduledAt,
      Value<String?> goalId,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$WorkActivitiesTableUpdateCompanionBuilder =
    WorkActivitiesCompanion Function({
      Value<String> id,
      Value<WorkKind> kind,
      Value<String> title,
      Value<String?> counterpart,
      Value<String?> detail,
      Value<int?> valueMinor,
      Value<int?> minutes,
      Value<DateTime?> scheduledAt,
      Value<String?> goalId,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$WorkActivitiesTableReferences
    extends BaseReferences<_$AppDatabase, $WorkActivitiesTable, WorkActivity> {
  $$WorkActivitiesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('work_activities__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkActivitiesTableFilterComposer
    extends Composer<_$AppDatabase, $WorkActivitiesTable> {
  $$WorkActivitiesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<WorkKind, WorkKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get counterpart => $composableBuilder(
    column: $table.counterpart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get valueMinor => $composableBuilder(
    column: $table.valueMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkActivitiesTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkActivitiesTable> {
  $$WorkActivitiesTableOrderingComposer({
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

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get counterpart => $composableBuilder(
    column: $table.counterpart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get valueMinor => $composableBuilder(
    column: $table.valueMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkActivitiesTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkActivitiesTable> {
  $$WorkActivitiesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<WorkKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get counterpart => $composableBuilder(
    column: $table.counterpart,
    builder: (column) => column,
  );

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<int> get valueMinor => $composableBuilder(
    column: $table.valueMinor,
    builder: (column) => column,
  );

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<DateTime> get scheduledAt => $composableBuilder(
    column: $table.scheduledAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkActivitiesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkActivitiesTable,
          WorkActivity,
          $$WorkActivitiesTableFilterComposer,
          $$WorkActivitiesTableOrderingComposer,
          $$WorkActivitiesTableAnnotationComposer,
          $$WorkActivitiesTableCreateCompanionBuilder,
          $$WorkActivitiesTableUpdateCompanionBuilder,
          (WorkActivity, $$WorkActivitiesTableReferences),
          WorkActivity,
          PrefetchHooks Function({bool goalId})
        > {
  $$WorkActivitiesTableTableManager(
    _$AppDatabase db,
    $WorkActivitiesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkActivitiesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkActivitiesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkActivitiesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<WorkKind> kind = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> counterpart = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<int?> valueMinor = const Value.absent(),
                Value<int?> minutes = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkActivitiesCompanion(
                id: id,
                kind: kind,
                title: title,
                counterpart: counterpart,
                detail: detail,
                valueMinor: valueMinor,
                minutes: minutes,
                scheduledAt: scheduledAt,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required WorkKind kind,
                required String title,
                Value<String?> counterpart = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<int?> valueMinor = const Value.absent(),
                Value<int?> minutes = const Value.absent(),
                Value<DateTime?> scheduledAt = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkActivitiesCompanion.insert(
                id: id,
                kind: kind,
                title: title,
                counterpart: counterpart,
                detail: detail,
                valueMinor: valueMinor,
                minutes: minutes,
                scheduledAt: scheduledAt,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkActivitiesTable, WorkActivity>(table),
                  $$WorkActivitiesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$WorkActivitiesTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$WorkActivitiesTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$WorkActivitiesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkActivitiesTable,
      WorkActivity,
      $$WorkActivitiesTableFilterComposer,
      $$WorkActivitiesTableOrderingComposer,
      $$WorkActivitiesTableAnnotationComposer,
      $$WorkActivitiesTableCreateCompanionBuilder,
      $$WorkActivitiesTableUpdateCompanionBuilder,
      (WorkActivity, $$WorkActivitiesTableReferences),
      WorkActivity,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$FinanceTransactionsTableCreateCompanionBuilder =
    FinanceTransactionsCompanion Function({
      required String id,
      required TransactionType type,
      required int amountMinor,
      required String category,
      Value<String?> note,
      Value<MoneyTag> tag,
      Value<String?> goalId,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$FinanceTransactionsTableUpdateCompanionBuilder =
    FinanceTransactionsCompanion Function({
      Value<String> id,
      Value<TransactionType> type,
      Value<int> amountMinor,
      Value<String> category,
      Value<String?> note,
      Value<MoneyTag> tag,
      Value<String?> goalId,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$FinanceTransactionsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $FinanceTransactionsTable,
          FinanceTransaction
        > {
  $$FinanceTransactionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('finance_transactions__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$FinanceTransactionsTableFilterComposer
    extends Composer<_$AppDatabase, $FinanceTransactionsTable> {
  $$FinanceTransactionsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<TransactionType, TransactionType, String>
  get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<MoneyTag, MoneyTag, String> get tag =>
      $composableBuilder(
        column: $table.tag,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinanceTransactionsTableOrderingComposer
    extends Composer<_$AppDatabase, $FinanceTransactionsTable> {
  $$FinanceTransactionsTableOrderingComposer({
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

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get category => $composableBuilder(
    column: $table.category,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tag => $composableBuilder(
    column: $table.tag,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinanceTransactionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $FinanceTransactionsTable> {
  $$FinanceTransactionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<TransactionType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get category =>
      $composableBuilder(column: $table.category, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MoneyTag, String> get tag =>
      $composableBuilder(column: $table.tag, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$FinanceTransactionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FinanceTransactionsTable,
          FinanceTransaction,
          $$FinanceTransactionsTableFilterComposer,
          $$FinanceTransactionsTableOrderingComposer,
          $$FinanceTransactionsTableAnnotationComposer,
          $$FinanceTransactionsTableCreateCompanionBuilder,
          $$FinanceTransactionsTableUpdateCompanionBuilder,
          (FinanceTransaction, $$FinanceTransactionsTableReferences),
          FinanceTransaction,
          PrefetchHooks Function({bool goalId})
        > {
  $$FinanceTransactionsTableTableManager(
    _$AppDatabase db,
    $FinanceTransactionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FinanceTransactionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FinanceTransactionsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$FinanceTransactionsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<TransactionType> type = const Value.absent(),
                Value<int> amountMinor = const Value.absent(),
                Value<String> category = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<MoneyTag> tag = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FinanceTransactionsCompanion(
                id: id,
                type: type,
                amountMinor: amountMinor,
                category: category,
                note: note,
                tag: tag,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required TransactionType type,
                required int amountMinor,
                required String category,
                Value<String?> note = const Value.absent(),
                Value<MoneyTag> tag = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => FinanceTransactionsCompanion.insert(
                id: id,
                type: type,
                amountMinor: amountMinor,
                category: category,
                note: note,
                tag: tag,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FinanceTransactionsTable, FinanceTransaction>(
                    table,
                  ),
                  $$FinanceTransactionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$FinanceTransactionsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$FinanceTransactionsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$FinanceTransactionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FinanceTransactionsTable,
      FinanceTransaction,
      $$FinanceTransactionsTableFilterComposer,
      $$FinanceTransactionsTableOrderingComposer,
      $$FinanceTransactionsTableAnnotationComposer,
      $$FinanceTransactionsTableCreateCompanionBuilder,
      $$FinanceTransactionsTableUpdateCompanionBuilder,
      (FinanceTransaction, $$FinanceTransactionsTableReferences),
      FinanceTransaction,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$HabitsTableCreateCompanionBuilder = HabitsCompanion Function({
  required String id,
  required String name,
  required LifeArea area,
  Value<String?> label,
  Value<String?> templateId,
  Value<int?> reminderMinute,
  Value<bool> archived,
  Value<int> sortOrder,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$HabitsTableUpdateCompanionBuilder = HabitsCompanion Function({
  Value<String> id,
  Value<String> name,
  Value<LifeArea> area,
  Value<String?> label,
  Value<String?> templateId,
  Value<int?> reminderMinute,
  Value<bool> archived,
  Value<int> sortOrder,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HabitsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitsTable, Habit> {
  $$HabitsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$HabitLogsTable, List<HabitLog>>
  _habitLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.habitLogs,
    aliasName: 'habits__id__habit_logs__habit_id',
  );

  $$HabitLogsTableProcessedTableManager get habitLogsRefs {
    final manager = $$HabitLogsTableTableManager(
      $_db,
      $_db.habitLogs,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_habitLogsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RemindersTable, List<Reminder>>
  _remindersRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.reminders,
    aliasName: 'habits__id__reminders__habit_id',
  );

  $$RemindersTableProcessedTableManager get remindersRefs {
    final manager = $$RemindersTableTableManager(
      $_db,
      $_db.reminders,
    ).filter((f) => f.habitId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(_remindersRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LifeArea, LifeArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> habitLogsRefs(
    Expression<bool> Function($$HabitLogsTableFilterComposer f) f,
  ) {
    final $$HabitLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableFilterComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> remindersRefs(
    Expression<bool> Function($$RemindersTableFilterComposer f) f,
  ) {
    final $$RemindersTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableFilterComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get label => $composableBuilder(
    column: $table.label,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get sortOrder => $composableBuilder(
    column: $table.sortOrder,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LifeArea, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<String> get label =>
      $composableBuilder(column: $table.label, builder: (column) => column);

  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get reminderMinute => $composableBuilder(
    column: $table.reminderMinute,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<int> get sortOrder =>
      $composableBuilder(column: $table.sortOrder, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> habitLogsRefs<T extends Object>(
    Expression<T> Function($$HabitLogsTableAnnotationComposer a) f,
  ) {
    final $$HabitLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.habitLogs,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.habitLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> remindersRefs<T extends Object>(
    Expression<T> Function($$RemindersTableAnnotationComposer a) f,
  ) {
    final $$RemindersTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.reminders,
      getReferencedColumn: (t) => t.habitId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RemindersTableAnnotationComposer(
            $db: $db,
            $table: $db.reminders,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, $$HabitsTableReferences),
          Habit,
          PrefetchHooks Function({bool habitLogsRefs, bool remindersRefs})
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<LifeArea> area = const Value.absent(),
                Value<String?> label = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<int?> reminderMinute = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                name: name,
                area: area,
                label: label,
                templateId: templateId,
                reminderMinute: reminderMinute,
                archived: archived,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                required LifeArea area,
                Value<String?> label = const Value.absent(),
                Value<String?> templateId = const Value.absent(),
                Value<int?> reminderMinute = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<int> sortOrder = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                name: name,
                area: area,
                label: label,
                templateId: templateId,
                reminderMinute: reminderMinute,
                archived: archived,
                sortOrder: sortOrder,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitsTable, Habit>(table),
                  $$HabitsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({habitLogsRefs = false, remindersRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (habitLogsRefs) db.habitLogs,
                    if (remindersRefs) db.reminders,
                  ],
                  addJoins: null,
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (habitLogsRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          HabitLog
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._habitLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).habitLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (remindersRefs)
                        await $_getPrefetchedData<
                          Habit,
                          $HabitsTable,
                          Reminder
                        >(
                          currentTable: table,
                          referencedTable: $$HabitsTableReferences
                              ._remindersRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$HabitsTableReferences(
                                db,
                                table,
                                p0,
                              ).remindersRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.habitId == item.id,
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

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, $$HabitsTableReferences),
      Habit,
      PrefetchHooks Function({bool habitLogsRefs, bool remindersRefs})
    >;
typedef $$HabitLogsTableCreateCompanionBuilder = HabitLogsCompanion Function({
  required String id,
  required String habitId,
  required String dayKey,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$HabitLogsTableUpdateCompanionBuilder = HabitLogsCompanion Function({
  Value<String> id,
  Value<String> habitId,
  Value<String> dayKey,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

final class $$HabitLogsTableReferences
    extends BaseReferences<_$AppDatabase, $HabitLogsTable, HabitLog> {
  $$HabitLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('habit_logs__habit_id__habits__id');

  $$HabitsTableProcessedTableManager get habitId {
    final $_column = $_itemColumn<String>('habit_id')!;

    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$HabitLogsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableFilterComposer({
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

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableOrderingComposer({
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

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitLogsTable> {
  $$HabitLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$HabitLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitLogsTable,
          HabitLog,
          $$HabitLogsTableFilterComposer,
          $$HabitLogsTableOrderingComposer,
          $$HabitLogsTableAnnotationComposer,
          $$HabitLogsTableCreateCompanionBuilder,
          $$HabitLogsTableUpdateCompanionBuilder,
          (HabitLog, $$HabitLogsTableReferences),
          HabitLog,
          PrefetchHooks Function({bool habitId})
        > {
  $$HabitLogsTableTableManager(_$AppDatabase db, $HabitLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion(
                id: id,
                habitId: habitId,
                dayKey: dayKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required String dayKey,
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => HabitLogsCompanion.insert(
                id: id,
                habitId: habitId,
                dayKey: dayKey,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitLogsTable, HabitLog>(table),
                  $$HabitLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$HabitLogsTableReferences
                            ._habitIdTable(db),
                        referencedColumn: $$HabitLogsTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
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

typedef $$HabitLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitLogsTable,
      HabitLog,
      $$HabitLogsTableFilterComposer,
      $$HabitLogsTableOrderingComposer,
      $$HabitLogsTableAnnotationComposer,
      $$HabitLogsTableCreateCompanionBuilder,
      $$HabitLogsTableUpdateCompanionBuilder,
      (HabitLog, $$HabitLogsTableReferences),
      HabitLog,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$WorkoutLogsTableCreateCompanionBuilder =
    WorkoutLogsCompanion Function({
      required String id,
      required String title,
      required int minutes,
      Value<String?> detail,
      Value<String?> goalId,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$WorkoutLogsTableUpdateCompanionBuilder =
    WorkoutLogsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<int> minutes,
      Value<String?> detail,
      Value<String?> goalId,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$WorkoutLogsTableReferences
    extends BaseReferences<_$AppDatabase, $WorkoutLogsTable, WorkoutLog> {
  $$WorkoutLogsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('workout_logs__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$WorkoutLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get detail => $composableBuilder(
    column: $table.detail,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WorkoutLogsTable> {
  $$WorkoutLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<String> get detail =>
      $composableBuilder(column: $table.detail, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$WorkoutLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WorkoutLogsTable,
          WorkoutLog,
          $$WorkoutLogsTableFilterComposer,
          $$WorkoutLogsTableOrderingComposer,
          $$WorkoutLogsTableAnnotationComposer,
          $$WorkoutLogsTableCreateCompanionBuilder,
          $$WorkoutLogsTableUpdateCompanionBuilder,
          (WorkoutLog, $$WorkoutLogsTableReferences),
          WorkoutLog,
          PrefetchHooks Function({bool goalId})
        > {
  $$WorkoutLogsTableTableManager(_$AppDatabase db, $WorkoutLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WorkoutLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WorkoutLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WorkoutLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<String?> detail = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WorkoutLogsCompanion(
                id: id,
                title: title,
                minutes: minutes,
                detail: detail,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required int minutes,
                Value<String?> detail = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => WorkoutLogsCompanion.insert(
                id: id,
                title: title,
                minutes: minutes,
                detail: detail,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WorkoutLogsTable, WorkoutLog>(table),
                  $$WorkoutLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({goalId = false}) {
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
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$WorkoutLogsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$WorkoutLogsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$WorkoutLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WorkoutLogsTable,
      WorkoutLog,
      $$WorkoutLogsTableFilterComposer,
      $$WorkoutLogsTableOrderingComposer,
      $$WorkoutLogsTableAnnotationComposer,
      $$WorkoutLogsTableCreateCompanionBuilder,
      $$WorkoutLogsTableUpdateCompanionBuilder,
      (WorkoutLog, $$WorkoutLogsTableReferences),
      WorkoutLog,
      PrefetchHooks Function({bool goalId})
    >;
typedef $$WalkingLogsTableCreateCompanionBuilder =
    WalkingLogsCompanion Function({
      required String id,
      required int minutes,
      Value<int?> steps,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$WalkingLogsTableUpdateCompanionBuilder =
    WalkingLogsCompanion Function({
      Value<String> id,
      Value<int> minutes,
      Value<int?> steps,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

class $$WalkingLogsTableFilterComposer
    extends Composer<_$AppDatabase, $WalkingLogsTable> {
  $$WalkingLogsTableFilterComposer({
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

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WalkingLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $WalkingLogsTable> {
  $$WalkingLogsTableOrderingComposer({
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

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get steps => $composableBuilder(
    column: $table.steps,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WalkingLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WalkingLogsTable> {
  $$WalkingLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<int> get steps =>
      $composableBuilder(column: $table.steps, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );
}

class $$WalkingLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WalkingLogsTable,
          WalkingLog,
          $$WalkingLogsTableFilterComposer,
          $$WalkingLogsTableOrderingComposer,
          $$WalkingLogsTableAnnotationComposer,
          $$WalkingLogsTableCreateCompanionBuilder,
          $$WalkingLogsTableUpdateCompanionBuilder,
          (
            WalkingLog,
            BaseReferences<_$AppDatabase, $WalkingLogsTable, WalkingLog>,
          ),
          WalkingLog,
          PrefetchHooks Function()
        > {
  $$WalkingLogsTableTableManager(_$AppDatabase db, $WalkingLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WalkingLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WalkingLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WalkingLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<int?> steps = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WalkingLogsCompanion(
                id: id,
                minutes: minutes,
                steps: steps,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required int minutes,
                Value<int?> steps = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => WalkingLogsCompanion.insert(
                id: id,
                minutes: minutes,
                steps: steps,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WalkingLogsTable, WalkingLog>(table),
                  BaseReferences<_$AppDatabase, $WalkingLogsTable, WalkingLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WalkingLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WalkingLogsTable,
      WalkingLog,
      $$WalkingLogsTableFilterComposer,
      $$WalkingLogsTableOrderingComposer,
      $$WalkingLogsTableAnnotationComposer,
      $$WalkingLogsTableCreateCompanionBuilder,
      $$WalkingLogsTableUpdateCompanionBuilder,
      (
        WalkingLog,
        BaseReferences<_$AppDatabase, $WalkingLogsTable, WalkingLog>,
      ),
      WalkingLog,
      PrefetchHooks Function()
    >;
typedef $$SleepLogsTableCreateCompanionBuilder = SleepLogsCompanion Function({
  required String id,
  required String dayKey,
  required DateTime bedTime,
  required DateTime wakeTime,
  Value<Energy?> energy,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$SleepLogsTableUpdateCompanionBuilder = SleepLogsCompanion Function({
  Value<String> id,
  Value<String> dayKey,
  Value<DateTime> bedTime,
  Value<DateTime> wakeTime,
  Value<Energy?> energy,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$SleepLogsTableFilterComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableFilterComposer({
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

  ColumnFilters<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<Energy?, Energy, String> get energy =>
      $composableBuilder(
        column: $table.energy,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$SleepLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableOrderingComposer({
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

  ColumnOrderings<String> get dayKey => $composableBuilder(
    column: $table.dayKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get bedTime => $composableBuilder(
    column: $table.bedTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get wakeTime => $composableBuilder(
    column: $table.wakeTime,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get energy => $composableBuilder(
    column: $table.energy,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$SleepLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $SleepLogsTable> {
  $$SleepLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get dayKey =>
      $composableBuilder(column: $table.dayKey, builder: (column) => column);

  GeneratedColumn<DateTime> get bedTime =>
      $composableBuilder(column: $table.bedTime, builder: (column) => column);

  GeneratedColumn<DateTime> get wakeTime =>
      $composableBuilder(column: $table.wakeTime, builder: (column) => column);

  GeneratedColumnWithTypeConverter<Energy?, String> get energy =>
      $composableBuilder(column: $table.energy, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$SleepLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $SleepLogsTable,
          SleepLog,
          $$SleepLogsTableFilterComposer,
          $$SleepLogsTableOrderingComposer,
          $$SleepLogsTableAnnotationComposer,
          $$SleepLogsTableCreateCompanionBuilder,
          $$SleepLogsTableUpdateCompanionBuilder,
          (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
          SleepLog,
          PrefetchHooks Function()
        > {
  $$SleepLogsTableTableManager(_$AppDatabase db, $SleepLogsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$SleepLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$SleepLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$SleepLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> dayKey = const Value.absent(),
                Value<DateTime> bedTime = const Value.absent(),
                Value<DateTime> wakeTime = const Value.absent(),
                Value<Energy?> energy = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion(
                id: id,
                dayKey: dayKey,
                bedTime: bedTime,
                wakeTime: wakeTime,
                energy: energy,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String dayKey,
                required DateTime bedTime,
                required DateTime wakeTime,
                Value<Energy?> energy = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => SleepLogsCompanion.insert(
                id: id,
                dayKey: dayKey,
                bedTime: bedTime,
                wakeTime: wakeTime,
                energy: energy,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$SleepLogsTable, SleepLog>(table),
                  BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$SleepLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $SleepLogsTable,
      SleepLog,
      $$SleepLogsTableFilterComposer,
      $$SleepLogsTableOrderingComposer,
      $$SleepLogsTableAnnotationComposer,
      $$SleepLogsTableCreateCompanionBuilder,
      $$SleepLogsTableUpdateCompanionBuilder,
      (SleepLog, BaseReferences<_$AppDatabase, $SleepLogsTable, SleepLog>),
      SleepLog,
      PrefetchHooks Function()
    >;
typedef $$LearningResourcesTableCreateCompanionBuilder =
    LearningResourcesCompanion Function({
      required String id,
      required String title,
      required ResourceKind kind,
      required int totalUnits,
      Value<int> completedUnits,
      Value<String?> skill,
      Value<bool> archived,
      required DateTime createdAt,
      Value<int> rowid,
    });
typedef $$LearningResourcesTableUpdateCompanionBuilder =
    LearningResourcesCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<ResourceKind> kind,
      Value<int> totalUnits,
      Value<int> completedUnits,
      Value<String?> skill,
      Value<bool> archived,
      Value<DateTime> createdAt,
      Value<int> rowid,
    });

final class $$LearningResourcesTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $LearningResourcesTable,
          LearningResource
        > {
  $$LearningResourcesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static MultiTypedResultKey<$LearningSessionsTable, List<LearningSession>>
  _learningSessionsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.learningSessions,
    aliasName: 'learning_resources__id__learning_sessions__resource_id',
  );

  $$LearningSessionsTableProcessedTableManager get learningSessionsRefs {
    final manager = $$LearningSessionsTableTableManager(
      $_db,
      $_db.learningSessions,
    ).filter((f) => f.resourceId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _learningSessionsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$LearningResourcesTableFilterComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<ResourceKind, ResourceKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get completedUnits => $composableBuilder(
    column: $table.completedUnits,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skill => $composableBuilder(
    column: $table.skill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> learningSessionsRefs(
    Expression<bool> Function($$LearningSessionsTableFilterComposer f) f,
  ) {
    final $$LearningSessionsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningSessions,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningSessionsTableFilterComposer(
            $db: $db,
            $table: $db.learningSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningResourcesTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get completedUnits => $composableBuilder(
    column: $table.completedUnits,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skill => $composableBuilder(
    column: $table.skill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get archived => $composableBuilder(
    column: $table.archived,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$LearningResourcesTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningResourcesTable> {
  $$LearningResourcesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ResourceKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<int> get totalUnits => $composableBuilder(
    column: $table.totalUnits,
    builder: (column) => column,
  );

  GeneratedColumn<int> get completedUnits => $composableBuilder(
    column: $table.completedUnits,
    builder: (column) => column,
  );

  GeneratedColumn<String> get skill =>
      $composableBuilder(column: $table.skill, builder: (column) => column);

  GeneratedColumn<bool> get archived =>
      $composableBuilder(column: $table.archived, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  Expression<T> learningSessionsRefs<T extends Object>(
    Expression<T> Function($$LearningSessionsTableAnnotationComposer a) f,
  ) {
    final $$LearningSessionsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.learningSessions,
      getReferencedColumn: (t) => t.resourceId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningSessionsTableAnnotationComposer(
            $db: $db,
            $table: $db.learningSessions,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$LearningResourcesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningResourcesTable,
          LearningResource,
          $$LearningResourcesTableFilterComposer,
          $$LearningResourcesTableOrderingComposer,
          $$LearningResourcesTableAnnotationComposer,
          $$LearningResourcesTableCreateCompanionBuilder,
          $$LearningResourcesTableUpdateCompanionBuilder,
          (LearningResource, $$LearningResourcesTableReferences),
          LearningResource,
          PrefetchHooks Function({bool learningSessionsRefs})
        > {
  $$LearningResourcesTableTableManager(
    _$AppDatabase db,
    $LearningResourcesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningResourcesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningResourcesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningResourcesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<ResourceKind> kind = const Value.absent(),
                Value<int> totalUnits = const Value.absent(),
                Value<int> completedUnits = const Value.absent(),
                Value<String?> skill = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningResourcesCompanion(
                id: id,
                title: title,
                kind: kind,
                totalUnits: totalUnits,
                completedUnits: completedUnits,
                skill: skill,
                archived: archived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required ResourceKind kind,
                required int totalUnits,
                Value<int> completedUnits = const Value.absent(),
                Value<String?> skill = const Value.absent(),
                Value<bool> archived = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => LearningResourcesCompanion.insert(
                id: id,
                title: title,
                kind: kind,
                totalUnits: totalUnits,
                completedUnits: completedUnits,
                skill: skill,
                archived: archived,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningResourcesTable, LearningResource>(table),
                  $$LearningResourcesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({learningSessionsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (learningSessionsRefs) db.learningSessions,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (learningSessionsRefs)
                    await $_getPrefetchedData<
                      LearningResource,
                      $LearningResourcesTable,
                      LearningSession
                    >(
                      currentTable: table,
                      referencedTable: $$LearningResourcesTableReferences
                          ._learningSessionsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$LearningResourcesTableReferences(
                            db,
                            table,
                            p0,
                          ).learningSessionsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.resourceId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$LearningResourcesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningResourcesTable,
      LearningResource,
      $$LearningResourcesTableFilterComposer,
      $$LearningResourcesTableOrderingComposer,
      $$LearningResourcesTableAnnotationComposer,
      $$LearningResourcesTableCreateCompanionBuilder,
      $$LearningResourcesTableUpdateCompanionBuilder,
      (LearningResource, $$LearningResourcesTableReferences),
      LearningResource,
      PrefetchHooks Function({bool learningSessionsRefs})
    >;
typedef $$LearningSessionsTableCreateCompanionBuilder =
    LearningSessionsCompanion Function({
      required String id,
      required String topic,
      Value<String?> skill,
      required int minutes,
      Value<String?> resourceId,
      Value<String?> takeaway,
      Value<String?> goalId,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$LearningSessionsTableUpdateCompanionBuilder =
    LearningSessionsCompanion Function({
      Value<String> id,
      Value<String> topic,
      Value<String?> skill,
      Value<int> minutes,
      Value<String?> resourceId,
      Value<String?> takeaway,
      Value<String?> goalId,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

final class $$LearningSessionsTableReferences
    extends
        BaseReferences<_$AppDatabase, $LearningSessionsTable, LearningSession> {
  $$LearningSessionsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $LearningResourcesTable _resourceIdTable(_$AppDatabase db) => db
      .learningResources
      .createAlias('learning_sessions__resource_id__learning_resources__id');

  $$LearningResourcesTableProcessedTableManager? get resourceId {
    final $_column = $_itemColumn<String>('resource_id');
    if ($_column == null) return null;
    final manager = $$LearningResourcesTableTableManager(
      $_db,
      $_db.learningResources,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_resourceIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GoalsTable _goalIdTable(_$AppDatabase db) =>
      db.goals.createAlias('learning_sessions__goal_id__goals__id');

  $$GoalsTableProcessedTableManager? get goalId {
    final $_column = $_itemColumn<String>('goal_id');
    if ($_column == null) return null;
    final manager = $$GoalsTableTableManager(
      $_db,
      $_db.goals,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_goalIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$LearningSessionsTableFilterComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableFilterComposer({
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

  ColumnFilters<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get skill => $composableBuilder(
    column: $table.skill,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get takeaway => $composableBuilder(
    column: $table.takeaway,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );

  $$LearningResourcesTableFilterComposer get resourceId {
    final $$LearningResourcesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableFilterComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GoalsTableFilterComposer get goalId {
    final $$GoalsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableFilterComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningSessionsTableOrderingComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableOrderingComposer({
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

  ColumnOrderings<String> get topic => $composableBuilder(
    column: $table.topic,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get skill => $composableBuilder(
    column: $table.skill,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minutes => $composableBuilder(
    column: $table.minutes,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get takeaway => $composableBuilder(
    column: $table.takeaway,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$LearningResourcesTableOrderingComposer get resourceId {
    final $$LearningResourcesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.resourceId,
      referencedTable: $db.learningResources,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$LearningResourcesTableOrderingComposer(
            $db: $db,
            $table: $db.learningResources,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GoalsTableOrderingComposer get goalId {
    final $$GoalsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableOrderingComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningSessionsTableAnnotationComposer
    extends Composer<_$AppDatabase, $LearningSessionsTable> {
  $$LearningSessionsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get topic =>
      $composableBuilder(column: $table.topic, builder: (column) => column);

  GeneratedColumn<String> get skill =>
      $composableBuilder(column: $table.skill, builder: (column) => column);

  GeneratedColumn<int> get minutes =>
      $composableBuilder(column: $table.minutes, builder: (column) => column);

  GeneratedColumn<String> get takeaway =>
      $composableBuilder(column: $table.takeaway, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );

  $$LearningResourcesTableAnnotationComposer get resourceId {
    final $$LearningResourcesTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.resourceId,
          referencedTable: $db.learningResources,
          getReferencedColumn: (t) => t.id,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$LearningResourcesTableAnnotationComposer(
                $db: $db,
                $table: $db.learningResources,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return composer;
  }

  $$GoalsTableAnnotationComposer get goalId {
    final $$GoalsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.goalId,
      referencedTable: $db.goals,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GoalsTableAnnotationComposer(
            $db: $db,
            $table: $db.goals,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$LearningSessionsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $LearningSessionsTable,
          LearningSession,
          $$LearningSessionsTableFilterComposer,
          $$LearningSessionsTableOrderingComposer,
          $$LearningSessionsTableAnnotationComposer,
          $$LearningSessionsTableCreateCompanionBuilder,
          $$LearningSessionsTableUpdateCompanionBuilder,
          (LearningSession, $$LearningSessionsTableReferences),
          LearningSession,
          PrefetchHooks Function({bool resourceId, bool goalId})
        > {
  $$LearningSessionsTableTableManager(
    _$AppDatabase db,
    $LearningSessionsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$LearningSessionsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$LearningSessionsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$LearningSessionsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> topic = const Value.absent(),
                Value<String?> skill = const Value.absent(),
                Value<int> minutes = const Value.absent(),
                Value<String?> resourceId = const Value.absent(),
                Value<String?> takeaway = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => LearningSessionsCompanion(
                id: id,
                topic: topic,
                skill: skill,
                minutes: minutes,
                resourceId: resourceId,
                takeaway: takeaway,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String topic,
                Value<String?> skill = const Value.absent(),
                required int minutes,
                Value<String?> resourceId = const Value.absent(),
                Value<String?> takeaway = const Value.absent(),
                Value<String?> goalId = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => LearningSessionsCompanion.insert(
                id: id,
                topic: topic,
                skill: skill,
                minutes: minutes,
                resourceId: resourceId,
                takeaway: takeaway,
                goalId: goalId,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$LearningSessionsTable, LearningSession>(table),
                  $$LearningSessionsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({resourceId = false, goalId = false}) {
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
                    if (resourceId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.resourceId,
                        referencedTable: $$LearningSessionsTableReferences
                            ._resourceIdTable(db),
                        referencedColumn: $$LearningSessionsTableReferences
                            ._resourceIdTable(db)
                            .id,
                      ) as T;
                    }
                    if (goalId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.goalId,
                        referencedTable: $$LearningSessionsTableReferences
                            ._goalIdTable(db),
                        referencedColumn: $$LearningSessionsTableReferences
                            ._goalIdTable(db)
                            .id,
                      ) as T;
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

typedef $$LearningSessionsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $LearningSessionsTable,
      LearningSession,
      $$LearningSessionsTableFilterComposer,
      $$LearningSessionsTableOrderingComposer,
      $$LearningSessionsTableAnnotationComposer,
      $$LearningSessionsTableCreateCompanionBuilder,
      $$LearningSessionsTableUpdateCompanionBuilder,
      (LearningSession, $$LearningSessionsTableReferences),
      LearningSession,
      PrefetchHooks Function({bool resourceId, bool goalId})
    >;
typedef $$NotesTableCreateCompanionBuilder = NotesCompanion Function({
  required String id,
  required String body,
  Value<LifeArea?> area,
  required DateTime createdAt,
  Value<int> rowid,
});
typedef $$NotesTableUpdateCompanionBuilder = NotesCompanion Function({
  Value<String> id,
  Value<String> body,
  Value<LifeArea?> area,
  Value<DateTime> createdAt,
  Value<int> rowid,
});

class $$NotesTableFilterComposer extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableFilterComposer({
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

  ColumnFilters<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<LifeArea?, LifeArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$NotesTableOrderingComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableOrderingComposer({
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

  ColumnOrderings<String> get body => $composableBuilder(
    column: $table.body,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$NotesTableAnnotationComposer
    extends Composer<_$AppDatabase, $NotesTable> {
  $$NotesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get body =>
      $composableBuilder(column: $table.body, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LifeArea?, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$NotesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $NotesTable,
          Note,
          $$NotesTableFilterComposer,
          $$NotesTableOrderingComposer,
          $$NotesTableAnnotationComposer,
          $$NotesTableCreateCompanionBuilder,
          $$NotesTableUpdateCompanionBuilder,
          (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
          Note,
          PrefetchHooks Function()
        > {
  $$NotesTableTableManager(_$AppDatabase db, $NotesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$NotesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$NotesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$NotesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> body = const Value.absent(),
                Value<LifeArea?> area = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion(
                id: id,
                body: body,
                area: area,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String body,
                Value<LifeArea?> area = const Value.absent(),
                required DateTime createdAt,
                Value<int> rowid = const Value.absent(),
              }) => NotesCompanion.insert(
                id: id,
                body: body,
                area: area,
                createdAt: createdAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$NotesTable, Note>(table),
                  BaseReferences<_$AppDatabase, $NotesTable, Note>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$NotesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $NotesTable,
      Note,
      $$NotesTableFilterComposer,
      $$NotesTableOrderingComposer,
      $$NotesTableAnnotationComposer,
      $$NotesTableCreateCompanionBuilder,
      $$NotesTableUpdateCompanionBuilder,
      (Note, BaseReferences<_$AppDatabase, $NotesTable, Note>),
      Note,
      PrefetchHooks Function()
    >;
typedef $$WeeklyReviewsTableCreateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      required String weekStart,
      Value<String> wentWellTags,
      Value<String?> wentWellNote,
      Value<String> changeTags,
      Value<String?> changeNote,
      Value<String?> biggestWin,
      Value<String> priorities,
      Value<DateTime?> completedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$WeeklyReviewsTableUpdateCompanionBuilder =
    WeeklyReviewsCompanion Function({
      Value<String> weekStart,
      Value<String> wentWellTags,
      Value<String?> wentWellNote,
      Value<String> changeTags,
      Value<String?> changeNote,
      Value<String?> biggestWin,
      Value<String> priorities,
      Value<DateTime?> completedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$WeeklyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeTags => $composableBuilder(
    column: $table.changeTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$WeeklyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get weekStart => $composableBuilder(
    column: $table.weekStart,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeTags => $composableBuilder(
    column: $table.changeTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$WeeklyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $WeeklyReviewsTable> {
  $$WeeklyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get weekStart =>
      $composableBuilder(column: $table.weekStart, builder: (column) => column);

  GeneratedColumn<String> get wentWellTags => $composableBuilder(
    column: $table.wentWellTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get wentWellNote => $composableBuilder(
    column: $table.wentWellNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeTags => $composableBuilder(
    column: $table.changeTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get changeNote => $composableBuilder(
    column: $table.changeNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get biggestWin => $composableBuilder(
    column: $table.biggestWin,
    builder: (column) => column,
  );

  GeneratedColumn<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$WeeklyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $WeeklyReviewsTable,
          WeeklyReview,
          $$WeeklyReviewsTableFilterComposer,
          $$WeeklyReviewsTableOrderingComposer,
          $$WeeklyReviewsTableAnnotationComposer,
          $$WeeklyReviewsTableCreateCompanionBuilder,
          $$WeeklyReviewsTableUpdateCompanionBuilder,
          (
            WeeklyReview,
            BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>,
          ),
          WeeklyReview,
          PrefetchHooks Function()
        > {
  $$WeeklyReviewsTableTableManager(_$AppDatabase db, $WeeklyReviewsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$WeeklyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$WeeklyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$WeeklyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> weekStart = const Value.absent(),
                Value<String> wentWellTags = const Value.absent(),
                Value<String?> wentWellNote = const Value.absent(),
                Value<String> changeTags = const Value.absent(),
                Value<String?> changeNote = const Value.absent(),
                Value<String?> biggestWin = const Value.absent(),
                Value<String> priorities = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion(
                weekStart: weekStart,
                wentWellTags: wentWellTags,
                wentWellNote: wentWellNote,
                changeTags: changeTags,
                changeNote: changeNote,
                biggestWin: biggestWin,
                priorities: priorities,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String weekStart,
                Value<String> wentWellTags = const Value.absent(),
                Value<String?> wentWellNote = const Value.absent(),
                Value<String> changeTags = const Value.absent(),
                Value<String?> changeNote = const Value.absent(),
                Value<String?> biggestWin = const Value.absent(),
                Value<String> priorities = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => WeeklyReviewsCompanion.insert(
                weekStart: weekStart,
                wentWellTags: wentWellTags,
                wentWellNote: wentWellNote,
                changeTags: changeTags,
                changeNote: changeNote,
                biggestWin: biggestWin,
                priorities: priorities,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$WeeklyReviewsTable, WeeklyReview>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $WeeklyReviewsTable,
                    WeeklyReview
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$WeeklyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $WeeklyReviewsTable,
      WeeklyReview,
      $$WeeklyReviewsTableFilterComposer,
      $$WeeklyReviewsTableOrderingComposer,
      $$WeeklyReviewsTableAnnotationComposer,
      $$WeeklyReviewsTableCreateCompanionBuilder,
      $$WeeklyReviewsTableUpdateCompanionBuilder,
      (
        WeeklyReview,
        BaseReferences<_$AppDatabase, $WeeklyReviewsTable, WeeklyReview>,
      ),
      WeeklyReview,
      PrefetchHooks Function()
    >;
typedef $$MonthlyReviewsTableCreateCompanionBuilder =
    MonthlyReviewsCompanion Function({
      required String monthKey,
      Value<String> proudTags,
      Value<String?> proudNote,
      Value<String> heldBackTags,
      Value<String?> heldBackNote,
      Value<String> differentTags,
      Value<String?> differentNote,
      Value<String?> lesson,
      Value<String> priorities,
      Value<DateTime?> completedAt,
      required DateTime updatedAt,
      Value<int> rowid,
    });
typedef $$MonthlyReviewsTableUpdateCompanionBuilder =
    MonthlyReviewsCompanion Function({
      Value<String> monthKey,
      Value<String> proudTags,
      Value<String?> proudNote,
      Value<String> heldBackTags,
      Value<String?> heldBackNote,
      Value<String> differentTags,
      Value<String?> differentNote,
      Value<String?> lesson,
      Value<String> priorities,
      Value<DateTime?> completedAt,
      Value<DateTime> updatedAt,
      Value<int> rowid,
    });

class $$MonthlyReviewsTableFilterComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proudTags => $composableBuilder(
    column: $table.proudTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get proudNote => $composableBuilder(
    column: $table.proudNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heldBackTags => $composableBuilder(
    column: $table.heldBackTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get heldBackNote => $composableBuilder(
    column: $table.heldBackNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get differentTags => $composableBuilder(
    column: $table.differentTags,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get differentNote => $composableBuilder(
    column: $table.differentNote,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get lesson => $composableBuilder(
    column: $table.lesson,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$MonthlyReviewsTableOrderingComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get monthKey => $composableBuilder(
    column: $table.monthKey,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proudTags => $composableBuilder(
    column: $table.proudTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get proudNote => $composableBuilder(
    column: $table.proudNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heldBackTags => $composableBuilder(
    column: $table.heldBackTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get heldBackNote => $composableBuilder(
    column: $table.heldBackNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get differentTags => $composableBuilder(
    column: $table.differentTags,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get differentNote => $composableBuilder(
    column: $table.differentNote,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get lesson => $composableBuilder(
    column: $table.lesson,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$MonthlyReviewsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MonthlyReviewsTable> {
  $$MonthlyReviewsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get monthKey =>
      $composableBuilder(column: $table.monthKey, builder: (column) => column);

  GeneratedColumn<String> get proudTags =>
      $composableBuilder(column: $table.proudTags, builder: (column) => column);

  GeneratedColumn<String> get proudNote =>
      $composableBuilder(column: $table.proudNote, builder: (column) => column);

  GeneratedColumn<String> get heldBackTags => $composableBuilder(
    column: $table.heldBackTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get heldBackNote => $composableBuilder(
    column: $table.heldBackNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get differentTags => $composableBuilder(
    column: $table.differentTags,
    builder: (column) => column,
  );

  GeneratedColumn<String> get differentNote => $composableBuilder(
    column: $table.differentNote,
    builder: (column) => column,
  );

  GeneratedColumn<String> get lesson =>
      $composableBuilder(column: $table.lesson, builder: (column) => column);

  GeneratedColumn<String> get priorities => $composableBuilder(
    column: $table.priorities,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$MonthlyReviewsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MonthlyReviewsTable,
          MonthlyReview,
          $$MonthlyReviewsTableFilterComposer,
          $$MonthlyReviewsTableOrderingComposer,
          $$MonthlyReviewsTableAnnotationComposer,
          $$MonthlyReviewsTableCreateCompanionBuilder,
          $$MonthlyReviewsTableUpdateCompanionBuilder,
          (
            MonthlyReview,
            BaseReferences<_$AppDatabase, $MonthlyReviewsTable, MonthlyReview>,
          ),
          MonthlyReview,
          PrefetchHooks Function()
        > {
  $$MonthlyReviewsTableTableManager(
    _$AppDatabase db,
    $MonthlyReviewsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MonthlyReviewsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MonthlyReviewsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MonthlyReviewsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> monthKey = const Value.absent(),
                Value<String> proudTags = const Value.absent(),
                Value<String?> proudNote = const Value.absent(),
                Value<String> heldBackTags = const Value.absent(),
                Value<String?> heldBackNote = const Value.absent(),
                Value<String> differentTags = const Value.absent(),
                Value<String?> differentNote = const Value.absent(),
                Value<String?> lesson = const Value.absent(),
                Value<String> priorities = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReviewsCompanion(
                monthKey: monthKey,
                proudTags: proudTags,
                proudNote: proudNote,
                heldBackTags: heldBackTags,
                heldBackNote: heldBackNote,
                differentTags: differentTags,
                differentNote: differentNote,
                lesson: lesson,
                priorities: priorities,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String monthKey,
                Value<String> proudTags = const Value.absent(),
                Value<String?> proudNote = const Value.absent(),
                Value<String> heldBackTags = const Value.absent(),
                Value<String?> heldBackNote = const Value.absent(),
                Value<String> differentTags = const Value.absent(),
                Value<String?> differentNote = const Value.absent(),
                Value<String?> lesson = const Value.absent(),
                Value<String> priorities = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime updatedAt,
                Value<int> rowid = const Value.absent(),
              }) => MonthlyReviewsCompanion.insert(
                monthKey: monthKey,
                proudTags: proudTags,
                proudNote: proudNote,
                heldBackTags: heldBackTags,
                heldBackNote: heldBackNote,
                differentTags: differentTags,
                differentNote: differentNote,
                lesson: lesson,
                priorities: priorities,
                completedAt: completedAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$MonthlyReviewsTable, MonthlyReview>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $MonthlyReviewsTable,
                    MonthlyReview
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$MonthlyReviewsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MonthlyReviewsTable,
      MonthlyReview,
      $$MonthlyReviewsTableFilterComposer,
      $$MonthlyReviewsTableOrderingComposer,
      $$MonthlyReviewsTableAnnotationComposer,
      $$MonthlyReviewsTableCreateCompanionBuilder,
      $$MonthlyReviewsTableUpdateCompanionBuilder,
      (
        MonthlyReview,
        BaseReferences<_$AppDatabase, $MonthlyReviewsTable, MonthlyReview>,
      ),
      MonthlyReview,
      PrefetchHooks Function()
    >;
typedef $$RemindersTableCreateCompanionBuilder = RemindersCompanion Function({
  required String id,
  required ReminderKind kind,
  Value<bool> enabled,
  required int minuteOfDay,
  Value<int> weekdays,
  Value<String?> habitId,
  Value<int> rowid,
});
typedef $$RemindersTableUpdateCompanionBuilder = RemindersCompanion Function({
  Value<String> id,
  Value<ReminderKind> kind,
  Value<bool> enabled,
  Value<int> minuteOfDay,
  Value<int> weekdays,
  Value<String?> habitId,
  Value<int> rowid,
});

final class $$RemindersTableReferences
    extends BaseReferences<_$AppDatabase, $RemindersTable, Reminder> {
  $$RemindersTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $HabitsTable _habitIdTable(_$AppDatabase db) =>
      db.habits.createAlias('reminders__habit_id__habits__id');

  $$HabitsTableProcessedTableManager? get habitId {
    final $_column = $_itemColumn<String>('habit_id');
    if ($_column == null) return null;
    final manager = $$HabitsTableTableManager(
      $_db,
      $_db.habits,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_habitIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RemindersTableFilterComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableFilterComposer({
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

  ColumnWithTypeConverterFilters<ReminderKind, ReminderKind, String> get kind =>
      $composableBuilder(
        column: $table.kind,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnFilters(column),
  );

  $$HabitsTableFilterComposer get habitId {
    final $$HabitsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableFilterComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableOrderingComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableOrderingComposer({
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

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get enabled => $composableBuilder(
    column: $table.enabled,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get weekdays => $composableBuilder(
    column: $table.weekdays,
    builder: (column) => ColumnOrderings(column),
  );

  $$HabitsTableOrderingComposer get habitId {
    final $$HabitsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableOrderingComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableAnnotationComposer
    extends Composer<_$AppDatabase, $RemindersTable> {
  $$RemindersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ReminderKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<bool> get enabled =>
      $composableBuilder(column: $table.enabled, builder: (column) => column);

  GeneratedColumn<int> get minuteOfDay => $composableBuilder(
    column: $table.minuteOfDay,
    builder: (column) => column,
  );

  GeneratedColumn<int> get weekdays =>
      $composableBuilder(column: $table.weekdays, builder: (column) => column);

  $$HabitsTableAnnotationComposer get habitId {
    final $$HabitsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.habitId,
      referencedTable: $db.habits,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$HabitsTableAnnotationComposer(
            $db: $db,
            $table: $db.habits,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RemindersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RemindersTable,
          Reminder,
          $$RemindersTableFilterComposer,
          $$RemindersTableOrderingComposer,
          $$RemindersTableAnnotationComposer,
          $$RemindersTableCreateCompanionBuilder,
          $$RemindersTableUpdateCompanionBuilder,
          (Reminder, $$RemindersTableReferences),
          Reminder,
          PrefetchHooks Function({bool habitId})
        > {
  $$RemindersTableTableManager(_$AppDatabase db, $RemindersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RemindersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RemindersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RemindersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<ReminderKind> kind = const Value.absent(),
                Value<bool> enabled = const Value.absent(),
                Value<int> minuteOfDay = const Value.absent(),
                Value<int> weekdays = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion(
                id: id,
                kind: kind,
                enabled: enabled,
                minuteOfDay: minuteOfDay,
                weekdays: weekdays,
                habitId: habitId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required ReminderKind kind,
                Value<bool> enabled = const Value.absent(),
                required int minuteOfDay,
                Value<int> weekdays = const Value.absent(),
                Value<String?> habitId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => RemindersCompanion.insert(
                id: id,
                kind: kind,
                enabled: enabled,
                minuteOfDay: minuteOfDay,
                weekdays: weekdays,
                habitId: habitId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RemindersTable, Reminder>(table),
                  $$RemindersTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({habitId = false}) {
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
                    if (habitId) {
                      state = state.withJoin(
                        currentTable: table,
                        currentColumn: table.habitId,
                        referencedTable: $$RemindersTableReferences
                            ._habitIdTable(db),
                        referencedColumn: $$RemindersTableReferences
                            ._habitIdTable(db)
                            .id,
                      ) as T;
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

typedef $$RemindersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RemindersTable,
      Reminder,
      $$RemindersTableFilterComposer,
      $$RemindersTableOrderingComposer,
      $$RemindersTableAnnotationComposer,
      $$RemindersTableCreateCompanionBuilder,
      $$RemindersTableUpdateCompanionBuilder,
      (Reminder, $$RemindersTableReferences),
      Reminder,
      PrefetchHooks Function({bool habitId})
    >;
typedef $$ActivityEventsTableCreateCompanionBuilder =
    ActivityEventsCompanion Function({
      required String id,
      Value<LifeArea?> area,
      required ActivityType type,
      required String title,
      Value<String?> subtitle,
      Value<int?> amountMinor,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<String?> facts,
      required DateTime occurredAt,
      Value<int> rowid,
    });
typedef $$ActivityEventsTableUpdateCompanionBuilder =
    ActivityEventsCompanion Function({
      Value<String> id,
      Value<LifeArea?> area,
      Value<ActivityType> type,
      Value<String> title,
      Value<String?> subtitle,
      Value<int?> amountMinor,
      Value<String?> entityType,
      Value<String?> entityId,
      Value<String?> facts,
      Value<DateTime> occurredAt,
      Value<int> rowid,
    });

class $$ActivityEventsTableFilterComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<LifeArea?, LifeArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<ActivityType, ActivityType, String> get type =>
      $composableBuilder(
        column: $table.type,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get facts => $composableBuilder(
    column: $table.facts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ActivityEventsTableOrderingComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableOrderingComposer({
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

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get type => $composableBuilder(
    column: $table.type,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get subtitle => $composableBuilder(
    column: $table.subtitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get entityId => $composableBuilder(
    column: $table.entityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get facts => $composableBuilder(
    column: $table.facts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ActivityEventsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ActivityEventsTable> {
  $$ActivityEventsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<LifeArea?, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumnWithTypeConverter<ActivityType, String> get type =>
      $composableBuilder(column: $table.type, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get subtitle =>
      $composableBuilder(column: $table.subtitle, builder: (column) => column);

  GeneratedColumn<int> get amountMinor => $composableBuilder(
    column: $table.amountMinor,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityType => $composableBuilder(
    column: $table.entityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get entityId =>
      $composableBuilder(column: $table.entityId, builder: (column) => column);

  GeneratedColumn<String> get facts =>
      $composableBuilder(column: $table.facts, builder: (column) => column);

  GeneratedColumn<DateTime> get occurredAt => $composableBuilder(
    column: $table.occurredAt,
    builder: (column) => column,
  );
}

class $$ActivityEventsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ActivityEventsTable,
          ActivityEvent,
          $$ActivityEventsTableFilterComposer,
          $$ActivityEventsTableOrderingComposer,
          $$ActivityEventsTableAnnotationComposer,
          $$ActivityEventsTableCreateCompanionBuilder,
          $$ActivityEventsTableUpdateCompanionBuilder,
          (
            ActivityEvent,
            BaseReferences<_$AppDatabase, $ActivityEventsTable, ActivityEvent>,
          ),
          ActivityEvent,
          PrefetchHooks Function()
        > {
  $$ActivityEventsTableTableManager(
    _$AppDatabase db,
    $ActivityEventsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ActivityEventsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ActivityEventsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ActivityEventsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<LifeArea?> area = const Value.absent(),
                Value<ActivityType> type = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> subtitle = const Value.absent(),
                Value<int?> amountMinor = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String?> facts = const Value.absent(),
                Value<DateTime> occurredAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ActivityEventsCompanion(
                id: id,
                area: area,
                type: type,
                title: title,
                subtitle: subtitle,
                amountMinor: amountMinor,
                entityType: entityType,
                entityId: entityId,
                facts: facts,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                Value<LifeArea?> area = const Value.absent(),
                required ActivityType type,
                required String title,
                Value<String?> subtitle = const Value.absent(),
                Value<int?> amountMinor = const Value.absent(),
                Value<String?> entityType = const Value.absent(),
                Value<String?> entityId = const Value.absent(),
                Value<String?> facts = const Value.absent(),
                required DateTime occurredAt,
                Value<int> rowid = const Value.absent(),
              }) => ActivityEventsCompanion.insert(
                id: id,
                area: area,
                type: type,
                title: title,
                subtitle: subtitle,
                amountMinor: amountMinor,
                entityType: entityType,
                entityId: entityId,
                facts: facts,
                occurredAt: occurredAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ActivityEventsTable, ActivityEvent>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $ActivityEventsTable,
                    ActivityEvent
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$ActivityEventsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ActivityEventsTable,
      ActivityEvent,
      $$ActivityEventsTableFilterComposer,
      $$ActivityEventsTableOrderingComposer,
      $$ActivityEventsTableAnnotationComposer,
      $$ActivityEventsTableCreateCompanionBuilder,
      $$ActivityEventsTableUpdateCompanionBuilder,
      (
        ActivityEvent,
        BaseReferences<_$AppDatabase, $ActivityEventsTable, ActivityEvent>,
      ),
      ActivityEvent,
      PrefetchHooks Function()
    >;
typedef $$AppSettingsTableCreateCompanionBuilder =
    AppSettingsCompanion Function({
      required String key,
      required String value,
      Value<int> rowid,
    });
typedef $$AppSettingsTableUpdateCompanionBuilder =
    AppSettingsCompanion Function({
      Value<String> key,
      Value<String> value,
      Value<int> rowid,
    });

class $$AppSettingsTableFilterComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AppSettingsTableOrderingComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get key => $composableBuilder(
    column: $table.key,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get value => $composableBuilder(
    column: $table.value,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AppSettingsTableAnnotationComposer
    extends Composer<_$AppDatabase, $AppSettingsTable> {
  $$AppSettingsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get key =>
      $composableBuilder(column: $table.key, builder: (column) => column);

  GeneratedColumn<String> get value =>
      $composableBuilder(column: $table.value, builder: (column) => column);
}

class $$AppSettingsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $AppSettingsTable,
          AppSetting,
          $$AppSettingsTableFilterComposer,
          $$AppSettingsTableOrderingComposer,
          $$AppSettingsTableAnnotationComposer,
          $$AppSettingsTableCreateCompanionBuilder,
          $$AppSettingsTableUpdateCompanionBuilder,
          (
            AppSetting,
            BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
          ),
          AppSetting,
          PrefetchHooks Function()
        > {
  $$AppSettingsTableTableManager(_$AppDatabase db, $AppSettingsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$AppSettingsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$AppSettingsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$AppSettingsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback: ({
            Value<String> key = const Value.absent(),
            Value<String> value = const Value.absent(),
            Value<int> rowid = const Value.absent(),
          }) => AppSettingsCompanion(key: key, value: value, rowid: rowid),
          createCompanionCallback:
              ({
                required String key,
                required String value,
                Value<int> rowid = const Value.absent(),
              }) => AppSettingsCompanion.insert(
                key: key,
                value: value,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$AppSettingsTable, AppSetting>(table),
                  BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AppSettingsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $AppSettingsTable,
      AppSetting,
      $$AppSettingsTableFilterComposer,
      $$AppSettingsTableOrderingComposer,
      $$AppSettingsTableAnnotationComposer,
      $$AppSettingsTableCreateCompanionBuilder,
      $$AppSettingsTableUpdateCompanionBuilder,
      (
        AppSetting,
        BaseReferences<_$AppDatabase, $AppSettingsTable, AppSetting>,
      ),
      AppSetting,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$UserProfilesTableTableManager get userProfiles =>
      $$UserProfilesTableTableManager(_db, _db.userProfiles);
  $$GoalsTableTableManager get goals =>
      $$GoalsTableTableManager(_db, _db.goals);
  $$GoalActionsTableTableManager get goalActions =>
      $$GoalActionsTableTableManager(_db, _db.goalActions);
  $$GoalMilestonesTableTableManager get goalMilestones =>
      $$GoalMilestonesTableTableManager(_db, _db.goalMilestones);
  $$GoalProgressEventsTableTableManager get goalProgressEvents =>
      $$GoalProgressEventsTableTableManager(_db, _db.goalProgressEvents);
  $$TasksTableTableManager get tasks =>
      $$TasksTableTableManager(_db, _db.tasks);
  $$MorningCheckInsTableTableManager get morningCheckIns =>
      $$MorningCheckInsTableTableManager(_db, _db.morningCheckIns);
  $$NightReviewsTableTableManager get nightReviews =>
      $$NightReviewsTableTableManager(_db, _db.nightReviews);
  $$QuranLogsTableTableManager get quranLogs =>
      $$QuranLogsTableTableManager(_db, _db.quranLogs);
  $$WorkActivitiesTableTableManager get workActivities =>
      $$WorkActivitiesTableTableManager(_db, _db.workActivities);
  $$FinanceTransactionsTableTableManager get financeTransactions =>
      $$FinanceTransactionsTableTableManager(_db, _db.financeTransactions);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$HabitLogsTableTableManager get habitLogs =>
      $$HabitLogsTableTableManager(_db, _db.habitLogs);
  $$WorkoutLogsTableTableManager get workoutLogs =>
      $$WorkoutLogsTableTableManager(_db, _db.workoutLogs);
  $$WalkingLogsTableTableManager get walkingLogs =>
      $$WalkingLogsTableTableManager(_db, _db.walkingLogs);
  $$SleepLogsTableTableManager get sleepLogs =>
      $$SleepLogsTableTableManager(_db, _db.sleepLogs);
  $$LearningResourcesTableTableManager get learningResources =>
      $$LearningResourcesTableTableManager(_db, _db.learningResources);
  $$LearningSessionsTableTableManager get learningSessions =>
      $$LearningSessionsTableTableManager(_db, _db.learningSessions);
  $$NotesTableTableManager get notes =>
      $$NotesTableTableManager(_db, _db.notes);
  $$WeeklyReviewsTableTableManager get weeklyReviews =>
      $$WeeklyReviewsTableTableManager(_db, _db.weeklyReviews);
  $$MonthlyReviewsTableTableManager get monthlyReviews =>
      $$MonthlyReviewsTableTableManager(_db, _db.monthlyReviews);
  $$RemindersTableTableManager get reminders =>
      $$RemindersTableTableManager(_db, _db.reminders);
  $$ActivityEventsTableTableManager get activityEvents =>
      $$ActivityEventsTableTableManager(_db, _db.activityEvents);
  $$AppSettingsTableTableManager get appSettings =>
      $$AppSettingsTableTableManager(_db, _db.appSettings);
}
