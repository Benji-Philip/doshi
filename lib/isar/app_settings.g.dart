// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_settings.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetAppSettingEntryCollection on Isar {
  IsarCollection<AppSettingEntry> get appSettingEntrys => this.collection();
}

const AppSettingEntrySchema = CollectionSchema(
  name: r'AppSettingEntry',
  id: 4120770329653977408,
  properties: {
    r'appSettingName': PropertySchema(
      id: 0,
      name: r'appSettingName',
      type: IsarType.string,
    ),
    r'appSettingValue': PropertySchema(
      id: 1,
      name: r'appSettingValue',
      type: IsarType.string,
    )
  },
  estimateSize: _appSettingEntryEstimateSize,
  serialize: _appSettingEntrySerialize,
  deserialize: _appSettingEntryDeserialize,
  deserializeProp: _appSettingEntryDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _appSettingEntryGetId,
  getLinks: _appSettingEntryGetLinks,
  attach: _appSettingEntryAttach,
  version: '3.1.0+1',
);

int _appSettingEntryEstimateSize(
  AppSettingEntry object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.appSettingName.length * 3;
  bytesCount += 3 + object.appSettingValue.length * 3;
  return bytesCount;
}

void _appSettingEntrySerialize(
  AppSettingEntry object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.appSettingName);
  writer.writeString(offsets[1], object.appSettingValue);
}

AppSettingEntry _appSettingEntryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = AppSettingEntry();
  object.appSettingName = reader.readString(offsets[0]);
  object.appSettingValue = reader.readString(offsets[1]);
  object.id = id;
  return object;
}

P _appSettingEntryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _appSettingEntryGetId(AppSettingEntry object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _appSettingEntryGetLinks(AppSettingEntry object) {
  return [];
}

void _appSettingEntryAttach(
    IsarCollection<dynamic> col, Id id, AppSettingEntry object) {
  object.id = id;
}

extension AppSettingEntryQueryWhereSort
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QWhere> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension AppSettingEntryQueryWhere
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QWhereClause> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingEntryQueryFilter
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QFilterCondition> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appSettingName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appSettingName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appSettingName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appSettingName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appSettingName',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'appSettingValue',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'appSettingValue',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'appSettingValue',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'appSettingValue',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      appSettingValueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'appSettingValue',
        value: '',
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterFilterCondition>
      idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension AppSettingEntryQueryObject
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QFilterCondition> {}

extension AppSettingEntryQueryLinks
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QFilterCondition> {}

extension AppSettingEntryQuerySortBy
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QSortBy> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      sortByAppSettingName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingName', Sort.asc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      sortByAppSettingNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingName', Sort.desc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      sortByAppSettingValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingValue', Sort.asc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      sortByAppSettingValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingValue', Sort.desc);
    });
  }
}

extension AppSettingEntryQuerySortThenBy
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QSortThenBy> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      thenByAppSettingName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingName', Sort.asc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      thenByAppSettingNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingName', Sort.desc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      thenByAppSettingValue() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingValue', Sort.asc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy>
      thenByAppSettingValueDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'appSettingValue', Sort.desc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension AppSettingEntryQueryWhereDistinct
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QDistinct> {
  QueryBuilder<AppSettingEntry, AppSettingEntry, QDistinct>
      distinctByAppSettingName({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appSettingName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<AppSettingEntry, AppSettingEntry, QDistinct>
      distinctByAppSettingValue({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'appSettingValue',
          caseSensitive: caseSensitive);
    });
  }
}

extension AppSettingEntryQueryProperty
    on QueryBuilder<AppSettingEntry, AppSettingEntry, QQueryProperty> {
  QueryBuilder<AppSettingEntry, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<AppSettingEntry, String, QQueryOperations>
      appSettingNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appSettingName');
    });
  }

  QueryBuilder<AppSettingEntry, String, QQueryOperations>
      appSettingValueProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'appSettingValue');
    });
  }
}
