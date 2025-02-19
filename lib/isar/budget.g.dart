// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'budget.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetBudgetCollection on Isar {
  IsarCollection<Budget> get budgets => this.collection();
}

const BudgetSchema = CollectionSchema(
  name: r'Budget',
  id: -3383598594604670326,
  properties: {
    r'budgetName': PropertySchema(
      id: 0,
      name: r'budgetName',
      type: IsarType.string,
    ),
    r'entriesListJSON': PropertySchema(
      id: 1,
      name: r'entriesListJSON',
      type: IsarType.string,
    )
  },
  estimateSize: _budgetEstimateSize,
  serialize: _budgetSerialize,
  deserialize: _budgetDeserialize,
  deserializeProp: _budgetDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {},
  getId: _budgetGetId,
  getLinks: _budgetGetLinks,
  attach: _budgetAttach,
  version: '3.1.0+1',
);

int _budgetEstimateSize(
  Budget object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.budgetName.length * 3;
  bytesCount += 3 + object.entriesListJSON.length * 3;
  return bytesCount;
}

void _budgetSerialize(
  Budget object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.budgetName);
  writer.writeString(offsets[1], object.entriesListJSON);
}

Budget _budgetDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Budget();
  object.budgetName = reader.readString(offsets[0]);
  object.entriesListJSON = reader.readString(offsets[1]);
  object.id = id;
  return object;
}

P _budgetDeserializeProp<P>(
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

Id _budgetGetId(Budget object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _budgetGetLinks(Budget object) {
  return [];
}

void _budgetAttach(IsarCollection<dynamic> col, Id id, Budget object) {
  object.id = id;
}

extension BudgetQueryWhereSort on QueryBuilder<Budget, Budget, QWhere> {
  QueryBuilder<Budget, Budget, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension BudgetQueryWhere on QueryBuilder<Budget, Budget, QWhereClause> {
  QueryBuilder<Budget, Budget, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Budget, Budget, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Budget, Budget, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Budget, Budget, QAfterWhereClause> idBetween(
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

extension BudgetQueryFilter on QueryBuilder<Budget, Budget, QFilterCondition> {
  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'budgetName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'budgetName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'budgetName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'budgetName',
        value: '',
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> budgetNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'budgetName',
        value: '',
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition>
      entriesListJSONGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'entriesListJSON',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'entriesListJSON',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'entriesListJSON',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> entriesListJSONIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'entriesListJSON',
        value: '',
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition>
      entriesListJSONIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'entriesListJSON',
        value: '',
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Budget, Budget, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Budget, Budget, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Budget, Budget, QAfterFilterCondition> idBetween(
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

extension BudgetQueryObject on QueryBuilder<Budget, Budget, QFilterCondition> {}

extension BudgetQueryLinks on QueryBuilder<Budget, Budget, QFilterCondition> {}

extension BudgetQuerySortBy on QueryBuilder<Budget, Budget, QSortBy> {
  QueryBuilder<Budget, Budget, QAfterSortBy> sortByBudgetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budgetName', Sort.asc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> sortByBudgetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budgetName', Sort.desc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> sortByEntriesListJSON() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesListJSON', Sort.asc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> sortByEntriesListJSONDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesListJSON', Sort.desc);
    });
  }
}

extension BudgetQuerySortThenBy on QueryBuilder<Budget, Budget, QSortThenBy> {
  QueryBuilder<Budget, Budget, QAfterSortBy> thenByBudgetName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budgetName', Sort.asc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> thenByBudgetNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'budgetName', Sort.desc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> thenByEntriesListJSON() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesListJSON', Sort.asc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> thenByEntriesListJSONDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'entriesListJSON', Sort.desc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Budget, Budget, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension BudgetQueryWhereDistinct on QueryBuilder<Budget, Budget, QDistinct> {
  QueryBuilder<Budget, Budget, QDistinct> distinctByBudgetName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'budgetName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Budget, Budget, QDistinct> distinctByEntriesListJSON(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'entriesListJSON',
          caseSensitive: caseSensitive);
    });
  }
}

extension BudgetQueryProperty on QueryBuilder<Budget, Budget, QQueryProperty> {
  QueryBuilder<Budget, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Budget, String, QQueryOperations> budgetNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'budgetName');
    });
  }

  QueryBuilder<Budget, String, QQueryOperations> entriesListJSONProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'entriesListJSON');
    });
  }
}
